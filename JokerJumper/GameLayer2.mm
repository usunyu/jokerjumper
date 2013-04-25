#import "BackgroundLayer.h"
#import "GameLayer2.h"
#import "CCBReader.h"
#import "SimpleAudioEngine.h"
#import "GLES-Render.h"
#import "GameObject.h"
#import "HUDLayer.h"
#import "Constants.h"
#import "Joker.h"
#import "GameWinScene.h"
#import "GameOverScene.h"

@class GameObject;

@interface GameLayer2()
@end

@implementation GameLayer2
@synthesize world;
@synthesize fallPos;
@synthesize joker;
@synthesize ghost;
@synthesize moon;
@synthesize distance;
@synthesize fall1;
@synthesize fall2;
@synthesize hand1;
@synthesize hand2;
@synthesize hand3;
@synthesize flowerBatchNode;
@synthesize flyPos;
@synthesize brick1BatchNode;
@synthesize brick2BatchNode;
@synthesize brick3BatchNode;
@synthesize diamondBatchNode;
@synthesize heartBatchNode;
@synthesize ghostBatchNode;
@synthesize stoneBatchNode;
@synthesize flyBatchNode;
@synthesize leafBatchNode;
@synthesize skullBatchNode;
@synthesize moonBatchNode;
@synthesize fly;
@synthesize emeny;
@synthesize stateVec;
@synthesize jumpVec;
@synthesize hudLayer;
@synthesize positionVec;

NSString *map2 = @"map_lv2_trial2.tmx";

bool gravity2 = false;

+(GameLayer2*) getGameLayer2 {
    return self;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    lastLastAccelerationY = lastAccelerationY;
    lastAccelerationY = accelerationY;
    accelerationY = acceleration.x*10;
}

-(void)updateAcceleration {
    //    CCLOG(@"###############%d",lastAccelerationY);
    
    //    if(lastAccelerationY >= 4 && lastAccelerationY <= 6)
    {
        if(!joker.jokerFlip) {
            if(lastLastAccelerationY - accelerationY >= 2) {
                if(!joker.jokerJumping)
                {
                    joker.jokerBody->SetGravityScale(-joker.jokerBody->GetGravityScale());
                    State curState={joker.position,joker.jokerBody->GetLinearVelocity(),joker.jokerBody->GetGravityScale(),joker.jokerFlip};
                    stateVec.push_back(curState);
                    //world->SetGravity(b2Vec2(0.0,-world->GetGravity().y));
                    [joker jump:jokerCharge];
                    jumpVec=b2Vec2(joker.jokerBody->GetLinearVelocity().x,0);
                }
            }
        }
        else {
            if(accelerationY - lastLastAccelerationY >= 2) {
                if(!joker.jokerJumping)
                {
                    joker.jokerBody->SetGravityScale(-joker.jokerBody->GetGravityScale());
                    State curState={joker.position,joker.jokerBody->GetLinearVelocity(),joker.jokerBody->GetGravityScale(),joker.jokerFlip};
                    stateVec.push_back(curState);
                    //world->SetGravity(b2Vec2(0.0,-world->GetGravity().y));
                    [joker jump:jokerCharge];
                    jumpVec=b2Vec2(joker.jokerBody->GetLinearVelocity().x,0);
                    jokerStartCharge = false;
                }
            }
        }
    }
}

-(CGRect) positionRect: (CCSprite*)mySprite
{
    return CGRectMake(mySprite.position.x - (mySprite.contentSize.width*mySprite.scale) /2, mySprite.position.y - (mySprite.contentSize.height*mySprite.scale) / 2, (mySprite.contentSize.width*mySprite.scale), (mySprite.contentSize.height*mySprite.scale));
}

- (void)preLoadSoundFiles
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Jump.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Collect_Coin.wav"];
    SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
    if (sae != nil) {
        [sae preloadBackgroundMusic:@"1.wav"];
        if (sae.willPlayBackgroundMusic) {
            sae.backgroundMusicVolume = 0.5f;
        }
    }
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"1.wav"];
}

- (void) initTiledMaps {
    //    NSMutableArray *mapArray = [[NSMutableArray alloc] initWithCapacity:MAP_LEVEL1_NUMS];
    for(int i = 0; i < MAP_LEVEL2_NUMS; i++) {
        CCTMXTiledMap *tileMapNode = [CCTMXTiledMap tiledMapWithTMXFile:map2];
        CCLOG(@"here2");
        tileMapNode.anchorPoint = ccp(0, 0);
        CCLOG(@"here3");
        int offset = MAP_LENGTH * PTM_RATIO * i;
        CCLOG(@"here4");
        tileMapNode.position = ccp(offset, 0);
        CCLOG(@"here5");
        tileMapNode.scale = 2;
        CCLOG(@"here6");
        [self addChild:tileMapNode z:-1];
        CCLOG(@"here7");
        [self drawCollisions:tileMapNode withOffset:offset];
        CCLOG(@"here8");
    }
}

- (void) drawCollisions:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
    CCLOG(@"here.1");
    [self drawCoinTiles:tileMapNode withOffset:offset];
    CCLOG(@"here.2");
    [self drawCoin1Tiles:tileMapNode withOffset:offset];
    CCLOG(@"here.3");
    [self drawCoin2Tiles:tileMapNode withOffset:offset];
    CCLOG(@"here.4");
    [self drawCoin3Tiles:tileMapNode withOffset:offset];
    //[self drawFlowerTiles:tileMapNode withOffset:offset];
    CCLOG(@"here.5");
    [self drawCollision1Tiles:tileMapNode withOffset:offset];
    CCLOG(@"here.6");
    //[self drawCollision2Tiles:tileMapNode withOffset:offset];
    CCLOG(@"here.7");
    [self drawCollision3Tiles:tileMapNode withOffset:offset];
    CCLOG(@"here.8");
    [self drawCollision4Tiles:tileMapNode withOffset:offset];
    CCLOG(@"here.9");
    [self drawCollision5Tiles:tileMapNode withOffset:offset];
    CCLOG(@"here1.0");
    [self drawCollision6Tiles:tileMapNode withOffset:offset];
}

