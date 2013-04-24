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
//CCSpriteBatchNode* bgBatchNode;
CCSpriteBatchNode* playButtonBatchNode;

@implementation MainMenuLayer

- (id) init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        bg = [CCSprite spriteWithFile:@"start_menu.png"];
        bg.anchorPoint = ccp(0, 0);
        [self addChild: bg];
        
        // Play Button
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btn_play_default.plist"];
        playButtonBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"btn_play_default.png"];
        [self addChild:playButtonBatchNode z:1];
        
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
        play.position = ccp(winSize.width/2, winSize.height/2 - 300);
        
        
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
        
        
        
        // Create Replay Button
        CCMenuItem *buttonPlay = [CCMenuItemImage itemWithNormalImage:@"button_play_sel.png" selectedImage:@"button_play_sel.png" target:self selector:@selector(buttonReplayAction:)];
        
        // Create Option Button
        CCMenuItem *buttonOption = [CCMenuItemImage itemWithNormalImage:@"button_option_sel.png" selectedImage:@"button_option_sel.png" target:self selector:@selector(buttonOptionAction:)];
        
        // Create About Button
        CCMenuItem *buttonAbout = [CCMenuItemImage itemWithNormalImage:@"button_about_sel.png" selectedImage:@"button_about_sel.png" target:self selector:@selector(buttonAboutAction:)];
        
        CCMenu *Menu = [CCMenu menuWithItems:buttonPlay, buttonOption, buttonAbout, nil];
//        Menu.position=ccp(winSize.width/2 + 400, winSize.height/2 - 200);
        Menu.position=ccp(820, 250);
        
        [Menu alignItemsVertically];
        [self addChild:Menu z:1];
        
    }
    return self;
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