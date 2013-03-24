//
//  GameLayer.h
//  JokerJumper
//
//  Created by Sun on 2/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "ContactListener.h"

#define jokerRunActionTag 1
#define mapTag 2

#define jokerLocationX 60
#define jokerLocationY 250

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32//kGameObjectCoin

#define IS_COIN1(x, y)       ((x.type == kGameObjectJoker)&&(y.type == kGameObjectCoin))
#define IS_COIN2(x, y)       ((x.type == kGameObjectCoin)&&(y.type == kGameObjectJoker))
#define IS_PLAT1(x, y)      ((x.type == kGameObjectJoker)&&(y.type == kGameObjectPlatform))
#define IS_PLAT2(x, y)      ((x.type == kGameObjectPlatform)&&(y.type == kGameObjectJoker))

@class Joker;
@class Platform;

@interface GameLayer : CCLayer {
    CCLabelTTF *_label;
    CCSpriteBatchNode *jokerBatchNode;
    b2World* world;
	CCTMXTiledMap *tileMapNode;
	b2Body *playerBody;
    int coinCount;
    float distance;
    CCSprite *coinBar;
    CCSprite *disBar;
    Joker *joker;
    ContactListener *contactListener;
    CCLabelBMFont *statusLabel;
    int flyPos;
    BOOL jokerStartCharge;
    float jokerCharge;
}
+(GameLayer*) getGameLayer;
@property (retain, nonatomic) CCLabelBMFont *statusLabel;
@property (retain, nonatomic) CCLabelBMFont *distanceLabel;
@property (nonatomic, readwrite) int coinCount;
@property  (nonatomic, readwrite) float distance;
@property (nonatomic, readwrite) b2World* world;
@property (nonatomic, readwrite) Joker* joker;
@property (nonatomic, readwrite) CCSprite *coinBar;
@property (nonatomic, readwrite) CCSprite *disBar;
@property (nonatomic, readwrite) int flyPos;

@end
