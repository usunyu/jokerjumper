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

-(void) initAnimation:(CCSpriteBatchNode*)batchNode {
        // Run Action
        jokerFlip=false;
        NSMutableArray *runAnimFrames = [NSMutableArray array];
    
        for(int i = 0; i <= 7; ++i) {
            [runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"motion%d-hd.png", i]]];
        }
        jokerRunAnimation = [CCAnimation animationWithSpriteFrames:runAnimFrames delay:0.09f];
        jokerRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: jokerRunAnimation]];
        jokerRunAction.tag = jokerRunActionTag;
    [self runAction:jokerRunAction];
    [batchNode addChild:(Joker*)self];

    
    
        //flip Action
        NSMutableArray *flipAnimFrames = [NSMutableArray array];
        jokerFlipAnimation=[CCAnimation animation];
    for(int i = 0; i <= 7; i++) {
        [flipAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"motion%d-hd_flip.png", i]]];
    }
    
    jokerFlipAnimation = [CCAnimation animationWithSpriteFrames:flipAnimFrames delay:0.09f];
    jokerFlipRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: jokerFlipAnimation]];
    jokerFlipRunAction.tag = jokerFlipRunActionTag;
    
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
	fixtureDef.density = 3.5f;
	fixtureDef.friction = 0.0f;
	fixtureDef.restitution =  0.0f;
	jokerBody->CreateFixture(&fixtureDef);
    
    b2Vec2 impulse = b2Vec2(150.0f, 0.0f);
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
    if(jokerBody->GetLinearVelocity().x<9)
    {
        [self accelerate];
    }
    else
    {
        [self decelerate];
    }
    //jokerBody->ApplyLinearImpulse(impulse, jokerBody->GetWorldCenter());
}

- (void) accelerate {
    b2Vec2 impulse = b2Vec2(10.0f, jokerBody->GetLinearVelocity().y);
    jokerBody->SetLinearVelocity(impulse); 
    //jokerBody->ApplyLinearImpulse(impulse, jokerBody->GetWorldCenter());
}

- (void) decelerate {
    b2Vec2 impulse = b2Vec2(10.0f,  jokerBody->GetLinearVelocity().y);
    jokerBody->SetLinearVelocity(impulse);
    //jokerBody->ApplyLinearImpulse(impulse, jokerBody->GetWorldCenter());
}


- (void) fall {
    b2Vec2 impulse = b2Vec2(0.0f, -300.0f);
    jokerBody->ApplyLinearImpulse(impulse, jokerBody->GetWorldCenter());
}


-(void) flip
{
    if(!jokerFlip)
    {
        [self stopAllActions];
        [self runAction: jokerRunAction];
    }
    else
    {
        [self stopAllActions];
        [self runAction: jokerFlipRunAction];
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
        NSLog(@"Joker speed %f", jokerBody->GetLinearVelocity().x);
        if(jokerFlip==true)
        {
            [self stopAction:jokerFlipRunAction];
            [self runAction: jokerRunAction];
        }
        else
        {
            [self stopAction:jokerRunAction];
            [self runAction: jokerFlipRunAction];
        }
        jokerFlip=!jokerFlip;
//        [self stopActionByTag:jokerRunActionTag];
        
          [[SimpleAudioEngine sharedEngine] playEffect:@"Jump.wav"];
//        jokerJumpAnimation.restoreOriginalFrame = YES;
        
//        CCAnimate *jumpAnimate = [CCAnimate actionWithAnimation:jokerJumpAnimation];
//        CCJumpBy *jumpAction = [CCJumpBy actionWithDuration:1.25 position:ccp(0,0) height:300 jumps:1];
//        CCCallFunc *doneJumpAction = [CCCallFunc actionWithTarget:self selector:@selector(doneJump)];
//        CCSequence *sequenceAction = [CCSequence actions:jumpAction,doneJumpAction, nil];
//        [self runAction:[CCSpawn actions:jumpAnimate,sequenceAction, nil]];
//        jokerBody->GetLinearVelocity();
        b2Vec2 impulse;
        if(jokerBody->GetLinearVelocity().x<11.274257)
        {
            impulse = b2Vec2(0.0f, charge);
        }
        else
        {
            impulse = b2Vec2(0.0f, charge);
        }
        jokerBody->ApplyLinearImpulse(impulse, jokerBody->GetWorldCenter());

    }
    }
    else
    {
        NSLog(@"Joker speed %f", jokerBody->GetLinearVelocity().x);
        if(jokerFlip==true)
        {
            [self stopAction:jokerFlipRunAction];
            [self runAction: jokerRunAction];
        }
        else
        {
            [self stopAction:jokerRunAction];
            [self runAction: jokerFlipRunAction];
        }
        jokerFlip=!jokerFlip;
        jokerBody->ApplyLinearImpulse(b2Vec2(0.0f, 100), jokerBody->GetWorldCenter());

    }
}


@end