//---------------------------------- create the box2d object----------------------------------//
- (void) makeBox2dObjAt:(CGPoint)p
			   withSize:(CGPoint)size
				dynamic:(BOOL)d
			   rotation:(long)r
			   friction:(long)f
				density:(long)dens
			restitution:(long)rest
				  boxId:(int)boxId
               bodyType:(GameObjectType)type
{
    
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
    
	if(d)
		bodyDef.type = b2_dynamicBody;
    if(type==kGameObjectFalling)
        bodyDef.type=b2_kinematicBody;
    
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    if(IS_PLAT(type))
        bodyDef.gravityScale = 0.0f;
    GameObject* platform;
    CCAction *Action;
    NSMutableArray *animFrames = [NSMutableArray array];
    CCAnimation *Animation;
    
    if(type==kGameObjectCoin)
    {
        platform=[[GameObject alloc] init];
        for(int i = 0; i <= 11; ++i) {
            [animFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"diamond%d.png",i]]];
        }
        Animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.5f];
        Action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: Animation]];
        [platform setTexture:[diamondBatchNode texture]];
        [platform runAction:Action];
        //platform=[[GameObject alloc] init];
        [platform setType:type];
        [diamondBatchNode addChild:platform z:3];
        
        //platform = [GameObject spriteWithFile:@"club.png"];
        /*
         id lens = [CCLens3D actionWithPosition:ccp(240,160) radius:240 grid:ccg(15,10) duration:8];
         id waves = [CCWaves3D actionWithWaves:18 amplitude:80 grid:ccg(15,10) duration:10];
         [platform runAction: [CCRepeatForever actionWithAction: [CCSequence actions: waves, lens, nil]]];
         */
        //[platform setType:type];
        //[self addChild:platform z:3];
    }
    else if(type==kGameObjectCoin1)
    {
        platform=[[GameObject alloc] init];
        for(int i = 0; i <= 11; ++i) {
            [animFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"heart%d.png",i]]];
        }
        Animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.5f];
        Action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: Animation]];
        [platform setTexture:[heartBatchNode texture]];
        [platform runAction:Action];
        //platform=[[GameObject alloc] init];
        [platform setType:type];
        [heartBatchNode addChild:platform z:4];
        
    }
    else if(type==kGameObjectPlatform1)
    {
        platform=[[GameObject alloc] init];
        [platform setTexture:[stoneBatchNode texture]];
        for(int i = 0; i <= 12; ++i) {
            [animFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"brick_stone_smile%d.png",i]]];
        }
        Animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.2f];
        Action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: Animation]];
        [platform runAction:Action];
        //platform=[[GameObject alloc] init];
        [platform setType:type];
        [stoneBatchNode addChild:platform z:2];
    }
    else if(type==kGameObjectPlatform2)
    {
        platform=[[GameObject alloc] init];
        //platform = [GameObject spriteWithFile:@"brick_grass_hd.png"];
        //        [platform setVisible:false];
        [platform setType:type];
        [self addChild:platform z:5];
        /*platform=[[GameObject alloc] init];
         for(int i = 1; i <= 4; ++i) {
         [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
         [NSString stringWithFormat:@"brik1_%d_hd.png",i]]];
         }
         Animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.05f];
         Action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: Animation]];
         [platform setTexture:[brick2BatchNode texture]];
         [platform runAction:Action];
         [platform setType:type];
         [brick2BatchNode addChild:platform z:2];
         */
    }
    else if(type==kGameObjectStone)
    {
        platform=[[GameObject alloc] init];
        [platform setTexture:[stoneBatchNode texture]];
        for(int i = 0; i <= 12; ++i) {
            [animFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"brick_stone_smile%d.png",i]]];
        }
        Animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.1f];
        Action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: Animation]];
        [platform runAction:Action];
        //platform=[[GameObject alloc] init];
        [platform setType:type];
        [stoneBatchNode addChild:platform z:2];
    }
    else if(type==kGameObjectFlower)
    {
        platform = [GameObject spriteWithSpriteFrameName:@"zombie_hand0.png"];
        [platform setType:type];
        [platform setVisible:false];
        [self addChild:platform z:2];
    }
    else if(type==kGameObjectPlatform3)
    {
        platform = [GameObject spriteWithFile:@"brick_club_hd.png"];
        [platform setType:type];
        [self addChild:platform z:10];
        
        /* platform=[[GameObject alloc] init];
         for(int i = 1; i <= 4; ++i) {
         [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
         [NSString stringWithFormat:@"brick2_%d_hd.png",i]]];
         }
         Animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.1f];
         Action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: Animation]];
         [platform setTexture:[brick3BatchNode texture]];
         [platform runAction:Action];
         [platform setType:type];
         [brick3BatchNode addChild:platform z:2];
         */
    }
    else if(type==kGameObjectPlatform4)
    {
        platform=[[GameObject alloc] init];
        //platform = [GameObject spriteWithFile:@"brick_wood_hd.png"];
        [platform setType:type];
        [self addChild:platform z:2];
        CCLOG(@"x: %f y: %f",size.x,size.y);
    }
    else if(type==kGameObjectDisable)
    {
        platform=[[GameObject alloc] init];
        //platform = [GameObject spriteWithFile:@"brick_wood_hd.png"];
        [platform setType:type];
        [self addChild:platform z:2];
    }
    //---------------------------create the box2d object: magic props------------------------//
    else if(type==kGameObjectCoin2)
    {
        platform = [GameObject spriteWithFile:@"club.png"];
        [platform setType:type];
        [self addChild:platform z:5];
    }
    else if(type==kGameObjectCoin3)
    {
        platform = [GameObject spriteWithFile:@"spade.png"];
        [platform setType:type];
        [self addChild:platform z:6];
    }
    else if(type==kGameObjectFalling)
    {
        platform = [GameObject spriteWithFile:@"coffin.png"];
        [platform setType:type];
        [self addChild:platform z:8];
    }
    
	bodyDef.userData = (__bridge_retained void*) platform;
    
	b2Body *body = world->CreateBody(&bodyDef);
    
	// Define another box shape for our dynamic body.
	b2PolygonShape dynamicBox;
	dynamicBox.SetAsBox(size.x/2/PTM_RATIO, size.y/2/PTM_RATIO);
    
    
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.density = dens;
    if(IS_COIN(type))
    {
        body->SetGravityScale(0);
        fixtureDef.isSensor=true;
    }
    if(type==kGameObjectFalling)
    {
        //fixtureDef.isSensor=true;
        body->SetLinearVelocity(b2Vec2(0,-2.5f));
    }
    if(type==kGameObjectPlatform3)
    {
        body->SetGravityScale(0);
    }
	fixtureDef.friction = f;
	fixtureDef.restitution = rest;
	body->CreateFixture(&fixtureDef);
}

//----------------------------- detect the collision of map-----------------------------//

