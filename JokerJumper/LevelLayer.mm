//
//  LevelLayer.m
//  JokerJumper
//
//  Created by Sun on 3/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelLayer.h"
#import "CCControlButton.h"
#import "CCBReader.h"
#import "GameScene.h"
#import "GameScene2.h"
#import "GameScene3.h"

@implementation LevelLayer

-(void)backButtonPressed:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"]]];
}

-(void)buttonPressed:(id)sender {
    CCControlButton *button = (CCControlButton*) sender;
    switch (button.tag) {
        case 1:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[GameScene scene]]];
            break;
        case 2:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[GameScene2 scene]]];
            break;
        case 3:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[GameScene3 scene]]];
            break;
    }
}

@end
