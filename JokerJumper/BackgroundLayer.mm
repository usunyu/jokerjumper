//
//  BackgroundLayer.m
//  JokerJumper
//
//  Created by Sun on 3/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"
#import "Constants.h"

@implementation BackgroundLayer

CCSprite *bgFront1;
CCSprite *bgFront2;
CCSprite *bgMiddle1;
CCSprite *bgMiddle2;
CCSprite *bgBack1;
CCSprite *bgBack2;
CCSprite *moon;
CCSpriteBatchNode* moonBatchNode;

BOOL frontOpen = true;
BOOL middleOpen = true;
BOOL backOpen = false;

float frontSpeed = 6.0f;
float middleSpeed = 3.0f;
float backSpeed = 1.0f;

int backgroundLevel = 1;

//- (id) init {
//    self = [super init];
//    if (self) {
//        self.tag=BG_LAYER_TAG;
//        [self initBackground];
//        
//        [self schedule: @selector(tick:)];
//    }
//    return self;
//}

- (id) initWithLevel:(int)level {
    self = [super init];
    if (self) {
        self.tag=BG_LAYER_TAG;
        
        backgroundLevel = level;
        
        [self initBackground];
        if(level == 2)
            [self initMoon];
        
        [self schedule: @selector(tick:)];
    }
    return self;
}

-(void)initMoon {
    CGSize s = [[CCDirector sharedDirector] winSize];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"moon_default.plist"];
    moonBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"moon_default.png"];
    [self addChild:moonBatchNode z:0];
    moon=[CCSprite spriteWithSpriteFrameName:@"moon0.png"];
    NSMutableArray *moonAnimFrames = [NSMutableArray array];
    for(int i = 0; i <= 12; ++i) {
        [moonAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"moon%d.png", i]]];
    }
    CCAnimation *moonRunAnimation = [CCAnimation animationWithSpriteFrames:moonAnimFrames delay:0.2f];
    CCAction *moonRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: moonRunAnimation]];
    [moon setTexture:[moonBatchNode texture]];
    [moon runAction:moonRunAction];
    moon.position = ccp(jokerLocationX+ moonLocationX, s.height-moonLocationY);
    [moonBatchNode addChild:moon z:1];
}