/*
 * draw brick_grass collision layer
 */
- (void) drawCollision1Tiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"brick_grass"];
	NSMutableDictionary * objPoint;
    
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue]+offset;
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
        
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:false
					rotation:0
					friction:0.0f
					 density:0.0f
				 restitution:0.0f
					   boxId:-1
                    bodyType:kGameObjectPlatform2];
	}
}

/*
 * draw brick_ice collision layer
 */
- (void) drawCollision2Tiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"brick_ice"];
	NSMutableDictionary * objPoint;
    
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue]+offset;
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
        
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:false
					rotation:0
					friction:0.0f
					 density:0.0f
				 restitution:0
					   boxId:-1
                    bodyType:kGameObjectPlatform1];
	}
}

/*
 * draw brick_dice collision layer
 */
- (void) drawCollision3Tiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"brick_dice"];
	NSMutableDictionary * objPoint;
    
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue]+offset;
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
        
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:true
					rotation:0
					friction:0.0f
					 density:DICE_DENSITY
				 restitution:0
					   boxId:-1
                    bodyType:kGameObjectPlatform3];
	}
}


/*
 * draw brick_wood collision layer
 */
- (void) drawCollision4Tiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
    CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"brick_wood"];
    NSMutableDictionary * objPoint;
    
    float x, y, w, h;
    for (objPoint in [objects objects]) {
        x = [[objPoint valueForKey:@"x"] intValue]+offset;
        y = [[objPoint valueForKey:@"y"] intValue];
        w = [[objPoint valueForKey:@"width"] intValue];
        h = [[objPoint valueForKey:@"height"] intValue];
        
        CGPoint _point=ccp(x+w/2,y+h/2);
        CGPoint _size=ccp(w,h);
        
        [self makeBox2dObjAt:_point
                    withSize:_size
                     dynamic:false
                    rotation:0
                    friction:0.0f
                     density:0.0f
                 restitution:0
                       boxId:-1
                    bodyType:kGameObjectPlatform4];
    }
}

- (void) drawCollision5Tiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
    CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"brick_stone"];
    NSMutableDictionary * objPoint;
    
    float x, y, w, h;
    for (objPoint in [objects objects]) {
        x = [[objPoint valueForKey:@"x"] intValue]+offset;
        y = [[objPoint valueForKey:@"y"] intValue];
        w = [[objPoint valueForKey:@"width"] intValue];
        h = [[objPoint valueForKey:@"height"] intValue];
        
        CGPoint _point=ccp(x+w/2,y+h/2);
        CGPoint _size=ccp(w,h);
        
        [self makeBox2dObjAt:_point
                    withSize:_size
                     dynamic:false
                    rotation:0
                    friction:0.0f
                     density:0.0f
                 restitution:0
                       boxId:-1
                    bodyType: kGameObjectStone];
    }
}

- (void) drawCollision6Tiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
    CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"brick_check"];
    NSMutableDictionary * objPoint;
    
    float x, y, w, h;
    for (objPoint in [objects objects]) {
        x = [[objPoint valueForKey:@"x"] intValue]+offset;
        y = [[objPoint valueForKey:@"y"] intValue];
        w = [[objPoint valueForKey:@"width"] intValue];
        h = [[objPoint valueForKey:@"height"] intValue];
        
        CGPoint _point=ccp(x+w/2,y+h/2);
        CGPoint _size=ccp(w,h);
        
        [self makeBox2dObjAt:_point
                    withSize:_size
                     dynamic:false
                    rotation:0
                    friction:0.0f
                     density:0.0f
                 restitution:0
                       boxId:-1
                    bodyType:kGameObjectDisable];
    }
}


- (void) drawFlowerTiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"piranha"];
	NSMutableDictionary * objPoint;
    
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue]+offset;
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
        
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:false
					rotation:0
					friction:0.0f
					 density:0.0f
				 restitution:0
					   boxId:-1
                    bodyType:kGameObjectFlower];
	}
}


/*
 *draw magic diaomnd collision layer
 */
- (void) drawCoinTiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"diamond"];
	NSMutableDictionary * objPoint;
    
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue]+offset;
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
        
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:true
					rotation:0
					friction:0.0f
					 density:0.0f
				 restitution:0
					   boxId:-1
                    bodyType:kGameObjectCoin
         ];
	}
}

/*
 *draw magic heart collision layer
 */
- (void) drawCoin1Tiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"heart"];
	NSMutableDictionary * objPoint;
    
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue]+offset;
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
        
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:true
					rotation:0
					friction:0.0f
					 density:0.0f
				 restitution:0
					   boxId:-1
                    bodyType:kGameObjectCoin1
         ];
	}
}

/*
 *draw magic spade collision layer
 */
- (void) drawCoin2Tiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"spade"];
	NSMutableDictionary * objPoint;
    
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue]+offset;
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
        
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:true
					rotation:0
					friction:0.0f
					 density:0.0f
				 restitution:0
					   boxId:-1
                    bodyType:kGameObjectCoin2
         ];
	}
}

-(void) updateFalling: (float)x
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    [self makeBox2dObjAt:ccp(x,screenSize.height+50)
                withSize:ccp(256,40)
                 dynamic:false
                rotation:0
                friction:0.0f
                 density:2.0f
             restitution:0
                   boxId:-1
                bodyType:kGameObjectFalling
     ];
    
}

- (void)updateFlower:(CGPoint)point
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCLOG(@"winSize: height: %f width: %f",winSize.height,winSize.width);
    
    b2BodyDef bodyDef;
    bodyDef.position.Set((point.x+32)/PTM_RATIO, (point.y-32)/PTM_RATIO);
    bodyDef.gravityScale = 0.0f;
    GameObject* actor=[GameObject spriteWithSpriteFrameName:@"zombie_hand0.png"];
    [actor setType:kGameObjectFlower];
    bodyDef.userData = (__bridge_retained void*) actor;
    b2Body *body = world->CreateBody(&bodyDef);
    b2PolygonShape dynamicBox;
    dynamicBox.SetAsBox(128/2/PTM_RATIO, 128/2/PTM_RATIO);
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &dynamicBox;
    fixtureDef.density = 0;
    body->CreateFixture(&fixtureDef);
    
    NSMutableArray *animFrames1 = [NSMutableArray array];
    for(int i = 0; i <= 15; ++i) {
        [animFrames1 addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zombie_hand%d.png",i]]];
    }
    CCAnimation *Animation1 = [CCAnimation animationWithSpriteFrames:animFrames1 delay:0.25f];
    CCAction *Action1 = [CCRepeat actionWithAction: [CCAnimate actionWithAnimation: Animation1] times:1];
    
    //    NSMutableArray *animFrames2 = [NSMutableArray array];
    //    for(int i = 8; i <= 18; ++i) {
    //        [animFrames1 addObject:
    //         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
    //          [NSString stringWithFormat:@"zombie_hand%d.png",i]]];
    //    }
    //    CCAnimation *Animation2 = [CCAnimation animationWithSpriteFrames:animFrames2 delay:0.05f];
    //    CCFiniteTimeAction *Action2 = [CCRepeat actionWithAction: [CCAnimate actionWithAnimation: Animation2] times:1];
    //    id sequence = [CCSequence actions:Action1, Action2, nil];
    //    [actor setTexture:[flowerBatchNode texture]];
    
    [self addChild:actor z:10];
    [actor runAction:Action1];
}

