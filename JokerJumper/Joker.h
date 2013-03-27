//
//  Joker.h
//  JokerJumper
//
//  Created by Sun on 3/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GameObject.h"

#define jokerRunActionTag 1
#define jokerFlipRunActionTag 2

@interface Joker : GameObject {
    b2Body          *jokerBody;
    CCAction *jokerRunAction;
    CCAction *jokerFlipRunAction;
    
    CCAnimation *jokerRunAnimation;
    CCAnimation *jokerJumpAnimation;
    CCAnimation *jokerFlipAnimation;
    
    BOOL jokerJumping;
    BOOL jokerFlip;
}

-(void) createBox2dObject:(b2World*)world;
-(void) initAnimation:(CCSpriteBatchNode*)batchNode;
-(void) jump:(float)charge;
-(void) run;
-(void) fall;
-(void) accelerate;
-(void) decelerate;
-(void) flip;
-(void) adjust;
+(Joker*) getJoker;

@property (nonatomic, readwrite) b2Body *jokerBody;
@property (nonatomic, readwrite) BOOL jokerJumping;
@property (nonatomic, readwrite) BOOL jokerFlip;
@end