-(void)initBackground
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    switch (backgroundLevel) {
        case 1:
            if(frontOpen) {
                //--------------------Front Background--------------------//
                bgFront1 = [CCSprite spriteWithFile:@"background_front.png"];     
                bgFront2 = [CCSprite spriteWithFile:@"background_front.png"];
//                bgFront1 = [CCSprite spriteWithFile:@"level3_bg.png"];
//                bgFront2 = [CCSprite spriteWithFile:@"level3_bg.png"];
            }
            if(middleOpen) {
                //--------------------Middle Background--------------------//
                bgMiddle1 = [CCSprite spriteWithFile:@"background_middle.png"];                
                bgMiddle2 = [CCSprite spriteWithFile:@"background_middle.png"];
//                bgMiddle1 = [CCSprite spriteWithFile:@"level3_bg_front.png"];
//                bgMiddle2 = [CCSprite spriteWithFile:@"level3_bg_front.png"];
            }
            if(backOpen) {
                //--------------------Back Background--------------------//
                bgBack1 = [CCSprite spriteWithFile:@"mbg_layer3.png"];
                bgBack2 = [CCSprite spriteWithFile:@"mbg_layer3.png"];
            }
            break;
        case 2:
            if(frontOpen) {
                //--------------------Front Background--------------------//
                bgFront1 = [CCSprite spriteWithFile:@"level2_bg_1.png"];                
                bgFront2 = [CCSprite spriteWithFile:@"level2_bg_1.png"];
            }
            if(middleOpen) {
                //--------------------Middle Background--------------------//
                bgMiddle1 = [CCSprite spriteWithFile:@"level2_bg_2.png"];
                bgMiddle2 = [CCSprite spriteWithFile:@"level2_bg_2.png"];
            }
            if(backOpen) {
                //--------------------Back Background--------------------//
                bgBack1 = [CCSprite spriteWithFile:@"mbg_layer3.png"];       
                bgBack2 = [CCSprite spriteWithFile:@"mbg_layer3.png"];
            }
            break;
        case 3:
            if(frontOpen) {
                //--------------------Front Background--------------------//
//                bgFront1 = [CCSprite spriteWithFile:@"background_front.png"];
//                bgFront2 = [CCSprite spriteWithFile:@"background_front.png"];
                bgFront1 = [CCSprite spriteWithFile:@"level3_bg.png"];
                bgFront2 = [CCSprite spriteWithFile:@"level3_bg.png"];
            }
            if(middleOpen) {
                //--------------------Middle Background--------------------//
//                bgMiddle1 = [CCSprite spriteWithFile:@"background_middle.png"];
//                bgMiddle2 = [CCSprite spriteWithFile:@"background_middle.png"];
                bgMiddle1 = [CCSprite spriteWithFile:@"level3_bg_front.png"];
                bgMiddle2 = [CCSprite spriteWithFile:@"level3_bg_front.png"];
            }
            if(backOpen) {
                //--------------------Back Background--------------------//
                bgBack1 = [CCSprite spriteWithFile:@"mbg_layer3.png"];
                bgBack2 = [CCSprite spriteWithFile:@"mbg_layer3.png"];
            }
            break;
            
        default:
            break;
    }
    if(frontOpen) {
        //    bgFront1.position = ccp(s.width*0.5f,12*PTM_RATIO);
        bgFront1.anchorPoint = ccp(0,0);
        bgFront1.position = ccp(0,0);
        //    bgFront1.scale = 1;
        [self addChild:bgFront1 z:-1];
        
        //    bgFront2.position = ccp(s.width+s.width*0.5f,12*PTM_RATIO);
        bgFront2.anchorPoint = ccp(0,0);
        bgFront2.position = ccp(s.width, 0);
        //    bgFront2.scale = 1;
        bgFront2.flipX = true;
        [self addChild:bgFront2 z:-1];
    }
    
    if(middleOpen) {
        bgMiddle1.anchorPoint = ccp(0,0);
        bgMiddle1.position = ccp(0,0);
        //                bgMiddle1.scale = 1;
        [self addChild:bgMiddle1 z:-2];
        
        bgMiddle2.anchorPoint = ccp(0,0);
        bgMiddle2.position = ccp(s.width, 0);
        //                bgMiddle2.scale = 1;
        bgMiddle2.flipX = true;
        [self addChild:bgMiddle2 z:-2];
    }
    
    if(backOpen) {
        bgBack1.anchorPoint = ccp(0,0);
        bgBack1.position = ccp(0,0);
        //                bgBack1.scale = 1;
        [self addChild:bgBack1 z:-3];
        
        bgBack2.anchorPoint = ccp(0,0);
        bgBack2.position = ccp(s.width, 0);
        //                bgBack2.scale = 1;
        bgBack2.flipX = true;
        [self addChild:bgBack2 z:-3];
    }

}


-(void)scrollBackground:(ccTime)dt
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    CGPoint pos1, pos2;
    if(frontOpen) {
    //--------------------Front Background--------------------//
    pos1 = bgFront1.position;
    pos2 = bgFront2.position;
    pos1.x -= frontSpeed;
    pos2.x -= frontSpeed;
    if(pos1.x <=-(s.width) )
    {
        pos1.x = pos2.x + s.width;
    }
    if(pos2.x <=-(s.width) )
    {
        pos2.x = pos1.x + s.width;
    }
    bgFront1.position = pos1;
    bgFront2.position = pos2;
    }
    if(middleOpen) {
    //--------------------Middle Background--------------------//
    pos1 = bgMiddle1.position;
    pos2 = bgMiddle2.position;
    pos1.x -= middleSpeed;
    pos2.x -= middleSpeed;
    if(pos1.x <=-(s.width) )
    {
        pos1.x = pos2.x + s.width;
    }
    if(pos2.x <=-(s.width) )
    {
        pos2.x = pos1.x + s.width;
    }
    bgMiddle1.position = pos1;
    bgMiddle2.position = pos2;
    }
    if(backOpen) {
    //--------------------Back Background--------------------//
    pos1 = bgBack1.position;
    pos2 = bgBack2.position;
    pos1.x -= backSpeed;
    pos2.x -= backSpeed;
    if(pos1.x <=-(s.width) )
    {
        pos1.x = pos2.x + s.width;
    }
    if(pos2.x <=-(s.width) )
    {
        pos2.x = pos1.x + s.width;
    }
    bgBack1.position = pos1;
    bgBack2.position = pos2;
    }
}

-(void)tick:(ccTime)dt
{
    [self scrollBackground:dt];
}

@end
