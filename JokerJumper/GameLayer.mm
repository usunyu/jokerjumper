//
//  GameLayer.m
//  JokerJumper
//
//  Created by Sun on 2/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "CCBReader.h"
#import "Constants.h"
#import "Joker.h"
#import "GameObject.h"
#import "SimpleAudioEngine.h"

@interface GameLayer()
@end

@implementation GameLayer
@synthesize world;
@synthesize joker;
@synthesize coinCount;
@synthesize distance;
@synthesize statusLabel;
@synthesize distanceLabel;
@synthesize coinBar;
@synthesize disBar;
@synthesize flyPos;

+(GameLayer*) getGameLayer {
    return self;
}

- (void)preLoadSoundFiles
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Jump.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Collect_Coin.wav"];
    SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
    if (sae != nil) {
        [sae preloadBackgroundMusic:@"background_music.mp3"];
        if (sae.willPlayBackgroundMusic) {
            sae.backgroundMusicVolume = 0.5f;
        }
    }
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background_music.mp3"];
}

- (void) addScrollingBackgroundWithTileMap {
    tileMapNode = [CCTMXTiledMap tiledMapWithTMXFile:@"map5.5.tmx"];
	tileMapNode.anchorPoint = ccp(0, 0);
    tileMapNode.scale = 2;
	[self addChild:tileMapNode z:-1];
}

- (void) updateScrollingBackgroundWithTileMap:(int)offset {
    tileMapNode.position = ccp(offset,0);
    [self updateCollisionTiles:offset];
    [self updateCoinTiles:offset];
    [self updateCoin1Tiles:offset];
    [self updateCoin2Tiles:offset];
    [self updateCoin3Tiles:offset];

}

// create the box2d object
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
    
	
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    if(type!=kGameObjectPlatform)
        bodyDef.gravityScale = 0.0f;
    
    GameObject* platform;
    if(type==kGameObjectCoin)
    {
        platform = [GameObject spriteWithFile:@"club.png"];
        [platform setType:type];
        [self addChild:platform z:3];
    }
    else if(type==kGameObjectPlatform)
    {
        platform=[[GameObject alloc] init];
        [platform setType:type];
        [self addChild:platform z:2];
    }
    else if(type==kGameObjectCoin1)
    {
        platform = [GameObject spriteWithFile:@"heart.png"];
        [platform setType:type];
        [self addChild:platform z:4];
        
    }
    else if(type==kGameObjectCoin2)
    {
        platform = [GameObject spriteWithFile:@"diamond.png"];
        [platform setType:type];
        [self addChild:platform z:5];
    }
    else if(type==kGameObjectCoin3)
    {
        platform = [GameObject spriteWithFile:@"spade.png"];
        [platform setType:type];
        [self addChild:platform z:6];
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
    if(type!=kGameObjectPlatform)
    {
        fixtureDef.isSensor=true;
    }
	fixtureDef.friction = f;
	fixtureDef.restitution = rest;
	body->CreateFixture(&fixtureDef);
}

-(void) updateCollisionTiles:(int)offset {
    CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Collision"];
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
                    bodyType:kGameObjectPlatform];
	}

}

-(void) updateCoinTiles:(int)offset {
    CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Coin"];
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
                    bodyType: kGameObjectCoin];
	}
    
}

-(void) updateCoin1Tiles:(int)offset {
    CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Coin1"];
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
                    bodyType: kGameObjectCoin1];
	}
    
}

-(void) updateCoin2Tiles:(int)offset {
    CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Coin2"];
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
                    bodyType: kGameObjectCoin2];
	}
}

-(void) updateCoin3Tiles:(int)offset {
    CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Coin3"];
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
                    bodyType: kGameObjectCoin3];
	}
    
}



// detect the collision of map
- (void) drawCollisionTiles {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Collision"];
	NSMutableDictionary * objPoint;
	
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
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
                    bodyType:kGameObjectPlatform];
	}
}

