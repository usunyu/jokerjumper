//
//  LoadingScene.h
//  JokerJumper
//
//  Created by Sun on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LoadingScene : CCScene {
    int GameStage;
}

+( id ) sceneWithTargetScene:(int)gameStage;
-( id ) initWithTargetScene:(int)gameStage;
-( void ) update:(ccTime)delta;

@end
