#import "cocos2d.h"
#import "Box2D.h"
#import "ContactListener.h"
#import "GameObject.h"
#include <deque>




//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.



@class Joker;
@class Platform;
@class MapLayer;
@class HUDLayer;
@interface GameLayer3 : CCLayer {
    CCLabelTTF *_label;
    CCSpriteBatchNode *jokerBatchNode;
    CCSpriteBatchNode *emenyBatchNode;
    b2World* world;
    //	CCTMXTiledMap *tileMapNode;
	b2Body *playerBody;
    
    //    CCSprite *coinBar;
    //    CCSprite *disBar;
    //    CCSprite *lifeBar;
    int coinCount;
    int lifeCount;
    float distance;
    //    CCLabelBMFont *statusLabel;
    //    CCLabelBMFont *lifeLabel;
    HUDLayer *hudLayer;
    Joker *joker;
    Joker *emeny;
    GameObject *fly;
    ContactListener *contactListener;
    float fallPos;
    int flyPos;
    BOOL jokerStartCharge;
    BOOL fall1;
    BOOL fall2;
    float jokerCharge;
    CCSpriteBatchNode* allBatchNode;
    CCSpriteBatchNode* brick1BatchNode;
    CCSpriteBatchNode* brick2BatchNode;
    CCSpriteBatchNode* brick3BatchNode;
    CCSpriteBatchNode* flyBatchNode;
    CCSpriteBatchNode* leafBatchNode;
    CCSpriteBatchNode* diamondBatchNode;
    CCSpriteBatchNode* flowerBatchNode;
    CCSpriteBatchNode* heartBatchNode;
    b2Vec2 jumpVec;
    std::deque <State> stateVec;
    
    int accelerationY;
    int lastAccelerationY;
    int lastLastAccelerationY;

    int delayReplaceTime;
    
    CGPoint startLocation;
    CGPoint endLocation;
}
+(GameLayer3*) getGameLayer3;
- (void) makeBox2dObjAt:(CGPoint)p
               withSize:(CGPoint)size
                dynamic:(BOOL)d
               rotation:(long)r
               friction:(long)f
                density:(long)dens
            restitution:(long)rest
                  boxId:(int)boxId
               bodyType:(GameObjectType)type;
//@property (retain, nonatomic) CCLabelBMFont *statusLabel;
//@property (retain, nonatomic) CCLabelBMFont *distanceLabel;
//@property (retain, nonatomic) CCLabelBMFont *lifeLabel;
@property (nonatomic, readwrite) int coinCount;
@property (nonatomic, readwrite) int lifeCount;
@property (nonatomic, readwrite) BOOL fall1;
@property (nonatomic, readwrite) BOOL fall2;
@property  (nonatomic, readwrite) float distance;
@property (nonatomic, readwrite) b2World* world;
@property (nonatomic, readwrite) Joker* joker;
@property (nonatomic, readwrite) Joker* emeny;
@property (nonatomic, readwrite) CCSprite *coinBar;
@property (nonatomic, readwrite) CCSprite *disBar;
@property (nonatomic, readwrite) CCSprite *lifeBar;
@property (nonatomic, readwrite) int flyPos;
@property (nonatomic, readwrite) CCSpriteBatchNode* brick1BatchNode;
@property (nonatomic, readwrite) CCSpriteBatchNode* brick2BatchNode;
@property (nonatomic, readwrite) CCSpriteBatchNode* brick3BatchNode;
@property (nonatomic, readwrite) CCSpriteBatchNode* allBatchNode;
@property (nonatomic, readwrite) GameObject *fly;
@property (nonatomic, readwrite) CCSpriteBatchNode *emenyBatchNode;
@property (nonatomic, readwrite) CCSpriteBatchNode *flyBatchNode;
@property (nonatomic, readwrite) b2Vec2 jumpVec;
@property (nonatomic, readwrite) CCSpriteBatchNode *diamondBatchNode;
@property (nonatomic, readwrite) HUDLayer *hudLayer;
@property (nonatomic, readwrite) std::deque<State> stateVec;
@property (nonatomic, readwrite) float fallPos;
@property (nonatomic, readwrite) CCSpriteBatchNode* leafBatchNode;
@property (nonatomic, readwrite) CCSpriteBatchNode* heartBatchNode;
@property (nonatomic, readwrite) CCSpriteBatchNode* flowerBatchNode;
@end