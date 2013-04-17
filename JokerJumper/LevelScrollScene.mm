//
//  LevelScrollScene.m
//  JokerJumper
//
//  Created by Sun on 4/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Constants.h"
#import "GameScene.h"
#import "LevelScrollLayer.h"
#import "LevelScrollScene.h"
#import "LoadingScene.h"


@implementation LevelScrollScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    LevelScrollScene *layer = [LevelScrollScene node];
    [scene addChild:layer];
    
	// return the scene
	return scene;
}

- (void)buttonAction1:(id)sender {
//    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_ONE]]];
    CCScene * newScene = [LoadingScene sceneWithTargetScene : GAME_STATE_ONE ];
    [[ CCDirector sharedDirector ] replaceScene :newScene];
}

- (void)buttonAction2:(id)sender {
//    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_TWO]]];
    CCScene * newScene = [LoadingScene sceneWithTargetScene : GAME_STATE_TWO ];
    [[ CCDirector sharedDirector ] replaceScene :newScene];
}

- (void)buttonAction3:(id)sender {
//    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_THREE]]];
    CCScene * newScene = [LoadingScene sceneWithTargetScene : GAME_STATE_THREE ];
    [[ CCDirector sharedDirector ] replaceScene :newScene];
}

-(id) init
{
	if( (self=[super init])) {
        // get screen size
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        /////////////////////////////////////////////////
        // PAGE 1
        ////////////////////////////////////////////////
        // create a blank layer for page 1
        CCLayer *pageOne = [[CCLayer alloc] init];
        // create an image button for page 1
        CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:@"menu.png" selectedImage:@"menu.png" target:self selector:@selector(buttonAction1:)];
        CCMenu *Menu1 = [CCMenu menuWithItems:button1, nil];
        Menu1.position=ccp(screenSize.width/2, screenSize.height/2);
        [Menu1 alignItemsHorizontally];
        [pageOne addChild:Menu1];
        // create a label for page 1
        CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Stage 1" fontName:@"Arial Rounded MT Bold" fontSize:44];
        label1.position =  ccp( screenSize.width /2 , 50 );
        // add label to page 1 layer
        [pageOne addChild:label1];
        
        /////////////////////////////////////////////////
        // PAGE 2
        ////////////////////////////////////////////////
        // create a blank layer for page 2
        CCLayer *pageTwo = [[CCLayer alloc] init];
        // create an image button for page 2
        CCMenuItem *button2 = [CCMenuItemImage itemWithNormalImage:@"menu.png" selectedImage:@"menu.png" target:self selector:@selector(buttonAction2:)];
        CCMenu *Menu2 = [CCMenu menuWithItems:button2, nil];
        Menu2.position=ccp(screenSize.width/2, screenSize.height/2);
        [Menu2 alignItemsHorizontally];
        [pageTwo addChild:Menu2];
        // create a label for page 2
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Stage 2" fontName:@"Arial Rounded MT Bold" fontSize:44];
        label2.position =  ccp( screenSize.width /2 , 50 );
        // add label to page 2 layer
        [pageTwo addChild:label2];
        /////////////////////////////////////////////////
        // PAGE 3
        ////////////////////////////////////////////////
        
        CCLayer *pageThree = [[CCLayer alloc] init];
        // create an image button for page 2
        CCMenuItem *button3 = [CCMenuItemImage itemWithNormalImage:@"menu.png" selectedImage:@"menu.png" target:self selector:@selector(buttonAction3:)];
        CCMenu *Menu3 = [CCMenu menuWithItems:button3, nil];
        Menu3.position=ccp(screenSize.width/2, screenSize.height/2);
        [Menu3 alignItemsHorizontally];
        [pageThree addChild:Menu3];
        // create a label for page 3
        CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"Stage 3" fontName:@"Arial Rounded MT Bold" fontSize:44];
        label3.position =  ccp( screenSize.width /2 , 50 );
        // add label to page 3 layer
        [pageThree addChild:label3];
        
        // now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
        LevelScrollLayer *scroller = [[LevelScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: pageOne,pageTwo,pageThree,nil] widthOffset: 230];
        // finally add the scroller to your scene
        [self addChild:scroller];
    }
    return self;
}

@end
