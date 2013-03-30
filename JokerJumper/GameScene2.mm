//
//  GameScene2.m
//  JokerJumper
//
//  Created by Sun on 3/30/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameScene2.h"
#import "GameLayer2.h"

@implementation GameScene2

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	GameLayer2 *gameLayer = [GameLayer2 node];
	// add layer as a child to scene
	[scene addChild: gameLayer z:1];
	
	// return the scene
	return scene;
}

@end
