//
//  Joker.m
//  JokerJumper
//
//  Created by Sun on 3/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Joker.h"
#import "Constants.h"
#import "SimpleAudioEngine.h"

@implementation Joker
@synthesize jokerBody;
@synthesize jokerJumping;
@synthesize jokerFlip;

+(Joker*) getJoker {
    return self;
}

- (id) init {
	if ((self = [super init])) {
		type = kGameObjectJoker;
	}
	return self;
}

-(void) initAnimation:(CCSpriteBatchNode*)batchNode character:(int) num {
    // Run Action
    if(num==0)
    {
        jokerFlip=false;
        NSMutableArray *runAnimFrames = [NSMutableArray array];
        
        for(int i = 1; i <= 14; ++i) {
            [runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"joker%d.png", i]]];
        }
        jokerRunAnimation = [CCAnimation animationWithSpriteFrames:runAnimFrames delay:0.09f];
        jokerRunAction = [CCRepeat actionWithAction: [CCAnimate actionWithAnimation: jokerRunAnimation] times:200];
        jokerRunAction.tag = jokerRunActionTag;
        [self runAction:jokerRunAction];
        [batchNode addChild:(Joker*)self];
        
        
        
        //flip Action
        NSMutableArray *flipAnimFrames = [NSMutableArray array];
        jokerFlipAnimation=[CCAnimation animation];
        for(int i = 15; i <= 28; i++) {
            [flipAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"joker%d.png", i]]];
        }
        
        jokerFlipAnimation = [CCAnimation animationWithSpriteFrames:flipAnimFrames delay:0.11f];
        jokerFlipRunAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation: jokerFlipAnimation] times:200];
        jokerFlipRunAction.tag = jokerFlipRunActionTag;
        
        NSMutableArray *upAnimFrames = [NSMutableArray array];
        jokerUpAnimation=[CCAnimation animation];
        for(int i = 1; i <= 8; i++) {
            [upAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"jump%d.png", i]]];
        }
        
        jokerUpAnimation = [CCAnimation animationWithSpriteFrames:upAnimFrames delay:0.02f];
        jokerUpAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation: jokerUpAnimation] times:1];
        jokerUpAction.tag = jokerUpActionTag;
        
        NSMutableArray *downAnimFrames = [NSMutableArray array];
        jokerDownAnimation=[CCAnimation animation];
        for(int i = 1; i <= 8; i++) {
            [downAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"jumpd%d.png", i]]];
        }
        jokerDownAnimation = [CCAnimation animationWithSpriteFrames:downAnimFrames delay:0.02f];
        jokerDownAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation: jokerDownAnimation] times:1];
        jokerDownAction.tag = jokerDownActionTag;
    }
    else if(num==1)
    {
        jokerFlip=false;
        NSMutableArray *runAnimFrames = [NSMutableArray array];
        
        for(int i = 0; i <= 7; ++i) {
            [runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"green_monster%d.png", i]]];
        }
        jokerRunAnimation = [CCAnimation animationWithSpriteFrames:runAnimFrames delay:0.09f];
        jokerRunAction = [CCRepeat actionWithAction: [CCAnimate actionWithAnimation: jokerRunAnimation] times:200];
        jokerRunAction.tag = jokerRunActionTag;
        [self runAction:jokerRunAction];
        [batchNode addChild:(Joker*)self];
        
        
        
        //flip Action
        NSMutableArray *flipAnimFrames = [NSMutableArray array];
        jokerFlipAnimation=[CCAnimation animation];
        for(int i = 8; i <= 15; i++) {
            [flipAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"green_monster%d.png", i]]];
        }
        
        jokerFlipAnimation = [CCAnimation animationWithSpriteFrames:flipAnimFrames delay:0.09f];
        jokerFlipRunAction = [CCRepeat actionWithAction: [CCAnimate actionWithAnimation: jokerFlipAnimation] times:200];
        jokerFlipRunAction.tag = jokerFlipRunActionTag;
        
        NSMutableArray *upAnimFrames = [NSMutableArray array];
        jokerUpAnimation=[CCAnimation animation];
        for(int i = 0; i <= 8; i++) {
            [upAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"green_monster_jump_up%d.png", i]]];
        }
        
        jokerUpAnimation = [CCAnimation animationWithSpriteFrames:upAnimFrames delay:0.02f];
        jokerUpAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation: jokerUpAnimation] times:1];
        jokerUpAction.tag = jokerUpActionTag;
        
        NSMutableArray *downAnimFrames = [NSMutableArray array];
        jokerDownAnimation=[CCAnimation animation];
        for(int i = 0; i <= 8; i++) {
            [downAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"green_monster_jump_down%d.png", i]]];
        }
        jokerDownAnimation = [CCAnimation animationWithSpriteFrames:downAnimFrames delay:0.02f];
        jokerDownAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation: jokerDownAnimation] times:1];
        jokerDownAction.tag = jokerDownActionTag;
    }
    else if(num==2)
    {
        jokerFlip=false;
        NSMutableArray *runAnimFrames = [NSMutableArray array];
        
        for(int i = 0; i <= 7; ++i) {
            [runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"enermy%d.png", i]]];
        }
        jokerRunAnimation = [CCAnimation animationWithSpriteFrames:runAnimFrames delay:0.09f];
        jokerRunAction = [CCRepeat actionWithAction: [CCAnimate actionWithAnimation: jokerRunAnimation] times:200];
        jokerRunAction.tag = jokerRunActionTag;
        [self runAction:jokerRunAction];
        [batchNode addChild:(Joker*)self];
        
        
        
        //flip Action
        NSMutableArray *flipAnimFrames = [NSMutableArray array];
        jokerFlipAnimation=[CCAnimation animation];
        for(int i = 8; i <= 15; i++) {
            [flipAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"enermy%d.png", i]]];
        }
        
        jokerFlipAnimation = [CCAnimation animationWithSpriteFrames:flipAnimFrames delay:0.09f];
        jokerFlipRunAction =[CCRepeat actionWithAction: [CCAnimate actionWithAnimation: jokerFlipAnimation] times:200];
        jokerFlipRunAction.tag = jokerFlipRunActionTag;
        
        NSMutableArray *upAnimFrames = [NSMutableArray array];
        jokerUpAnimation=[CCAnimation animation];
        for(int i = 0; i <= 8; i++) {
            [upAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"lighting_deadman_jump_up%d.png", i]]];
        }
        
        jokerUpAnimation = [CCAnimation animationWithSpriteFrames:upAnimFrames delay:0.02f];
        jokerUpAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation: jokerUpAnimation] times:1];
        jokerUpAction.tag = jokerUpActionTag;
        
        NSMutableArray *downAnimFrames = [NSMutableArray array];
        jokerDownAnimation=[CCAnimation animation];
        for(int i = 0; i <= 8; i++) {
            [downAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"lighting_deadman_jump_down%d.png", i]]];
        }
        jokerDownAnimation = [CCAnimation animationWithSpriteFrames:downAnimFrames delay:0.02f];
        jokerDownAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation: jokerDownAnimation] times:1];
        jokerDownAction.tag = jokerDownActionTag;
    }
    /*
     // Jump Action
     jokerJumpAnimation = [CCAnimation animation];
     for(int i = 1; i <= 4; i++) {
     [jokerJumpAnimation addSpriteFrame:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
     [NSString stringWithFormat:@"jump%d.png", i]]];
     }
     [jokerJumpAnimation setDelayPerUnit:0.3f];
     */
}
-(void) afterUpAction:(Joker *) sprite
{
    [sprite runAction:jokerFlipRunAction];
}

