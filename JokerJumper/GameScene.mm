//
//  GameScene.m
//  JokerJumper
//
//  Created by Sun on 3/29/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"
#import "BackgroundLayer.h"

@implementation GameScene
@synthesize tileMapNode;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    BackgroundLayer *backgroundLayer = [BackgroundLayer node];
    [scene addChild:backgroundLayer z:1];
    
	// 'layer' is an autorelease object.
	GameLayer *gameLayer = [GameLayer node];
	// add layer as a child to scene
	[scene addChild: gameLayer z:1];
	
	// return the scene
	return scene;
}

@end