/*
 *draw magic club collision layer
 */
- (void) drawCoin3Tiles:(CCTMXTiledMap *)tileMapNode withOffset:(int)offset {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"club"];
	NSMutableDictionary * objPoint;
    
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue]+offset;
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
        
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
        
		[self makeBox2dObjAt:_point
					withSize:_size
					 dynamic:true
					rotation:0
					friction:0.0f
					 density:0.0f
				 restitution:0
					   boxId:-1
                    bodyType:kGameObjectCoin3
         ];
	}
}


//------------------------------------------animation: import plsit&png-------------------------------------------//
- (void) initBatchNode {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"all_character_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"texture.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"brick_ice_flashing_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"brick1_hd_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"brick2_hd_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pokerSoilder_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"diamond_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"heart_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"leaf_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"piranha_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"brick_stone_smile_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"skull_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"moon_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zombie_hand_default.plist"];
    
    
    allBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"all_character_default.png"];
    jokerBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"texture.png"];
    emenyBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"JokerActions_both.png"];
    brick1BatchNode = [CCSpriteBatchNode batchNodeWithFile:@"brick_ice_flashing_default.png"];
    brick2BatchNode = [CCSpriteBatchNode batchNodeWithFile:@"brick1_hd_default.png"];
    brick3BatchNode = [CCSpriteBatchNode batchNodeWithFile:@"brick2_hd_default.png"];
    flyBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"pokerSoilder_default.png"];
    diamondBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"diamond_default.png"];
    heartBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"heart_default.png"];
    leafBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"leaf_default.png"];
    flowerBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"zombie_hand_default.png"];
    stoneBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"brick_stone_smile_default.png"];
    skullBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"skull_default.png"];
    ghostBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"pokerSoilder_default.png"];
    moonBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"moon_default.png"];
    /*
     brick1BatchNode.scale=4;
     brick2BatchNode.scale=4;
     brick3BatchNode.scale=4;
     */
    [self addChild:allBatchNode z:10];
    [self addChild:jokerBatchNode z:10];
    [self addChild:emenyBatchNode z:9];
    [self addChild:brick1BatchNode z:2];
    [self addChild:brick2BatchNode z:2];
    [self addChild:brick3BatchNode z:2];
    [self addChild:flyBatchNode z:11];
    [self addChild:diamondBatchNode z:3];
    [self addChild:leafBatchNode z:11];
    //[self addChild:flowerBatchNode z:10];
    [self addChild:ghostBatchNode z:13];
    [self addChild:skullBatchNode z:20];
    [self addChild:stoneBatchNode z:15];
    [self addChild:moonBatchNode z:-1];
    
}

- (id) init {
    self = [super init];
    if (self) {
        // enable touches
        if(!gravity2)
            self.isTouchEnabled = YES;
        else
            self.isAccelerometerEnabled = YES;
        accelerationY = 0;
        lastAccelerationY = 0;
        
        self.tag = GAME_LAYER_TAG;
        self.coinCount=0;
        self.lifeCount=1;
        self.fall1=false;
        self.fall2=false;
        jokerStartCharge = false;
        jokerCharge = 1;
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        [self preLoadSoundFiles];
		[self setupPhysicsWorld];
        [self initBatchNode];
        [self initTiledMaps];
        
        joker = [Joker spriteWithSpriteFrameName:@"joker1.png"];
        [joker setType:kGameObjectJoker];
        [joker initAnimation:allBatchNode character:0];
        joker.position = ccp(jokerLocationX, jokerLocationY);
        [joker createBox2dObject:world];
        
        //        moon=[CCSprite spriteWithSpriteFrameName:@"moon0.png"];
        //        NSMutableArray *moonAnimFrames = [NSMutableArray array];
        //        for(int i = 0; i <= 12; ++i) {
        //            [moonAnimFrames addObject:
        //             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
        //              [NSString stringWithFormat:@"moon%d.png", i]]];
        //        }
        //        CCAnimation *moonRunAnimation = [CCAnimation animationWithSpriteFrames:moonAnimFrames delay:0.1f];
        //        CCAction *moonRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: moonRunAnimation]];
        //        [moon setTexture:[moonBatchNode texture]];
        //        [moon runAction:moonRunAction];
        //        moon.position = ccp(jokerLocationX+ moonLocationX,screenSize.height-moonLocationY);
        //        [moonBatchNode addChild:moon z:10];
        
        
        ghost=[CCSprite spriteWithSpriteFrameName:@"pokerSoilder1.png"];
        NSMutableArray *ghostAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 9; ++i) {
            [ghostAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"pokerSoilder%d.png", i]]];
        }
        CCAnimation *ghostRunAnimation = [CCAnimation animationWithSpriteFrames:ghostAnimFrames delay:0.8f];
        CCAction *ghostRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: ghostRunAnimation]];
        [ghost setTexture:[ghostBatchNode texture]];
        [ghost runAction:ghostRunAction];
        ghost.position = ccp(emenyLocationX, emenyLocationY);
        [ghostBatchNode addChild:ghost z:10];
        
        
        
        
        //        emeny = [Joker spriteWithSpriteFrameName:@"motion1-hd.png"];
        //        [emeny setType:kGameObjectEmeny];
        //        [emeny initAnimation: emenyBatchNode];
        //        emeny.position = ccp(emenyLocationX, emenyLocationY);
        //        [emeny createBox2dObject:world];
        
        flyPos=0;
        CCScene* scene = [[CCDirector sharedDirector] runningScene];
        hudLayer = (HUDLayer*)[scene getChildByTag:HUD_LAYER_TAG];
        [hudLayer updateCoinCounter:self.coinCount];
        [hudLayer updateLifeCounter:self.lifeCount];
        [hudLayer updateStatusCounter:self.distance];
        // [self updateFalling];
        //        self.statusLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"Arial.fnt"];
        //        self.distanceLabel= [CCLabelBMFont labelWithString:@"0.0" fntFile:@"Arial.fnt"];
        //        self.lifeLabel=[CCLabelBMFont labelWithString:@"0" fntFile:@"Arial.fnt"];
        //        coinBar= [CCSprite spriteWithFile:@"club.png"];
        //        disBar=[CCSprite spriteWithFile:@"spade.png"];
        //        lifeBar=[CCSprite spriteWithFile:@"heart.png"];
        //        coinBar.position = ccp(950,screenSize.height-30);
        //        disBar.position = ccp(750, screenSize.height-30);
        //        lifeBar.position=ccp(550, screenSize.height-30);
        //        [self addChild:self.statusLabel z:100];
        //        [self addChild:self.distanceLabel z:101];
        //        [self addChild:self.lifeLabel z:100];
        //        [self addChild:self.coinBar z:102];
        //        [self addChild:self.disBar z:103];
        //        [self addChild:self.lifeBar z:103];
        //        [self setStatusLabelText:@"0"];
        //        [self setLifeLabelText:@"1"];
        //        [self setDistanceLabelText:@"0.00"];
        
        [self schedule:@selector(update:)];
        [self schedule:@selector(updateObject:) interval:1.0f];
        [self schedule:@selector(updateGhost:) interval:0.5f];
        [self schedule:@selector(updateFire:) interval:0.2f];
        //[self schedule:@selector(updateFlower:) interval:2.0f];
        //[self schedule:@selector(updateEmeny:) interval:0.2f];
        //[self schedule:@selector(jokerCharging:) interval:0.2f];
        
        //TAOHU
        /*[self runAction:[CCSequence actions:
         [CCDelayTime actionWithDuration:1.0],
         [CCCallFunc actionWithTarget: self selector:@selector(updateFalling:)],
         [CCDelayTime actionWithDuration:60.0],
         [CCCallFunc actionWithTarget:self selector:@selector(updateFalling:)],
         nil]
         ];
         */
        //[self schedule:@selector(updateFalling:) interval:6.0f];
    }
    return self;
}