-(void) afterDownAction:(Joker *) sprite
{
    [sprite runAction:jokerRunAction];
}

-(void) createBox2dObject:(b2World*)world {
    b2BodyDef playerBodyDef;
	playerBodyDef.type = b2_dynamicBody;
	playerBodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
    
	playerBodyDef.userData = (__bridge void*) self;
	playerBodyDef.fixedRotation = true;
	jokerBody = world->CreateBody(&playerBodyDef);
	b2CircleShape circleShape;
	circleShape.m_radius = 1.1;
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &circleShape;
	fixtureDef.density = 8.0f;
	fixtureDef.friction = 0;
	fixtureDef.restitution =  0.0f;
	jokerBody->CreateFixture(&fixtureDef);
    
    b2Vec2 impulse = b2Vec2(200.0f, 0.0f);
    jokerBody->ApplyLinearImpulse(impulse, jokerBody->GetWorldCenter());
}

- (void)doneJump {
    jokerFlip=!jokerFlip;
    CCLOG(@"########jokerFlip: %d\n",jokerFlip);
    if(jokerFlip)
    {
        [self runAction: jokerRunAction];
    }
    else
    {
        [self runAction: jokerFlipRunAction];
    }
    //    jokerJumping = FALSE;
    //    jokerJumping=false;
    //[self runAction: jokerRunAction];
}


