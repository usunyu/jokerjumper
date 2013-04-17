//
//  MainMenuScene.m
//  JokerJumper
//
//  Created by Sun on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "MainMenuLayer.h"


@implementation MainMenuScene

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    MainMenuScene *layer = [MainMenuScene node];
    [scene addChild:layer z:1];

	// 'layer' is an autorelease object.
	MainMenuLayer *menuLayer = [MainMenuLayer node];
	// add layer as a child to scene
	[scene addChild: menuLayer z:1];
    
	return scene;
}


@end