- (void) drawCoinTiles {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Coin"];
	NSMutableDictionary * objPoint;
	
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
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

- (void) drawCoin1Tiles {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Coin1"];
	NSMutableDictionary * objPoint;
	
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
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

- (void) drawCoin2Tiles {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Coin2"];
	NSMutableDictionary * objPoint;
	
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
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

- (void) drawCoin3Tiles {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Coin3"];
	NSMutableDictionary * objPoint;
	
	float x, y, w, h;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
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


- (void) initBatchNode {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"JokerActions.plist"];
    jokerBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"JokerActions.png"];
    [self addChild:jokerBatchNode z:1];
}

- (id) init {
    self = [super init];
    if (self) {
        // enable touches
        self.isTouchEnabled = YES;
        self.tag = 100;
        self.coinCount=0;
        jokerStartCharge = false;
        jokerCharge = 1;
        CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);
        
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        [self preLoadSoundFiles];
		[self setupPhysicsWorld];
        [self addScrollingBackgroundWithTileMap];
        [self drawCoinTiles];
        [self drawCoin1Tiles];
        [self drawCoin2Tiles];
        [self drawCoin3Tiles];
        [self drawCollisionTiles];
        
        [self initBatchNode];
        
        joker = [Joker spriteWithSpriteFrameName:@"motion1-hd.png"];
//        joker = [[Joker alloc] init];
        [joker setType:kGameObjectJoker];
        [joker initAnimation:jokerBatchNode];
        joker.position = ccp(jokerLocationX, jokerLocationY);
        [joker createBox2dObject:world];
        
        flyPos=0;
        self.statusLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"Arial.fnt"];
        self.distanceLabel= [CCLabelBMFont labelWithString:@"0.0" fntFile:@"Arial.fnt"];
        coinBar= [CCSprite spriteWithFile:@"club.png"];
        disBar=[CCSprite spriteWithFile:@"spade.png"];
        coinBar.position = ccp(950,screenSize.height-30);
        disBar.position = ccp(750, screenSize.height-30);
        
        [self addChild:self.statusLabel z:100];
        [self addChild:self.distanceLabel z:101];
        [self addChild:self.coinBar z:102];
        [self addChild:self.disBar z:103];
        [self setStatusLabelText:@"0"];
        [self setDistanceLabelText:@"0.00"];
        
        [self schedule:@selector(update:)];
        //[self schedule:@selector(updateObject:) interval:2.0];
        [self schedule:@selector(jokerCharging:) interval:0.2f];
        
    }
    return self;
}

- (void)jokerCharging: (ccTime) dt {
    if(jokerStartCharge)
        jokerCharge++;
}

- (void)updateObject:(ccTime) dt
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CCSprite *fly = [CCSprite spriteWithFile:@"club.png"];
    CGPoint position=joker.position;
    CGPoint realDestBlock;
    /*if(flyPos==4)
    {
        flyPos=0;
    }
     */
    switch(flyPos)
    {
        case 0:
            position=ccp(joker.position.x+500,screenSize.height*0.5);realDestBlock = ccp(1000, 0);break;
        case 1:
            position=ccp(joker.position.x-50,screenSize.height*0.7);realDestBlock = ccp(500, 0);break;
        case 2:
            position=ccp(joker.position.x-50,screenSize.height*0.35);realDestBlock = ccp(2000, 0);break;
        case 3:
            position=ccp(joker.position.x-50,screenSize.height*0.45);realDestBlock = ccp(3000, 0);break;
        default:
            break;
    }
    position=ccp(500,500);
    realDestBlock = ccp(1500, 0);
    fly.position=position;
    flyPos++;
    [self addChild:fly z:10];
    
    /*
    CCAction *_blockMoveAction;
    _blockMoveAction=[CCRepeatForever actionWithAction: [CCMoveTo actionWithDuration:20.0f position:realDestBlock]];
    [block runAction:_blockMoveAction];
     */
        
    // Create block body
    b2BodyDef flyBodyDef;
    flyBodyDef.type =b2_kinematicBody;
    flyBodyDef.gravityScale = 0.0f;
    flyBodyDef.position.Set(0, (position.y)/PTM_RATIO);
    flyBodyDef.userData = (__bridge void*)fly;

    flyBodyDef.linearVelocity=b2Vec2(50,0);
    b2Body *flyBody = world->CreateBody(&flyBodyDef);
    
    b2PolygonShape flyShape;
    flyShape.SetAsBox(fly.contentSize.width/PTM_RATIO/2,
                      fly.contentSize.height/PTM_RATIO/2);
    
    b2FixtureDef flyShapeDef;
    flyShapeDef.shape = &flyShape;
    flyBody->CreateFixture(&flyShapeDef);
    CCLOG(@"flyPos = %d",flyPos );

    
    /*
    flyBodyDef.position.Set(0, (position.y)/PTM_RATIO);
    flyBodyDef.userData = (__bridge void*)fly;
    
       
        
    // Create block shape
    b2PolygonShape flyShape;
    flyShape.SetAsBox(fly.contentSize.width/PTM_RATIO/2,
                        fly.contentSize.height/PTM_RATIO/2);
    
    // Create shape definition and add to body
        flyShapeDef.isSensor=true;
    flyShapeDef.shape = &flyShape;
    flyShapeDef.density = 1.0;
    flyShapeDef.friction = 0.4;
    flyShapeDef.restitution = 0.0f;
    flyBody->CreateFixture(&flyShapeDef);
         */
}

