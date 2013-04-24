//
//  MainMenuLayer.m
//  JokerJumper
//
//  Created by Sun on 2/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "CCControlButton.h"
#import "CCBReader.h"
#import "LevelScrollScene.h"
#import "GameScene.h"
#import "Constants.h"

#define PLAY_BUTTON_TAG 1
#define OPTIONS_BUTTON_TAG 2
#define ABOUT_BUTTON_TAG 3

CCSprite *bg;
CCSprite *play;
CCSprite* joker;
CCSprite* enemy1;
CCSprite* enemy2;
CCSprite* enemy3;
CCSprite* enemy4;
CCSprite* cloudleft;
CCSprite* cloudright;
CCSprite* caption;
CCSprite* light;
CCSprite* sun;
CCSprite* grass;

//CCSpriteBatchNode* bgBatchNode;
CCSpriteBatchNode* playButtonBatchNode;
CCSpriteBatchNode* characterBatchNode;
CCSpriteBatchNode* enemy2BatchNode;
CCSpriteBatchNode* captionBatchNode;

CCFiniteTimeAction *moveAction1;
CCFiniteTimeAction *moveAction2;
CCFiniteTimeAction *moveAction3;
CCFiniteTimeAction *moveAction4;

@implementation MainMenuLayer

- (id) init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        bg = [CCSprite spriteWithFile:@"bg.png"];
        bg.anchorPoint = ccp(0, 0);
        [self addChild: bg z:-5];
        
        // Play Button
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btn_play_default.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"all_character_default.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pokerSoilder_default.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"caption_default.plist"];
        
        characterBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"all_character_default.png"];
        enemy2BatchNode=[CCSpriteBatchNode batchNodeWithFile:@"pokerSoilder_default.png"];
        playButtonBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"btn_play_default.png"];
        captionBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"caption_default.png"];
        [self addChild:characterBatchNode z:1];
        [self addChild:enemy2BatchNode z:2];
        [self addChild:playButtonBatchNode z:10];
        [self addChild:captionBatchNode z:10];
        
        light=[CCSprite spriteWithFile:@"light.png"];
        light.opacity=50;
        CCRotateBy *rot = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:20.0 angle: 360]];
        [light runAction:rot];
        light.position=ccp(winSize.width/2+120, winSize.height/2-300);
        [self addChild:light z:-4];
        
        sun=[CCSprite spriteWithFile:@"sun.png"];
        sun.position=ccp(winSize.width/2+150,winSize.height/2-50);
        [self addChild:sun z:-3];
        
        grass=[CCSprite spriteWithFile:@"ground.png"];
        grass.position=ccp(winSize.width/2,100);
        [self addChild:sun z:-2];
        
        CCLOG(@"here0");
        play = [CCSprite spriteWithSpriteFrameName:@"btn_play0.png"];
        NSMutableArray *bgAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 16; ++i) {
            [bgAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"btn_play%d.png", i]]];
        }
        
        CCAnimation *playRunAnimation = [CCAnimation animationWithSpriteFrames:bgAnimFrames delay:0.1f];
        CCAction *playRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: playRunAnimation]];
        [play setTexture:[playButtonBatchNode texture]];
        [play runAction:playRunAction];
        play.anchorPoint = ccp(0, 0);
        [playButtonBatchNode addChild:play z:1];
        play.position = ccp(winSize.width/2 -40, winSize.height/2 - 525);
        //        play.position = ccp(500, 200);
        NSLog(@"X: %f, Y: %f", winSize.width/2 -40, winSize.height/2 - 525);
        CCLOG(@"here1");
        
        caption = [CCSprite spriteWithSpriteFrameName:@"caption0.png"];
        NSMutableArray *caAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 11; ++i) {
            [caAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"caption%d.png", i]]];
        }
        
        CCAnimation *captionRunAnimation = [CCAnimation animationWithSpriteFrames:caAnimFrames delay:0.1f];
        CCAction *captionRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: captionRunAnimation]];
        [caption setTexture:[captionBatchNode texture]];
        [caption runAction:captionRunAction];
        caption.anchorPoint = ccp(0, 0);
        [captionBatchNode addChild:caption z:1];
        caption.position = ccp(winSize.width/2 -120, winSize.height/2-50);
        
        joker=[CCSprite spriteWithSpriteFrameName:@"joker1.png"];
        enemy1=[CCSprite spriteWithSpriteFrameName:@"green_monster0.png"];
        enemy2=[CCSprite spriteWithSpriteFrameName:@"pokerSoilder0.png"];
        enemy3=[CCSprite spriteWithSpriteFrameName:@"enermy1.png"];
        
        joker.position=ccp(0,160);
        enemy1.position=ccp(-150,160);
        enemy2.position=ccp(-250,300);
        enemy3.position=ccp(-350,160);
        
        CCLOG(@"here2");
        NSMutableArray *jokerrunAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 14; ++i) {
            [jokerrunAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"joker%d.png", i]]];
        }
        CCAnimation *jokerRunAnimation = [CCAnimation animationWithSpriteFrames:jokerrunAnimFrames delay:0.09f];
        CCAction *jokerRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: jokerRunAnimation]];
        jokerRunAction.tag = jokerRunActionTag;
        [joker runAction:jokerRunAction];
        [characterBatchNode addChild:joker];
        moveAction1=[CCRepeat actionWithAction: [CCMoveTo actionWithDuration:6.0f position:ccp(winSize.width+500,160)] times:1];
        joker.scale=1.5;
        [joker runAction:moveAction1];
        
        CCLOG(@"here3");
        NSMutableArray *enemy1runAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 7; ++i) {
            [enemy1runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"green_monster%d.png", i]]];
        }
        CCAnimation *enemy1RunAnimation = [CCAnimation animationWithSpriteFrames:enemy1runAnimFrames delay:0.09f];
        CCAction *enemy1RunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: enemy1RunAnimation]];
        enemy1.scale=1.5;
        [enemy1 runAction:enemy1RunAction];
        [characterBatchNode addChild:enemy1];
        moveAction2=[CCRepeat actionWithAction: [CCMoveTo actionWithDuration:6.0f position:ccp(winSize.width+500,160)] times:1];
        [enemy1 runAction: moveAction2];
        
        CCLOG(@"here4");
        NSMutableArray *enemy2runAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 9; ++i) {
            [enemy2runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"pokerSoilder%d.png", i]]];
        }
        CCAnimation *enemy2RunAnimation = [CCAnimation animationWithSpriteFrames:enemy2runAnimFrames delay:0.09f];
        CCAction *enemy2RunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: enemy2RunAnimation]];
        enemy2RunAction.tag = jokerRunActionTag;
        enemy2.scale=1.5;
        [enemy2 runAction:enemy2RunAction];
        [enemy2BatchNode addChild:enemy2];
        moveAction3=[CCRepeat actionWithAction: [CCMoveTo actionWithDuration:6.0f position:ccp(winSize.width+500,300)] times:1];
        [enemy2 runAction: moveAction3];
        
        CCLOG(@"here5");
        NSMutableArray *enemy3runAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 7; ++i) {
            [enemy3runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"enermy%d.png", i]]];
        }
        CCAnimation *enemy3RunAnimation = [CCAnimation animationWithSpriteFrames:enemy3runAnimFrames delay:0.09f];
        CCAction *enemy3RunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: enemy3RunAnimation]];
        enemy3RunAction.tag = jokerRunActionTag;
        enemy3.scale=1.5;
        [characterBatchNode addChild:enemy3];
        [enemy3 runAction:enemy3RunAction];
        moveAction4=[CCRepeat actionWithAction: [CCMoveTo actionWithDuration:9.0f position:ccp(winSize.width+500,160)] times:1];
        [enemy3 runAction: moveAction4];
        
        
        
        // Create Replay Button
        CCMenuItem *playButton = [CCMenuItemImage itemWithNormalImage:@"btn_play0.png" selectedImage:@"btn_play0.png" target:self selector:@selector(buttonReplayAction:)];
        playButton.scale = 1.3;
        CCMenu *Menu = [CCMenu menuWithItems:playButton, nil];
        Menu.position=ccp(500, 150);
        
        Menu.opacity = 0;
        
        [self addChild:Menu z:1];
        [self schedule:@selector(updateObject:) interval:10.0f];
        
        //        [CCMenuItemImage itemWithNormalImage:@"button_play_sel.png" selectedImage:@"button_play_sel.png" target:self selector:@selector(buttonReplayAction:)];
        
        
        /*[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"StartMenu_default.plist"];
         bgBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"StartMenu_default.png"];
         [self addChild:bgBatchNode z:0];
         
         bg=[CCSprite spriteWithSpriteFrameName:@"StartMenu0.png"];
         NSMutableArray *bgAnimFrames = [NSMutableArray array];
         for(int i = 0; i <= 1; ++i) {
         [bgAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
         [NSString stringWithFormat:@"StartMenu%d.png", i]]];
         }
         
         CCAnimation *bgRunAnimation = [CCAnimation animationWithSpriteFrames:bgAnimFrames delay:0.5f];
         CCAction *bgRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: bgRunAnimation]];
         [bg setTexture:[bgBatchNode texture]];
         [bg runAction:bgRunAction];
         bg.anchorPoint = ccp(0, 0);
         [bgBatchNode addChild:bg z:1];*/
        
        
        
        /*// Create Replay Button
         CCMenuItem *buttonPlay = [CCMenuItemImage itemWithNormalImage:@"button_play_sel.png" selectedImage:@"button_play_sel.png" target:self selector:@selector(buttonReplayAction:)];
         
         // Create Option Button
         CCMenuItem *buttonOption = [CCMenuItemImage itemWithNormalImage:@"button_option_sel.png" selectedImage:@"button_option_sel.png" target:self selector:@selector(buttonOptionAction:)];
         
         // Create About Button
         CCMenuItem *buttonAbout = [CCMenuItemImage itemWithNormalImage:@"button_about_sel.png" selectedImage:@"button_about_sel.png" target:self selector:@selector(buttonAboutAction:)];
         
         CCMenu *Menu = [CCMenu menuWithItems:buttonPlay, buttonOption, buttonAbout, nil];
         //        Menu.position=ccp(winSize.width/2 + 400, winSize.height/2 - 200);
         Menu.position=ccp(820, 250);
         
         [Menu alignItemsVertically];
         [self addChild:Menu z:1];*/
        
    }
    return self;
}

- (void)updateObject:(ccTime) dt
{
    joker.position=ccp(0,160);
    enemy1.position=ccp(-150,160);
    enemy2.position=ccp(-250,300);
    enemy3.position=ccp(-350,160);
    
    [joker runAction: moveAction1];
    [enemy1 runAction: moveAction2];
    [enemy2 runAction: moveAction3];
    [enemy3 runAction: moveAction4];
    
}


-(void) buttonReplayAction:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:1.0 scene:[LevelScrollScene scene]]];
}

-(void) buttonOptionAction:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"OptionsScene.ccbi"]]];
}

-(void) buttonAboutAction:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"AboutScene.ccbi"]]];
}

//-(void)buttonPressed:(id)sender {
//    CCControlButton *button = (CCControlButton*) sender;
//    switch (button.tag) {
//        case PLAY_BUTTON_TAG:
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[LevelScrollScene scene]]];
////            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"LevelScene.ccbi"]]];
//            break;
//        case OPTIONS_BUTTON_TAG:
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"OptionsScene.ccbi"]]];
//            break;
//        case ABOUT_BUTTON_TAG:
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"AboutScene.ccbi"]]];
//            break;
//    }
//}

@end