- (void)updateFire:(ccTime) dt
{
    if(joker.jokerBody->GetLinearVelocity().x>MIN_RUN_SPEED)
    {
        
        if(!joker.jokerFlip)
        {
            CCParticleSystem *ps = [CCParticleExplosion node];
            [self addChild:ps z:12];
            ps.texture = [[CCTextureCache sharedTextureCache] addImage:@"fire.png"];
            ps.position = ccp(joker.position.x-joker.contentSize.width/2,joker.position.y-joker.contentSize.height/2);
            ps.blendAdditive = YES;
            ps.life = 0.2f;
            ps.lifeVar = 0.2f;
            ps.totalParticles = 60.0f;
            ps.autoRemoveOnFinish = YES;
        }
        else
        {
            CCParticleSystem *ps = [CCParticleExplosion node];
            [self addChild:ps z:12];
            ps.texture = [[CCTextureCache sharedTextureCache] addImage:@"fire.png"];
            ps.position = ccp(joker.position.x-joker.contentSize.width/2,joker.position.y+joker.contentSize.height/2);
            ps.blendAdditive = YES;
            ps.life = 0.2f;
            ps.lifeVar = 0.2f;
            ps.totalParticles = 60.0f;
            ps.autoRemoveOnFinish = YES;
        }
        
    }
    
}

- (void)updateEmeny:(ccTime) dt
{
    CGPoint diff=[self seekWithPosition:joker.position selfPos:emeny.position];
    b2Vec2 newVel;
    if(joker.jokerBody->GetLinearVelocity().x<9.5/PTM_RATIO)
    {
        newVel=b2Vec2(9/PTM_RATIO,joker.jokerBody->GetLinearVelocity().y);
    }
    else
    {
        newVel=joker.jokerBody->GetLinearVelocity();
    }
    emeny.jokerBody->SetLinearVelocity(newVel);
    emeny.jokerBody->SetTransform(b2Vec2(joker.jokerBody->GetPosition().x-diff.x/PTM_RATIO,joker.jokerBody->GetPosition().y/PTM_RATIO), 0);
    emeny.jokerFlip=joker.jokerFlip;
    [emeny flip];
}

-(b2Vec2) seekWithVelocity:(b2Vec2)targetVelocity selfVel:(b2Vec2) selfVelocity
{
    CGPoint t1=ccp(targetVelocity.x,targetVelocity.y);
    CGPoint t2=ccp(selfVelocity.x,selfVelocity.y);
    CGPoint resultPoint=[self seekWithPosition:t1 selfPos:t2];
    return b2Vec2(resultPoint.x/PTM_RATIO,resultPoint.y/PTM_RATIO);
}

-(CGPoint) seekWithPosition:(CGPoint)targetPos selfPos:(CGPoint)selfPosition
{
    CGPoint direction=ccpSub(targetPos, selfPosition);
    return direction;
}

-(void) delayReplaceScene:(ccTime)dt {
    delayReplaceTime++;
    if (delayReplaceTime >= 5) {
        [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:1.0 scene:[GameOverScene sceneWithLevel:GAME_STATE_ONE Coin:coinCount Distance:distance]]];
    }
}

