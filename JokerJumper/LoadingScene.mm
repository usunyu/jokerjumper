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
        CGSize size = [[CCDirector sharedDirector] winSize];
        label = [CCLabelTTF labelWithString: @"Loading ..." fontName: @"Marker Felt" fontSize: 64 ];
        label.position=ccp(size.width/2,size.height/ 2);
        count=1;
        [ self addChild:label];
        //[self schedule:@selector(updateCount:) interval:0.2f];
        //[self schedule:@selector(update:) interval:3.0f];
        [ self scheduleUpdate];
    }
    return self ;
}

-( void ) updateCoin:(ccTime)delta
{
    count++;
    if(count==7)
    {
        count=1;
    }
    switch(count)
    {
        case 1:[label setString:@"Loading ."];break;
        case 2:[label setString:@"Loading .."];break;
        case 3:[label setString:@"Loading ..."];break;
        case 4:[label setString:@"Loading ...."];break;
        case 5:[label setString:@"Loading ....."];break;
        case 6:[label setString:@"Loading ......"];break;
            
    }
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
