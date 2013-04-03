//
//  Constants.h
//  JokerJumper
//
//  Created by Sun on 3/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.

#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"


#define GAME_STATE_ONE 1
#define GAME_STATE_TWO 2
#define GAME_STATE_THREE 3


#define HUD_LAYER_TAG 1
#define BG_LAYER_TAG 2
#define PAUSE_LAYER_TAG 3
#define GAME_LAYER_TAG 4

#define PTM_RATIO 32
#define COIN_LABEL_X 950
#define STATUS_LABEL_X 830
#define LIFE_LABEL_X 710
#define OFFSET_X 40

#define MAP_LENGTH 400
#define MAP_LEVEL1_NUMS 2


struct State {
    CGPoint position;
    b2Vec2 velocity;
    float gravityScale;
};

typedef enum {
    kGameObjectNone,
    kGameObjectCoin,
    kGameObjectJoker,
    kGameObjectPlatform1,
    kGameObjectPlatform2,
    kGameObjectPlatform3,
    kGameObjectPlatform4,
    kGameObjectCoin1,
    kGameObjectCoin2,
    kGameObjectCoin3,
    kGameObjectFly,
    kGameObjectEmeny,
    kGameObjectFalling,
    kGameObjectDisable,
    kGameObjectFlower
} GameObjectType;


//BOOL jokerJumping;