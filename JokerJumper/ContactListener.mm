//
//  ContactListener.m
//  JokerJumper
//
//  Created by Sun on 3/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

/*
 #import "ContactListener.h"
 #import "Constants.h"
 #import "Joker.h"
 #import "GameObject.h"
 
 #define IS_COIN1(x, y)       ((x.type == kGameObjectJoker)&&(y.type == kGameObjectCoin))
 #define IS_COIN2(x, y)       ((x.type == kGameObjectCoin)&&(y.type == kGameObjectJoker))
 #define IS_PLAT1(x, y)      ((x.type == kGameObjectJoker)&&(y.type == kGameObjectPlatform))
 #define IS_PLAT2(x, y)      ((x.type == kGameObjectPlatform)&&(y.type == kGameObjectJoker))
 
 ContactListener::ContactListener() : _contacts() {
 }
 
 ContactListener::~ContactListener() {
 }
 
 void ContactListener::BeginContact(b2Contact* contact) {
 // We need to copy out the data because the b2Contact passed in
 // is reused.
 MyContact myContact = { contact->GetFixtureA(), contact->GetFixtureB() };
 _contacts.push_back(myContact);
 
 
 
 
 
 }
 
 void ContactListener::EndContact(b2Contact* contact) {
 MyContact myContact = { contact->GetFixtureA(), contact->GetFixtureB() };
 std::vector<MyContact>::iterator pos;
 pos = std::find(_contacts.begin(), _contacts.end(), myContact);
 if (pos != _contacts.end()) {
 _contacts.erase(pos);
 }
 }
 
 void ContactListener::PreSolve(b2Contact* contact,
 const b2Manifold* oldManifold) {
 }
 
 void ContactListener::PostSolve(b2Contact* contact,
 const b2ContactImpulse* impulse) {
 }
 #define IS_PLAT(x)          ((x==kGameObjectPlatform1)||(x==kGameObjectPlatform2)||(x==kGameObjectPlatform3))
 #define IS_COIN(x)          ((x==kGameObjectCoin)||(x==kGameObjectCoin1)||(x==kGameObjectCoin2)||(x==kGameObjectCoin3))
 #define IS_COINTYPE(x, y)      (((x.type == kGameObjectJoker)&&(IS_COIN(y.type)))||((IS_COIN(x.type))&&(y.type == kGameObjectJoker)))
 #define IS_PLATTYPE(x, y)      (((x.type == kGameObjectJoker)&&(IS_PLAT(y.type)))||((IS_PLAT(x))&&(y.type == kGameObjectJoker)))
 #define IS_COIN0TYPE(x,y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectCoin))||((x.type == kGameObjectCoin)&&(y.type == kGameObjectJoker)))
 #define IS_COIN1TYPE(x,y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectCoin1))||((x.type == kGameObjectCoin1)&&(y.type == kGameObjectJoker)))
 #define IS_COIN2TYPE(x,y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectCoin2))||((x.type == kGameObjectCoin2)&&(y.type == kGameObjectJoker)))
 #define IS_COIN3TYPE(x,y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectCoin3))||((x.type == kGameObjectCoin3)&&(y.type == kGameObjectJoker)))
 #define IS_PLAT1TYPE(x, y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectPlatform1))||((x.type == kGameObjectPlatform1)&&(y.type == kGameObjectJoker)))
 #define IS_PLAT2TYPE(x, y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectPlatform2))||((x.type == kGameObjectPlatform2)&&(y.type == kGameObjectJoker)))
 #define IS_PLAT3TYPE(x, y)      (((x.type == kGameObjectJoker)&&(y.type == kGameObjectPlatform3))||((x.type == kGameObjectPlatform3)&&(y.type == kGameObjectJoker)))
 */

#import "ContactListener.h"
#import "Constants.h"
#import "Joker.h"
#import "GameObject.h"
#import "GameLayer.h"
#import "SimpleAudioEngine.h"
@class GameLayer;
@class Joker;


ContactListener::ContactListener() {
}

ContactListener::~ContactListener() {
}