-(void)setStatusLabelText:(NSString *)text
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [self.statusLabel setString:text];
    CGPoint worldPos1 = [self convertScreenToWorld:ccp(700, screenSize.height - 20)];
    CGPoint worldPos2 = [self convertScreenToWorld:ccp(600, screenSize.height - 20)];
    self.statusLabel.position = worldPos1;
    self.coinBar.position=worldPos2;
}


-(void)setDistanceLabelText:(NSString *)text
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [self.distanceLabel setString:text];
    CGPoint worldPos1 = [self convertScreenToWorld:ccp(900, screenSize.height - 20)];
    CGPoint worldPos2 = [self convertScreenToWorld:ccp(800, screenSize.height - 20)];
    self.distanceLabel.position = worldPos1;
    self.disBar.position=worldPos2;
}

-(void) setupPhysicsWorld {
    //CGSize winSize = [CCDirector sharedDirector].winSize;
    b2Vec2 gravity = b2Vec2(0.0f, -9.8f);
    bool doSleep = true;
    world = new b2World(gravity);
    world->SetAllowSleeping(doSleep);
    world->SetContinuousPhysics(TRUE);
    contactListener = new ContactListener();
    world->SetContactListener(contactListener);
}

- (void)update:(ccTime)dt {
     CGSize winSize = [[CCDirector sharedDirector] winSize];
    if(joker.jokerBody->GetLinearVelocity().x<11.274257) {
        [joker accelerate];
    }
    //CCLOG(@"joker.x = %f", joker.position.x);
//    if(joker.position.x >= 18000 && joker.position.x <= 18020) {
//        [self updateScrollingBackgroundWithTileMap:18000];
//    }
//    CGSize winSize = [CCDirector sharedDirector].winSize;
    if(joker.position.y <= 0) {
        //||(joker.position.y >winSize.height/PTM_RATIO)
        CCLabelTTF * label = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Arial" fontSize:32];
        label.color = ccc3(0,0,0);
        label.position = ccp(winSize.width/2, winSize.height/2);
        CCAction *fadeIn = [CCFadeTo actionWithDuration:5 opacity:225];
        [self addChild:label];
        [label runAction:fadeIn];
        [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"GameOver.ccbi"]]];
    }
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	world->Step(dt, velocityIterations, positionIterations);
	
    std::vector<b2Body *>toDestroy;
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
    {
		if (b->GetUserData() != NULL)
        {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (__bridge CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO,
										   b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
            /*
            GameObject *object = (__bridge GameObject*)b->GetUserData();
            if(object.type==kGameObjectFly)
            {
                if(object.position.x>=joker.position.x+winSize.width)
                {
                    toDestroy.push_back(b);
                }
            }
            */
             
		}
	}
    /*
    std::vector<b2Body *>::iterator pos2;
    for (pos2 = toDestroy.begin(); pos2 != toDestroy.end(); ++pos2) {
        b2Body *body = *pos2;
        if (body->GetUserData() != NULL) {
            CCSprite *sprite = (__bridge CCSprite *) body->GetUserData();
            [self removeChild:sprite cleanup:YES];
        }
        world->DestroyBody(body);
    }
     */
    
    b2Vec2 pos = [joker jokerBody]->GetPosition();
	CGPoint newPos = ccp(-1 * pos.x * PTM_RATIO + 50, self.position.y * PTM_RATIO);
	
	[self setPosition:newPos];
    
    self.distance=(float)joker.jokerBody->GetPosition().x;
	[self setPosition:newPos];
    [self setStatusLabelText:[NSString stringWithFormat:@"%.2d", self.coinCount]];
    [self setDistanceLabelText:[NSString stringWithFormat:@"%.2f", self.distance]];
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
    jokerStartCharge = true;
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    [joker jump:jokerCharge];
    jokerCharge = 1;
    jokerStartCharge = false;
}
@end
