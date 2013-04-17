//
//  ContactListener2.h
//  JokerJumper
//
//  Created by Heguang Liu on 13-4-2.
//
//

#ifndef JokerJumper_ContactListener2_h
#define JokerJumper_ContactListener2_h


#import "Box2D.h"
#import <vector>
#import <algorithm>

#define PTM_RATIO 32//kGameObjectCoin
#define IS_PLAT(x)          ((x==kGameObjectPlatform1)||(x==kGameObjectPlatform2)||(x==kGameObjectPlatform3)||(x==kGameObjectPlatform4)||(x==kGameObjectFalling)||(x==kGameObjectDisable)||(x==kGameObjectStone))
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
#define IS_PLAT4TYPE(x, y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectPlatform4))||((x.type == kGameObjectPlatform4)&&(y.type == kGameObjectJoker)))
#define IS_PLAT5TYPE(x, y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectDisable))||((x.type == kGameObjectDisable)&&(y.type == kGameObjectJoker)))
#define IS_PLAT6TYPE(x, y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectFalling))||((x.type == kGameObjectFalling)&&(y.type == kGameObjectJoker)))


struct MyContact2 {
    b2Fixture *fixtureA;
    b2Fixture *fixtureB;
    bool operator==(const MyContact2& other) const
    {
        return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
    }
    };
    
    class ContactListener2 : public b2ContactListener {
    public:
        std::vector<MyContact2>_contacts;
        ContactListener2();
        ~ContactListener2();
        
        virtual void BeginContact(b2Contact *contact);
        virtual void EndContact(b2Contact *contact);
        virtual void PreSolve(b2Contact *contact, const b2Manifold *oldManifold);
        virtual void PostSolve(b2Contact *contact, const b2ContactImpulse *impulse);
    };
    

#endif