- (void)update:(ccTime)dt {
    //CCLOG(@"dt: %f",dt);
    //CCLOG(@"###vel:%f",joker.jokerBody->GetLinearVelocity().x);
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    //moon.position = ccp(joker.position.x+ moonLocationX,winSize.height-moonLocationY);
    
    CCScene* scene = [[CCDirector sharedDirector] runningScene];
    hudLayer  = (HUDLayer*)[scene getChildByTag:HUD_LAYER_TAG];
    
    [hudLayer updateCoinCounter:coinCount];
    [hudLayer updateLifeCounter:lifeCount];
    [hudLayer updateStatusCounter:distance];
    
    if(joker.jokerBody->GetLinearVelocity().x<0.2)
    {
        if(joker.jokerFlip)
        {
            joker.jokerBody->SetLinearVelocity(b2Vec2(jumpVec.x,JUMP_SPEED));
        }
        else
        {
            joker.jokerBody->SetLinearVelocity(b2Vec2(jumpVec.x,-JUMP_SPEED));
        }
    }
    [joker adjust];
    //[emeny adjust];
    
    //ghost.position=ccp(joker.position.x-200,joker.position.y);
    /*
     CGPoint endPos=ccp(joker.position.x-300,joker.position.y);
     CCAction *ghostAction=[CCRepeatForever actionWithAction: [CCMoveTo actionWithDuration:0.2f position:endPos]];
     [ghost runAction:ghostAction];
     */
    if(joker.position.x>FALLING_WOOD1-FALLING_OFFSET&&fall1==false)
    {
        //[self updateFalling:FALLING_WOOD1];
        fall1=true;
    }
    if(joker.position.x>FALLING_WOOD2-FALLING_OFFSET&&fall2==false)
    {
        [self updateFalling:FALLING_WOOD2];
        fall2=true;
    }
    
    if(joker.position.x>100*32-300 && hand1==false)
    {
        [self updateFlower:ccp(100*32,(24-16)*32)];
        hand1=true;
    }
    if(joker.position.x>150*32-300 && hand2==false)
    {
        [self updateFlower:ccp(150*32,(24-16)*32)];
        hand2=true;
    }
    if(joker.position.x>214*32/2-300 && hand3==false)
    {
        [self updateFlower:ccp(214*32,(24-15)*32)];
        hand3=true;
    }
    
    if(!CGRectIsNull(CGRectIntersection([self positionRect:joker],[self positionRect:fly])))
    {
        lifeCount--;
        [[SimpleAudioEngine sharedEngine] playEffect:@"Pain-SoundBible.com-1883168362.wav"];
    }
    if(!CGRectIsNull(CGRectIntersection([self positionRect:joker],[self positionRect:emeny])))
    {
        //        [[SimpleAudioEngine sharedEngine] playEffect:@"Cartoon clown laugh.wav"];
    }
    // Joker out of screen
    if(joker.position.y <= 0||joker.position.y>winSize.height)
    {
        //        [self unschedule:@selector(update:)];
        [self unscheduleAllSelectors];
        [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:1.0 scene:[GameOverScene sceneWithLevel:GAME_STATE_ONE Coin:coinCount Distance:distance]]];
    }
    // Joker caught by enemy
    if(!CGRectIsNull(CGRectIntersection([self positionRect:joker],[self positionRect:ghost]))||joker.position.x<ghost.position.x + 50) {
        //        [self unschedule:@selector(update:)];
        [self unscheduleAllSelectors];
        [self schedule:@selector(delayReplaceScene:) interval:0.1f];
        
        NSMutableArray *jokerrunDeadFrames = [NSMutableArray array];
        for(int i = 1; i <= 9; ++i) {
            [jokerrunDeadFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"dead%d.png", i]]];
        }
        
        [joker stopAllActions];
        //        [joker stopActionByTag:jokerRunActionTag];
        
        CCAnimation *jokerDeadAnimation = [CCAnimation animationWithSpriteFrames:jokerrunDeadFrames delay:0.09f];
        CCAction *jokerDeadAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: jokerDeadAnimation]];
        
        [joker runAction:jokerDeadAction];
    }
    // MAP_LENGTH * PTM_RATIO
    if(joker.position.x >= MAP_LENGTH * PTM_RATIO * MAP_LEVEL2_NUMS) {
        [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
        // CCTransitionFadeBL, lose: CCTransitionProgressRadialCCW
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1.0 scene:[GameWinScene sceneWithLevel:GAME_STATE_TWO Coin:coinCount Distance:distance]]];
    }
    
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	world->Step(dt, velocityIterations, positionIterations);
    
    b2Vec2 pos = [joker jokerBody]->GetPosition();
	CGPoint newPos = ccp(-1 * pos.x * PTM_RATIO + 350, self.position.y * PTM_RATIO);
	[self setPosition:newPos];
    self.distance=(float)joker.jokerBody->GetPosition().x;
	[self setPosition:newPos];
    
    
    std::vector<b2Body *>toDestroy;
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
    {
        
		if (b->GetUserData() != NULL)
        {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (__bridge CCSprite*)b->GetUserData();
            int posX = b->GetPosition().x * PTM_RATIO;
            int posY = b->GetPosition().y * PTM_RATIO;
            int offset = winSize.width - jokerLocationX;
            if(posX <= joker.position.x + offset + 50 && posX >= joker.position.x - jokerLocationX) {
                myActor.position = CGPointMake( posX, posY);
                myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
            }
            if([myActor isMemberOfClass:[GameObject class]])
            {
                GameObject*actor=(GameObject*)myActor;
                if(actor.type==kGameObjectFlower)
                {
                    CCLOG(@"Actor: position: (%f,%f)",actor.position.x,actor.position.y);
                }
                
                /*
                 if(actor.type==kGameObjectFlower)
                 {
                 if(actor.position.x-joker.position.x<400)
                 {
                 [actor setVisible:true];
                 
                 NSMutableArray *animFrames1 = [NSMutableArray array];
                 for(int i = 0; i <= 7; ++i) {
                 [animFrames1 addObject:
                 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                 [NSString stringWithFormat:@"zombie_hand%d.png",i]]];
                 }
                 CCAnimation *Animation1 = [CCAnimation animationWithSpriteFrames:animFrames1 delay:0.5f];
                 CCFiniteTimeAction *Action1 = [CCRepeat actionWithAction: [CCAnimate actionWithAnimation: Animation1] times:1];
                 
                 NSMutableArray *animFrames2 = [NSMutableArray array];
                 for(int i = 8; i <= 18; ++i) {
                 [animFrames1 addObject:
                 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                 [NSString stringWithFormat:@"zombie_hand%d.png",i]]];
                 }
                 CCAnimation *Animation2 = [CCAnimation animationWithSpriteFrames:animFrames2 delay:0.5f];
                 CCFiniteTimeAction *Action2 = [CCRepeat actionWithAction: [CCAnimate actionWithAnimation: Animation2] times:10];
                 
                 id sequence = [CCSequence actions:Action1, Action2, nil];
                 [actor setTexture:[flowerBatchNode texture]];
                 [actor runAction:sequence];
                 }
                 }
                 */
                if((b->GetPosition().x<(joker.position.x-DESTORY_DISTANCE)/PTM_RATIO)&&actor.type!=kGameObjectEmeny1&&actor.type!=kGameObjectEmeny2)
                {
                    toDestroy.push_back(b);
                }
            }
		}
	}
    std::vector<b2Body *>::iterator pos2;
    for (pos2 = toDestroy.begin(); pos2 != toDestroy.end(); ++pos2) {
        b2Body *body = *pos2;
        if (body->GetUserData() != NULL) {
            CCSprite *sprite = (__bridge CCSprite *) body->GetUserData();
            [self removeChild:sprite cleanup:YES];
            
        }
        world->DestroyBody(body);
    }
    
    
    
    
    
    //[self setStatusLabelText:[NSString stringWithFormat:@"%.2d", self.coinCount]];
    //[self setLifeLabelText:[NSString stringWithFormat:@"%.2d", self.lifeCount]];
    //[self setDistanceLabelText:[NSString stringWithFormat:@"%.2f", self.distance]];
    /*
     if(stateVec.size()!=0)
     {
     CCLOG(@"emeny position: (%f,%f), joker last jump position: %f,queue size:%d",
     emeny.position.x,emeny.position.y,stateVec.front().position.x,stateVec.front().position.y,stateVec.size());
     
     if(((emeny.position.y<=0)||(emeny.position.y>=winSize.height))&&(joker.position.x-stateVec.front().position.x>LASTJUMP_EMENY_DISTANCE))
     {
     emeny.jokerBody->SetTransform(b2Vec2(stateVec.front().position.x/PTM_RATIO,stateVec.front().position.y/PTM_RATIO),0);
     emeny.jokerBody->SetGravityScale(stateVec.front().gravityScale);
     emeny.jokerFlip=stateVec.front().flipState;
     emeny.jokerBody->SetLinearVelocity(stateVec.front().velocity);
     [emeny jump:false];
     CCLOG(@"emeny position: %f",emeny.position.x);
     CCLOG(@"joker last jump position: %f",stateVec.front().position.x);
     stateVec.pop_front();
     }
     else if((joker.position.x-emeny.position.x>JOKER_EMENY_DISTANCE)&&(joker.position.x-stateVec.front().position.x>LASTJUMP_EMENY_DISTANCE))
     {
     emeny.jokerBody->SetTransform(b2Vec2(stateVec.front().position.x/PTM_RATIO,stateVec.front().position.y/PTM_RATIO),0);
     emeny.jokerBody->SetGravityScale(stateVec.front().gravityScale);
     emeny.jokerFlip=stateVec.front().flipState;
     emeny.jokerBody->SetLinearVelocity(stateVec.front().velocity);
     [emeny jump:false];
     CCLOG(@"emeny position: %f",emeny.position.x);
     CCLOG(@"joker last jump position: %f",stateVec.front().position.x);
     stateVec.pop_front();
     }
     else if(emeny.position.x>stateVec.front().position.x&&fabs(emeny.position.y-stateVec.front().position.y)<10.0)
     {
     emeny.jokerBody->SetGravityScale(stateVec.front().gravityScale);
     emeny.jokerFlip=stateVec.front().flipState;
     emeny.jokerBody->SetLinearVelocity(stateVec.front().velocity);
     [emeny jump:false];
     CCLOG(@"emeny position: %f",emeny.position.x);
     CCLOG(@"joker last jump position: %f",stateVec.front().position.x);
     stateVec.pop_front();
     }
     
     }
     */
    /*
     if((joker.position.x-emeny.position.x>AI_RESET_DISTANCE||(emeny.position.y<=0)||(emeny.position.y>=winSize.height))&&(emeny.position.x>stateVec.front().position.x))
     {
     emeny.jokerBody->SetTransform(, );
     }
     if(stateVec.size()!=0)
     {
     if(emeny.position.x>stateVec.front().position.x)
     {
     [emeny jump:false];
     emeny.jokerBody->SetGravityScale(stateVec.front().gravityScale);
     //        b2Vec2 newVel;
     //        if(joker.jokerBody->GetLinearVelocity().x<9.5/PTM_RATIO)
     //        {
     //            newVel=b2Vec2(9/PTM_RATIO,joker.jokerBody->GetLinearVelocity().y);
     //        }
     //        else
     //        {
     //            newVel=joker.jokerBody->GetLinearVelocity();
     //        }
     //        emeny.jokerBody->SetLinearVelocity(newVel);
     //        emeny.jokerBody->SetTransform(b2Vec2(joker.jokerBody->GetPosition().x-diff.x/PTM_RATIO,joker.jokerBody->GetPosition().y), 0);
     //        emeny.jokerFlip=joker.jokerFlip;
     //        [emeny flip];
     stateVec.pop_front();
     }
     }
     */
    
    [self updateAcceleration];
}

