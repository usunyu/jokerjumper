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

#define MIN_RUN_SPEED 8.0
#define MAX_RUN_SPEED 13.0
#define JUMP_SPEED 20.0

#define DICE_DENSITY 50.0

#define DESTORY_DISTANCE 600.0

#define JOKER_EMENY_DISTANCE 500.0
#define LASTJUMP_EMENY_DISTANCE 335.0

#define FALLING_WOOD1 1632
#define FALLING_WOOD2 2528
#define FALLING_OFFSET 600.0

#define jokerRunActionTag 1
#define mapTag 2

#define jokerLocationX 350
#define jokerLocationY 250
#define emenyLocationX 50
#define emenyLocationY 250
#define moonLocationX 200
#define moonLocationY 200

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
    BOOL flipState;
};

typedef enum {
    kGameObjectNone,
    kGameObjectCoin,
    kGameObjectJoker,
    kGameObjectPlatform1,
    kGameObjectPlatform2,
    kGameObjectPlatform3,
    kGameObjectPlatform4,
    kGameObjectPlatform5,
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