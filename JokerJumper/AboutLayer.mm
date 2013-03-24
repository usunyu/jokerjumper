//
//  AboutLayer.m
//  JokerJumper
//
//  Created by Sun on 2/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "AboutLayer.h"
#import "CCBReader.h"

@implementation AboutLayer

-(void)backButtonPressed:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"]]];
}

@end