- (void)jokerCharging: (ccTime) dt {
    if(jokerStartCharge)
        jokerCharge++;
}

- (void)updateGhost:(ccTime) dt
{
    CGPoint endPos=joker.position;
    //CCLOG(@"size: %d, joker:(%f,%f), ghost:(%f,%f)",positionVec.size(),joker.position.x,joker.position.y,ghost.position.x,ghost.position.y);
    CCAction *action=[CCRepeatForever actionWithAction: [CCMoveTo actionWithDuration:1.0f position:endPos]];
    [ghost runAction:action];
    /*
     if(positionVec.size()<5)
     {
     positionVec.push_back(joker.position);
     }
     else if(positionVec.size()>=5)
     {
     positionVec.push_back(joker.position);
     endPos=positionVec.front();
     CCAction *action=[CCRepeatForever actionWithAction: [CCMoveTo actionWithDuration:0.2f position:endPos]];
     [ghost runAction:action];
     positionVec.pop_front();
     }
     */
}



- (void)updateObject:(ccTime) dt
{
    CGPoint startPos,endPos;
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CCAction *flyAction;
    NSMutableArray *flyFrames = [NSMutableArray array];
    CCAnimation *flyAnim;
    fly = [[GameObject alloc] init];
    [fly setType: kGameObjectFly];
    
    for(int i = 0; i <=10 ; ++i) {
        [flyFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"skull%d.png", i]]];
    }
    flyAnim=[CCAnimation animationWithSpriteFrames:flyFrames delay:0.2f];
    flyAction= [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: flyAnim]];
    [fly setTexture:[skullBatchNode texture]];
    [fly runAction:flyAction];
    [skullBatchNode addChild:fly z:10];
    
    startPos=ccp(joker.position.x+screenSize.width,arc4random_uniform(screenSize.height));
    endPos=ccp(joker.position.x-500,arc4random_uniform(screenSize.height));
    fly.position=startPos;
    CCAction *moveAction=[CCRepeatForever actionWithAction: [CCMoveTo actionWithDuration:20.0f position:endPos]];
    [fly runAction:moveAction];
    //[self addChild:fly z:10];
    flyPos++;
    
}
/*
 -(void)setLifeLabelText:(NSString *)text
 {
 CGSize screenSize = [[CCDirector sharedDirector] winSize];
 [self.statusLabel setString:text];
 CGPoint worldPos1 = [self convertScreenToWorld:ccp(360, screenSize.height - 20)];
 CGPoint worldPos2 = [self convertScreenToWorld:ccp(310, screenSize.height - 20)];
 self.statusLabel.position = worldPos1;
 self.coinBar.position=worldPos2;
 }
 
 -(void)setStatusLabelText:(NSString *)text
 {
 CGSize screenSize = [[CCDirector sharedDirector] winSize];
 [self.statusLabel setString:text];
 CGPoint worldPos1 = [self convertScreenToWorld:ccp(480, screenSize.height - 20)];
 CGPoint worldPos2 = [self convertScreenToWorld:ccp(430, screenSize.height - 20)];
 self.statusLabel.position = worldPos1;
 self.coinBar.position=worldPos2;
 }
 
 
 -(void)setDistanceLabelText:(NSString *)text
 {
 CGSize screenSize = [[CCDirector sharedDirector] winSize];
 [self.distanceLabel setString:text];
 CGPoint worldPos1 = [self convertScreenToWorld:ccp(600, screenSize.height - 20)];
 CGPoint worldPos2 = [self convertScreenToWorld:ccp(550, screenSize.height - 20)];
 self.distanceLabel.position = worldPos1;
 self.disBar.position=worldPos2;
 }
 */