- (void) adjust {
    //CCLOG(@"before adjust: %f",jokerBody->GetLinearVelocity().x);
    if(jokerBody->GetLinearVelocity().x<MIN_RUN_SPEED)
    {
        [self accelerate];
    }
    else if(jokerBody->GetLinearVelocity().x>MAX_RUN_SPEED)
    {
        [self decelerate];
    }
    //CCLOG(@"after adjust: %f",jokerBody->GetLinearVelocity().x);
    //jokerBody->ApplyLinearImpulse(impulse, jokerBody->GetWorldCenter());
}

- (void) accelerate {
    b2Vec2 impulse = b2Vec2(MIN_RUN_SPEED, jokerBody->GetLinearVelocity().y);
    jokerBody->SetLinearVelocity(impulse);
    //jokerBody->ApplyLinearImpulse(impulse, jokerBody->GetWorldCenter());
}

- (void) decelerate {
    b2Vec2 impulse = b2Vec2(MAX_RUN_SPEED,  jokerBody->GetLinearVelocity().y);
    jokerBody->SetLinearVelocity(impulse);
    //jokerBody->ApplyLinearImpulse(impulse, jokerBody->GetWorldCenter());
}


- (void) fall {
    b2Vec2 impulse = b2Vec2(jokerBody->GetLinearVelocity().x, -300.0f);
    jokerBody->SetLinearVelocity(impulse);//, jokerBody->GetWorldCenter());
}


-(void) flip
{
    if(!jokerFlip)
    {
        [self stopAllActions];
        [self runAction: [CCSequence actions:jokerDownAction,jokerRunAction,nil]];
        //[self runAction: jokerRunAction];
    }
    else
    {
        [self stopAllActions];
        [self runAction:[CCSequence actions:jokerUpAction,jokerFlipRunAction,nil]];
        //[self runAction: jokerFlipRunAction];
    }
}
-(void) jump:(float)charge
{
    if(self.type==kGameObjectJoker)
    {
        if(!jokerJumping)
        {
            jokerJumping = true;
            CCLOG(@"Set jump true");
            charge = charge * 30;
            if(charge > 150)
                charge = 150;
            if(charge < 80)
                charge = 80;
            
            if(jokerFlip==true)
            {
                [self stopAllActions];
                [self runAction: [CCSequence actions:jokerDownAction,jokerRunAction,nil]];
            }
            else
            {
                [self stopAllActions];
                [self runAction:[CCSequence actions:jokerUpAction,jokerFlipRunAction,nil]];
            }
            jokerFlip=!jokerFlip;
            [[SimpleAudioEngine sharedEngine] playEffect:@"Jump.wav"];
            if(jokerBody->GetGravityScale()>0)
            {
                jokerBody->SetLinearVelocity(b2Vec2(jokerBody->GetLinearVelocity().x,-JUMP_SPEED));
                CCLOG(@"here1 %d",jokerFlip);
            }
            else
            {
                jokerBody->SetLinearVelocity(b2Vec2(jokerBody->GetLinearVelocity().x,JUMP_SPEED));
                CCLOG(@"here2 %d",jokerFlip);
            }
            
        }
    }
    else if(self.type==kGameObjectEmeny1)
    {
        NSLog(@"Emeny speed %f", jokerBody->GetLinearVelocity().x);
        if(jokerFlip==true)
        {
            [self stopAllActions];
            [self runAction: [CCSequence actions:jokerDownAction,jokerRunAction,nil]];
        }
        else
        {
            [self stopAllActions];
            [self runAction:[CCSequence actions:jokerUpAction,jokerFlipRunAction,nil]];
        }
        jokerFlip=!jokerFlip;
        if(jokerFlip)
        {
            jokerBody->SetLinearVelocity(b2Vec2(jokerBody->GetLinearVelocity().x,JUMP_SPEED));
        }
        else
        {
            jokerBody->SetLinearVelocity(b2Vec2(jokerBody->GetLinearVelocity().x,-JUMP_SPEED));
        }
        //jokerBody->ApplyLinearImpulse(b2Vec2(0.0f, 2000), jokerBody->GetWorldCenter());
        
    }else if(self.type==kGameObjectEmeny2)
    {
        if(jokerFlip==true)
        {
            [self stopAllActions];
            [self runAction: [CCSequence actions:jokerDownAction,jokerRunAction,nil]];
        }
        else
        {
            [self stopAllActions];
            [self runAction:[CCSequence actions:jokerUpAction,jokerFlipRunAction,nil]];
        }
        jokerFlip=!jokerFlip;
        if(jokerFlip)
        {
            jokerBody->SetLinearVelocity(b2Vec2(jokerBody->GetLinearVelocity().x,JUMP_SPEED));
        }
        else
        {
            jokerBody->SetLinearVelocity(b2Vec2(jokerBody->GetLinearVelocity().x,-JUMP_SPEED));
        }
    }
    
    
}


@end
