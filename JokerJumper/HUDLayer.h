//
//  HUDLayer.h
//  JokerJumper
//
//  Created by Sun on 3/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
#import "BackgroundLayer.h"
#import "GameLayer.h"
#import "CCBReader.h"
#import "Constants.h"
#import "Joker.h"
#import "GameObject.h"
#import "SimpleAudioEngine.h"

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HUDLayer : CCLayer {
    CCLabelBMFont *lifeLabel;
    CCLabelBMFont *statusLabel;
    CCLabelBMFont *coinLabel;
    
    CCMenuItemImage *pause;
    
    CCSprite *coinBar;
    CCSprite *disBar;
    CCSprite *lifeBar;
    
}
-(void) updateLifeCounter:(int)amount;
-(void) updateCoinCounter:(int)amount;
-(void) updateStatusCounter:(float)amount;
+(HUDLayer*) getHUDLayer;
@property (nonatomic, readwrite)CCLabelBMFont * lifeLabel;
@property (nonatomic, readwrite)CCLabelBMFont * statusLabel;
@property (nonatomic, readwrite)CCLabelBMFont * coinLabel;
@end

