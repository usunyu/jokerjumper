//
//  GameOptionsScene.h
//  JokerJumper
//
//  Created by Sun on 4/23/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOptionsScene : CCLayer {
    
}

+(CCScene *) sceneWithLevel:(int)level Coin:(int)coin Distance:(int)distance;

@end
