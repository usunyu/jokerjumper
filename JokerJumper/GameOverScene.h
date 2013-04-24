//
//  GameOverScene.h
//  JokerJumper
//
//  Created by Sun on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOverScene : CCLayer {
    CCLabelTTF *labelCoin;
    CCLabelTTF *labelDistance;
    
    CCMenuItem *buttonReplay;
    CCLabelTTF *labelReplay;
    
    CCMenuItem *buttonMain;
    CCLabelTTF *labelMain;
}

//+(CCScene *) scene;
+(CCScene *) sceneWithLevel:(int)level Coin:(int)coin Distance:(int)distance;

@end
