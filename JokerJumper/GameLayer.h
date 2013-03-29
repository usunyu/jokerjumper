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
#import "GameObject.h"
#include <deque>

#define jokerRunActionTag 1
#define mapTag 2

#define jokerLocationX 350
#define jokerLocationY 250
#define emenyLocationX 50
#define emenyLocationY 250

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32//kGameObjectCoin

#define IS_PLAT(x)          ((x==kGameObjectPlatform1)||(x==kGameObjectPlatform2)||(x==kGameObjectPlatform3))
#define IS_COIN(x)          ((x==kGameObjectCoin)||(x==kGameObjectCoin1)||(x==kGameObjectCoin2)||(x==kGameObjectCoin3))

#define IS_COINTYPE(x, y)      (((x.type == kGameObjectJoker)&&(IS_COIN(y.type)))||((IS_COIN(x.type))&&(y.type == kGameObjectJoker)))
#define IS_PLATTYPE(x, y)      (((x.type == kGameObjectJoker)&&(IS_PLAT(y.type)))||((IS_PLAT(x.type))&&(y.type == kGameObjectJoker)))

#define IS_COIN0TYPE(x,y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectCoin))||((x.type == kGameObjectCoin)&&(y.type == kGameObjectJoker)))
#define IS_COIN1TYPE(x,y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectCoin1))||((x.type == kGameObjectCoin1)&&(y.type == kGameObjectJoker)))
#define IS_COIN2TYPE(x,y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectCoin2))||((x.type == kGameObjectCoin2)&&(y.type == kGameObjectJoker)))
#define IS_COIN3TYPE(x,y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectCoin3))||((x.type == kGameObjectCoin3)&&(y.type == kGameObjectJoker)))

#define IS_PLAT1TYPE(x, y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectPlatform1))||((x.type == kGameObjectPlatform1)&&(y.type == kGameObjectJoker)))
#define IS_PLAT2TYPE(x, y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectPlatform2))||((x.type == kGameObjectPlatform2)&&(y.type == kGameObjectJoker)))
#define IS_PLAT3TYPE(x, y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectPlatform3))||((x.type == kGameObjectPlatform3)&&(y.type == kGameObjectJoker)))

struct State {
    CGPoint position;
    b2Vec2 velocity;
    float gravityScale;
};

@class Joker;
@class Platform;
@class MapLayer;

@interface GameLayer : CCLayer {
    CCLabelTTF *_label;
    CCSpriteBatchNode *jokerBatchNode;
    CCSpriteBatchNode *emenyBatchNode;
    b2World* world;
	CCTMXTiledMap *tileMapNode;
	b2Body *playerBody;
    int coinCount;
    float distance;
    CCSprite *coinBar;
    CCSprite *disBar;
    Joker *joker;
    Joker *emeny;
    GameObject *fly;
    ContactListener *contactListener;
    CCLabelBMFont *statusLabel;
    int flyPos;
    BOOL jokerStartCharge;
    float jokerCharge;
    CCSpriteBatchNode* brick1BatchNode;
    CCSpriteBatchNode* brick2BatchNode;
    CCSpriteBatchNode* brick3BatchNode;
    CCSpriteBatchNode* flyBatchNode;
    std::deque <State> stateVec;
}
+(GameLayer*) getGameLayer;
@property (retain, nonatomic) CCTMXTiledMap *tileMapNode;
@property (retain, nonatomic) CCLabelBMFont *statusLabel;
@property (retain, nonatomic) CCLabelBMFont *distanceLabel;
@property (nonatomic, readwrite) int coinCount;
@property  (nonatomic, readwrite) float distance;
@property (nonatomic, readwrite) b2World* world;
@property (nonatomic, readwrite) Joker* joker;
@property (nonatomic, readwrite) Joker* emeny;
@property (nonatomic, readwrite) CCSprite *coinBar;
@property (nonatomic, readwrite) CCSprite *disBar;
@property (nonatomic, readwrite) int flyPos;
@property (nonatomic, readwrite) CCSpriteBatchNode* brick1BatchNode;
@property (nonatomic, readwrite) CCSpriteBatchNode* brick2BatchNode;
@property (nonatomic, readwrite) CCSpriteBatchNode* brick3BatchNode;
@property (nonatomic, readwrite) GameObject *fly;
@property (nonatomic, readwrite) CCSpriteBatchNode *emenyBatchNode;
@property (nonatomic, readwrite) CCSpriteBatchNode *flyBatchNode;
@property (nonatomic, readwrite) std::deque<State> stateVec;
@end
