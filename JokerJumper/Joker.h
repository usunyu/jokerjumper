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

@interface Joker : GameObject {
    b2Body          *jokerBody;
    CCAction *jokerRunAction;
    CCAnimation *jokerRunAnimation;
    CCAnimation *jokerJumpAnimation;
    BOOL jokerJumping;
}

-(void) createBox2dObject:(b2World*)world;
-(void) initAnimation:(CCSpriteBatchNode*)batchNode;
-(void) jump:(float)charge;
-(void) run;
-(void) fall;
-(void) accelerate;
+(Joker*) getJoker;

@property (nonatomic, readwrite) b2Body *jokerBody;
@property (nonatomic, readwrite) BOOL jokerJumping;
@end
