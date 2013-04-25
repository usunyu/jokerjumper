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
#define jokerUpActionTag 3
#define jokerDownActionTag 4

@interface Joker : GameObject {
    b2Body          *jokerBody;
    CCFiniteTimeAction *jokerRunAction;
    CCFiniteTimeAction *jokerFlipRunAction;
    CCFiniteTimeAction *jokerUpAction;
    CCFiniteTimeAction *jokerDownAction;
    
    CCAnimation *jokerRunAnimation;
    CCAnimation *jokerJumpAnimation;
    CCAnimation *jokerFlipAnimation;
    CCAnimation *jokerUpAnimation;
    CCAnimation *jokerDownAnimation;
    id sequenceUp;
    id sequenceDown;
    
    BOOL jokerJumping;
    BOOL jokerFlip;
}

-(void) createBox2dObject:(b2World*)world;
-(void) initAnimation:(CCSpriteBatchNode*)batchNode character:(int) num;
-(void) afterUpAction:(Joker *) sprite;
-(void) afterDownAction:(Joker *) sprite;
-(void) jump:(float)charge;
-(void) run;
-(void) fall;
-(void) accelerate;
-(void) decelerate;
-(void) flip;
-(void) adjust;
+(Joker*) getJoker;
-(b2Body*) getBody;

@property (nonatomic, readwrite) b2Body *jokerBody;
@property (nonatomic, readwrite) BOOL jokerJumping;
@property (nonatomic, readwrite) BOOL jokerFlip;
@end
