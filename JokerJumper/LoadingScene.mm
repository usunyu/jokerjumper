//
//  LoadingScene.m
//  JokerJumper
//
//  Created by Sun on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Constants.h"
#import "GameScene.h"
#import "LoadingScene.h"


@implementation LoadingScene

+( id ) sceneWithTargetScene:(int)gameStage;
{
    return [[ self alloc] initWithTargetScene:gameStage];
}

-( id ) initWithTargetScene:(int)gameStage
{
    if (( self = [ super init]))
    {
        GameStage = gameStage;
        
        CCLabelTTF* label = [CCLabelTTF labelWithString: @"Loading ..." fontName: @"Marker Felt" fontSize: 64 ];
        CGSize size = [[CCDirector sharedDirector] winSize];
        label.position = CGPointMake(size.width / 2 , size.height / 2 );
        [ self addChild:label];
        [ self scheduleUpdate];
    }
    return self ;
}

-( void ) update:(ccTime)delta
{
    [ self unscheduleAllSelectors];
    switch (GameStage)
    {
        case GAME_STATE_ONE:
            [[CCDirector sharedDirector] replaceScene:[GameScene sceneWithState:GAME_STATE_ONE]];
            break ;
        case GAME_STATE_TWO:
            [[CCDirector sharedDirector] replaceScene:[GameScene sceneWithState:GAME_STATE_TWO]];
            break ;
        case GAME_STATE_THREE:
            [[CCDirector sharedDirector] replaceScene:[GameScene sceneWithState:GAME_STATE_TWO]];
            break ;
        default :
            break ;
    }
}

@end
