//
//  GameScene.m
//  JokerJumper
//
//  Created by Sun on 3/29/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"
#import "GameLayer2.h"
#import "GameLayer3.h"
#import "BackgroundLayer.h"
#import "HUDLayer.h"
#import "PauseLayer.h"
#import "Constants.h"

@implementation GameScene
@synthesize tileMapNode,
showingPausedMenu = showingPausedMenu_;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    GameScene *layer = [GameScene node];
    [scene addChild:layer z:3];
    
    
//    HUDLayer *hudLayer = [HUDLayer node];
    // add layer as a child to scene
//    [scene addChild: hudLayer z:1 tag:HUD_LAYER_TAG];
    
    
    BackgroundLayer *backgroundLayer = [BackgroundLayer node];
    [scene addChild:backgroundLayer z:-1];
    
	// 'layer' is an autorelease object.
	GameLayer *gameLayer = [GameLayer node];
	// add layer as a child to scene
	[scene addChild: gameLayer z:1];
	
    HUDLayer *hudLayer = [HUDLayer node];
	// add layer as a child to scene
	[scene addChild: hudLayer z:3 tag:HUD_LAYER_TAG];
	// return the scene
	return scene;
}

+(CCScene *) sceneWithState:(int)state {
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    GameScene *layer = [GameScene node];
    [scene addChild:layer z:3];
    switch (state) {
        case GAME_STATE_ONE:
        {
            BackgroundLayer *backgroundLayer = [BackgroundLayer node];
            [scene addChild:backgroundLayer z:-1];
            
            // 'layer' is an autorelease object.
            GameLayer *gameLayer = [GameLayer node];
            // add layer as a child to scene
            [scene addChild: gameLayer z:1];
            
            HUDLayer *hudLayer = [HUDLayer node];
            // add layer as a child to scene
            [scene addChild: hudLayer z:3 tag:HUD_LAYER_TAG];
            break;
        }
        case GAME_STATE_TWO:
        {
            BackgroundLayer *backgroundLayer = [BackgroundLayer node];
            [scene addChild:backgroundLayer z:-1];
            
            // 'layer' is an autorelease object.
            GameLayer *gameLayer = [GameLayer2 node];
            // add layer as a child to scene
            [scene addChild: gameLayer z:1];
            
            HUDLayer *hudLayer = [HUDLayer node];
            // add layer as a child to scene
            [scene addChild: hudLayer z:3 tag:HUD_LAYER_TAG];
            break;
        }
        case GAME_STATE_THREE:
        {
            BackgroundLayer *backgroundLayer = [BackgroundLayer node];
            [scene addChild:backgroundLayer z:-1];
            
            // 'layer' is an autorelease object.
            GameLayer *gameLayer = [GameLayer3 node];
            // add layer as a child to scene
            [scene addChild: gameLayer z:1];
            
            HUDLayer *hudLayer = [HUDLayer node];
            // add layer as a child to scene
            [scene addChild: hudLayer z:3 tag:HUD_LAYER_TAG];
            break;
        }
        default:
            
            break;
    }
	return scene;
}

static GameScene* instanceOfGameScene;

-(id) init
{
	if( (self=[super init])) {
        instanceOfGameScene = self;
		self.isTouchEnabled = YES;
		self.showingPausedMenu = NO;
//        BackgroundLayer *backgroundLayer = [BackgroundLayer node];
//        [self addChild:backgroundLayer z:1];
        
        // 'layer' is an autorelease object.
//        GameLayer *gameLayer = [GameLayer node];
        // add layer as a child to scene
//        [self addChild: gameLayer z:2];
        
//        HUDLayer *hudLayer = [HUDLayer node];
        // add layer as a child to scene
//        [self addChild: hudLayer z:3 tag:HUD_LAYER_TAG];
        // return the scene
    }
    return self;
}

- (void)showPausedMenu {
    PauseLayer *pauzy = [PauseLayer node];
    [self addChild:pauzy z:1 tag:PAUSE_LAYER_TAG];
//    CCScene* scene = [[CCDirector sharedDirector] runningScene];
//    [scene addChild:pauzy z:4 tag:PAUSE_LAYER_TAG];
}



+ (GameScene *) sharedGameScene
{
	NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
	return instanceOfGameScene;
}

@end
