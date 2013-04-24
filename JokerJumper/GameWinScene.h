//
//  GameOverScene.h
//  JokerJumper
//
//  Created by Sun on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface GameWinScene : CCLayerColor <CCTargetedTouchDelegate> {
    CCMenuItem *button;
    CCMenu *Menu;
    
    CCLabelTTF *labelCoin;
    CCLabelTTF *labelDistance;
}

+(CCScene *) scene;
+(CCScene *) sceneWithLevel:(int)level Coin:(int)coin Distance:(int)distance;

@end