void ContactListener::BeginContact(b2Contact *contact) {
    
	//GameObject *spriteA = (__bridge GameObject*)(contact->GetFixtureA()->GetBody()->GetUserData());
	//GameObject *spriteB = (__bridge GameObject*)(contact->GetFixtureB()->GetBody()->GetUserData());
	
    b2Body *bodyA = contact->GetFixtureA()->GetBody();
    b2Body *bodyB = contact->GetFixtureB()->GetBody();
    if (bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL)
    {
        GameObject *spriteA = (__bridge GameObject *) bodyA->GetUserData();
        GameObject *spriteB = (__bridge GameObject *) bodyB->GetUserData();
        
        if (IS_COINTYPE(spriteA, spriteB))
        {
            GameObject *coinSprite=(spriteA.type==kGameObjectJoker)?spriteB:spriteA;
            CCScene* scene = [[CCDirector sharedDirector] runningScene];
            GameLayer * layer = (GameLayer*)[scene getChildByTag:GAME_LAYER_TAG];
            layer.coinCount++;
            [layer removeChild:coinSprite cleanup:YES];
            coinSprite.visible = false;
            [[SimpleAudioEngine sharedEngine] playEffect:@"Collect_Coin.wav"];
            
        }
        else if(IS_PLATTYPE(spriteA, spriteB))
        {
            CCScene* scene = [[CCDirector sharedDirector] runningScene];
            GameLayer * layer = (GameLayer*)[scene getChildByTag:GAME_LAYER_TAG];
            b2Body *jokerBody=(spriteA.type==kGameObjectJoker)?bodyA:bodyB;
            NSLog(@"2222222222 Joker speed before %f", jokerBody->GetLinearVelocity().x);
            if(layer.joker.jokerJumping == true)
            {
                CCLOG(@"Set jump false");
                
                [layer.joker setJokerJumping:false];
                jokerBody->SetLinearVelocity(b2Vec2(jokerBody->GetLinearVelocity().x,jokerBody->GetLinearVelocity().y));
            }
            NSLog(@"2222222222 Joker speed after %f", jokerBody->GetLinearVelocity().x);
        }
        if(IS_PLAT1TYPE(spriteA, spriteB))
        {
            b2Body *jokerBody=(spriteA.type==kGameObjectJoker)?bodyA:bodyB;
            b2Vec2 impulse = b2Vec2(jokerBody->GetLinearVelocity().x+1.0f, jokerBody->GetLinearVelocity().y);
            jokerBody->SetLinearVelocity(impulse);
        }
        /*
         //Sprite A = Coin, Sprite B = Joker
         else if (IS_COIN2(spriteA, spriteB))
         {
         CCScene* scene = [[CCDirector sharedDirector] runningScene];
         GameLayer * layer = (GameLayer*)[scene getChildByTag:100];
         layer.coinCount++;
         [layer removeChild:spriteA cleanup:YES];
         spriteA.visible = false;
         [[SimpleAudioEngine sharedEngine] playEffect:@"Collect_Coin.wav"];
         
         }
         else if(IS_PLAT1(spriteA, spriteB))
         {
         CCScene* scene = [[CCDirector sharedDirector] runningScene];
         GameLayer * layer = (GameLayer*)[scene getChildByTag:100];
         if(layer.joker.jokerJumping == true)
         {
         CCLOG(@"Set jump false");
         [layer.joker setJokerJumping:false];
         }
         }
         else if(IS_PLAT2(spriteA, spriteB))
         {
         CCScene* scene = [[CCDirector sharedDirector] runningScene];
         GameLayer * layer = (GameLayer*)[scene getChildByTag:100];
         if(layer.joker.jokerJumping == true)
         {
         CCLOG(@"Set jump false");
         [layer.joker setJokerJumping:false];
         }
         }
         else if(IS_COIN1_1(spriteA, spriteB))
         {
         CCScene* scene = [[CCDirector sharedDirector] runningScene];
         GameLayer * layer = (GameLayer*)[scene getChildByTag:100];
         [layer removeChild:spriteB cleanup:YES];
         spriteB.visible = false;
         
         b2Vec2 impulse = b2Vec2(200.0f, 0.0f);
         bodyA->ApplyLinearImpulse(impulse, bodyA->GetWorldCenter());
         
         [[SimpleAudioEngine sharedEngine] playEffect:@"Collect_Coin.wav"];
         }
         else if(IS_COIN1_2(spriteA, spriteB))
         {
         CCScene* scene = [[CCDirector sharedDirector] runningScene];
         GameLayer * layer = (GameLayer*)[scene getChildByTag:100];
         [layer removeChild:spriteA cleanup:YES];
         spriteA.visible = false;
         
         //b2Vec2 impulse = b2Vec2(200.0f, 0.0f);
         //bodyB->ApplyLinearImpulse(impulse, bodyB->GetWorldCenter());
         
         [[SimpleAudioEngine sharedEngine] playEffect:@"Collect_Coin.wav"];
         }
         else if(IS_COIN2_1(spriteA, spriteB))
         {
         CCScene* scene = [[CCDirector sharedDirector] runningScene];
         GameLayer * layer = (GameLayer*)[scene getChildByTag:100];
         [layer removeChild:spriteB cleanup:YES];
         spriteB.visible = false;
         [[SimpleAudioEngine sharedEngine] playEffect:@"Collect_Coin.wav"];
         }
         else if(IS_COIN2_2(spriteA, spriteB))
         {
         CCScene* scene = [[CCDirector sharedDirector] runningScene];
         GameLayer * layer = (GameLayer*)[scene getChildByTag:100];
         [layer removeChild:spriteA cleanup:YES];
         spriteA.visible = false;
         [[SimpleAudioEngine sharedEngine] playEffect:@"Collect_Coin.wav"];
         }
         else if(IS_COIN3_1(spriteA, spriteB))
         {
         CCScene* scene = [[CCDirector sharedDirector] runningScene];
         GameLayer * layer = (GameLayer*)[scene getChildByTag:100];
         [layer removeChild:spriteB cleanup:YES];
         spriteB.visible = false;
         [[SimpleAudioEngine sharedEngine] playEffect:@"Collect_Coin.wav"];
         
         }
         else if(IS_COIN3_2(spriteA, spriteB))
         {
         CCScene* scene = [[CCDirector sharedDirector] runningScene];
         GameLayer * layer = (GameLayer*)[scene getChildByTag:100];
         [layer removeChild:spriteA cleanup:YES];
         spriteA.visible = false;
         [[SimpleAudioEngine sharedEngine] playEffect:@"Collect_Coin.wav"];
         
         }
         */
    }
    
}



void ContactListener::EndContact(b2Contact *contact)
{
    //	GameObject *o1 = (__bridge GameObject*)contact->GetFixtureA()->GetBody()->GetUserData();
    //	GameObject *o2 = (__bridge GameObject*)contact->GetFixtureB()->GetBody()->GetUserData();
}
void ContactListener::PreSolve(b2Contact *contact, const b2Manifold *oldManifold) {
}

void ContactListener::PostSolve(b2Contact *contact, const b2ContactImpulse *impulse) {
}