-(void) setupPhysicsWorld {
    //CGSize winSize = [CCDirector sharedDirector].winSize;
    b2Vec2 gravity = b2Vec2(0.0f, -9.8f);
    bool doSleep = true;
    world = new b2World(gravity);
    world->SetAllowSleeping(doSleep);
    world->SetContinuousPhysics(TRUE);
    contactListener = new ContactListener2();
    world->SetContactListener(contactListener);
}

-(CGPoint)convertScreenToWorld:(CGPoint)screenPos
{
    b2Vec2 jokerPosition = joker.jokerBody->GetPosition();
    float32 X = jokerPosition.x;
    CGPoint worldPos=CGPointMake(screenPos.x+X*PTM_RATIO,screenPos.y);
    return worldPos;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    startLocation = touchLocation;
    
    jokerStartCharge = true;
    
    CCParticleSystem *ps = [CCParticleExplosion node];
    [self addChild:ps z:12];
    ps.texture = [[CCTextureCache sharedTextureCache] addImage:@"stars.png"];
    ps.position = touchLocation;
    ps.blendAdditive = YES;
    ps.life = 0.2f;
    ps.lifeVar = 0.2f;
    ps.totalParticles = 30.0f;
    ps.autoRemoveOnFinish = YES;
	return YES;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    CCParticleSystem *ps = [CCParticleExplosion node];
    [self addChild:ps z:12];
    ps.texture = [[CCTextureCache sharedTextureCache] addImage:@"stars.png"];
    ps.position = touchLocation;
    ps.blendAdditive = YES;
    ps.life = 0.2f;
    ps.lifeVar = 0.2f;
    ps.totalParticles = 30.0f;
    ps.autoRemoveOnFinish = YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    endLocation = touchLocation;
    
    // Compare difference in distance
    // accelerate
    if ((endLocation.x - startLocation.x) >= 200 ) {
        // Swipe
        if(coinCount > 0) {
            if(!loseGravity) {
                coinCount--;
                b2Body *jokerBody = [joker getBody];
                b2Vec2 impulse = b2Vec2(jokerBody->GetLinearVelocity().x+10.0f, jokerBody->GetLinearVelocity().y);
                jokerBody->SetLinearVelocity(impulse);
                jokerAcc = true;
            }
        }
        else {
            [hudLayer zoomCoin];
        }
    } // deccelerate
    else if((startLocation.x - endLocation.x) >= 200 ) {
        if(coinCount > 0) {
            if(!loseGravity) {
                coinCount--;
                b2Body *jokerBody = [joker getBody];
                b2Vec2 impulse = b2Vec2(jokerBody->GetLinearVelocity().x-10.0f, jokerBody->GetLinearVelocity().y);
                jokerBody->SetLinearVelocity(impulse);
            }
        }
        else {
            [hudLayer zoomCoin];
        }
    } // lose gravity
    else if((endLocation.y - startLocation.y) >= 200 ) {
        if(loseGravity && joker.jokerFlip) {
            loseGravity = false;
            joker.jokerBody->SetGravityScale(-1);
        }
        if(!loseGravity && !joker.jokerFlip) {
            if(lifeCount > 0) {
                lifeCount--;
                loseGravity = true;
                joker.jokerBody->SetGravityScale(0);
                b2Body *jokerBody = [joker getBody];
                b2Vec2 impulse = b2Vec2(jokerBody->GetLinearVelocity().x, 1.0f);
                jokerBody->SetLinearVelocity(impulse);
            }
            else {
                [hudLayer zoomLife];
            }
        }
    } // get gravity
    else if((startLocation.y - endLocation.y) >= 200) {
        if(loseGravity && !joker.jokerFlip) {
            loseGravity = false;
            joker.jokerBody->SetGravityScale(1);
        }
        if(!loseGravity && joker.jokerFlip) {
            if(lifeCount > 0) {
                lifeCount--;
                loseGravity = true;
                joker.jokerBody->SetGravityScale(0);
                b2Body *jokerBody = [joker getBody];
                b2Vec2 impulse = b2Vec2(jokerBody->GetLinearVelocity().x, -1.0f);
                jokerBody->SetLinearVelocity(impulse);
            }
            else {
                [hudLayer zoomLife];
            }
        }
        
    } // flip
    else { // Touch
        if(!joker.jokerJumping && !loseGravity)
        {
            joker.jokerBody->SetGravityScale(-joker.jokerBody->GetGravityScale());
            State curState={joker.position,joker.jokerBody->GetLinearVelocity(),joker.jokerBody->GetGravityScale(),joker.jokerFlip};
            stateVec.push_back(curState);
            //world->SetGravity(b2Vec2(0.0,-world->GetGravity().y));
            [joker jump:jokerCharge];
            jumpVec=b2Vec2(joker.jokerBody->GetLinearVelocity().x,0);
        }
        
    }
    
    jokerCharge = 1;
    jokerStartCharge = false;
}

@end
















