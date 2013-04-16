//
//  ContactListener2.mm
//  JokerJumper
//
//  Created by Heguang Liu on 13-4-2.
//
//

#import "ContactListener2.h"
#import "Constants.h"
#import "Joker.h"
#import "GameObject.h"
#import "GameLayer2.h"
#import "SimpleAudioEngine.h"
@class GameLayer2;
@class Joker;


ContactListener2::ContactListener2() {
}

ContactListener2::~ContactListener2() {
}

void ContactListener2::BeginContact(b2Contact *contact) {
    
	//GameObject *spriteA = (__bridge GameObject*)(contact->GetFixtureA()->GetBody()->GetUserData());
	//GameObject *spriteB = (__bridge GameObject*)(contact->GetFixtureB()->GetBody()->GetUserData());
    
    b2Body *bodyA = contact->GetFixtureA()->GetBody();
    b2Body *bodyB = contact->GetFixtureB()->GetBody();
    if (bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL)
    {
        GameObject *spriteA = (__bridge GameObject *) bodyA->GetUserData();
        GameObject *spriteB = (__bridge GameObject *) bodyB->GetUserData();
        if(IS_COINTYPE(spriteA, spriteB))
        {
            GameObject *coinSprite=(spriteA.type==kGameObjectJoker)?spriteB:spriteA;
            CCScene* scene = [[CCDirector sharedDirector] runningScene];
            GameLayer2 * layer = (GameLayer2*)[scene getChildByTag:GAME_LAYER_TAG];
            
            CCParticleSystem *ps = [CCParticleExplosion node];
            [layer addChild:ps z:12];
            ps.texture = [[CCTextureCache sharedTextureCache] addImage:@"stars.png"];
            ps.position = coinSprite.position;
            ps.blendAdditive = YES;
            ps.life = 0.2f;
            ps.lifeVar = 0.2f;
            ps.totalParticles = 30.0f;
            ps.autoRemoveOnFinish = YES;
            
        }

        if(IS_COINTYPE(spriteA, spriteB))
        {
            GameObject *coinSprite=(spriteA.type==kGameObjectJoker)?spriteB:spriteA;
            CCScene* scene = [[CCDirector sharedDirector] runningScene];
            GameLayer2 * layer = (GameLayer2*)[scene getChildByTag:GAME_LAYER_TAG];
            
            CCParticleSystem *ps = [CCParticleExplosion node];
            [layer addChild:ps z:12];
            ps.texture = [[CCTextureCache sharedTextureCache] addImage:@"stars.png"];
            ps.position = coinSprite.position;
            ps.blendAdditive = YES;
            ps.life = 0.2f;
            ps.lifeVar = 0.2f;
            ps.totalParticles = 30.0f;
            ps.autoRemoveOnFinish = YES;
            
        }
        if (IS_COIN0TYPE(spriteA, spriteB))
        {
            GameObject *coinSprite=(spriteA.type==kGameObjectJoker)?spriteB:spriteA;
            CCScene* scene = [[CCDirector sharedDirector] runningScene];
            GameLayer2 * layer = (GameLayer2*)[scene getChildByTag:GAME_LAYER_TAG];
            layer.coinCount++;
            [layer removeChild:coinSprite cleanup:YES];
            coinSprite.visible = false;
            [[SimpleAudioEngine sharedEngine] playEffect:@"Collect_Coin.wav"];
            
        }
        else if(IS_COIN1TYPE(spriteA, spriteB))
        {
            GameObject *coinSprite=(spriteA.type==kGameObjectJoker)?spriteB:spriteA;
            CCScene* scene = [[CCDirector sharedDirector] runningScene];
            GameLayer2 * layer = (GameLayer2*)[scene getChildByTag:GAME_LAYER_TAG];
            layer.lifeCount++;
            [layer removeChild:coinSprite cleanup:YES];
            coinSprite.visible = false;
            [[SimpleAudioEngine sharedEngine] playEffect:@"Collect_Coin.wav"];
        }
        else if(IS_PLATTYPE(spriteA, spriteB))
        {
            CCScene* scene = [[CCDirector sharedDirector] runningScene];
            GameLayer2 * layer = (GameLayer2*)[scene getChildByTag:GAME_LAYER_TAG];
            //b2Body *jokerBody=(spriteA.type==kGameObjectJoker)?bodyA:bodyB;
            if(layer.joker.jokerJumping == true)
            {
                //NSLog(@"2222222222 Joker speed before %f", jokerBody->GetLinearVelocity().x);
                //CCLOG(@"Set jump false");
                //jokerBody->SetLinearVelocity(b2Vec2(layer.jumpVec.x,jokerBody->GetLinearVelocity().y));
                [layer.joker setJokerJumping:false];
                //NSLog(@"2222222222 Joker speed after %f", jokerBody->GetLinearVelocity().x);
                //jokerBody->SetLinearVelocity(b2Vec2(jokerBody->GetLinearVelocity().x,jokerBody->GetLinearVelocity().y));
            }
        }
        if(IS_PLAT1TYPE(spriteA, spriteB))
        {
            b2Body *jokerBody=(spriteA.type==kGameObjectJoker)?bodyA:bodyB;
            b2Vec2 impulse = b2Vec2(jokerBody->GetLinearVelocity().x+0.5f, jokerBody->GetLinearVelocity().y);
            jokerBody->SetLinearVelocity(impulse);
        }
        else if(IS_PLAT2TYPE(spriteA, spriteB))
        {
            GameObject *grass=(spriteA.type==kGameObjectJoker)?spriteB:spriteA;
            [grass setVisible:true];
            
        }
        else if(IS_PLAT3TYPE(spriteA,spriteB))
        {
            b2Body *diceBody=(spriteA.type==kGameObjectJoker)?bodyB:bodyA;
            b2Body *jokerBody=(spriteA.type==kGameObjectJoker)?bodyA:bodyB;
            diceBody->SetGravityScale(jokerBody->GetGravityScale()*0.2);
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


void ContactListener2::EndContact(b2Contact *contact)
{
    
    b2Body *bodyA = contact->GetFixtureA()->GetBody();
    b2Body *bodyB = contact->GetFixtureB()->GetBody();
    if (bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL)
    {
        GameObject *spriteA = (__bridge GameObject *) bodyA->GetUserData();
        GameObject *spriteB = (__bridge GameObject *) bodyB->GetUserData();
        if(IS_PLAT5TYPE(spriteA, spriteB)||IS_PLAT6TYPE(spriteA, spriteB))
        {
            CCScene* scene = [[CCDirector sharedDirector] runningScene];
            GameLayer2 * layer = (GameLayer2*)[scene getChildByTag:GAME_LAYER_TAG];
            b2Body *jokerBody=(spriteA.type==kGameObjectJoker)?bodyA:bodyB;
            if(layer.joker.jokerJumping == false)
            {
                [layer.joker setJokerJumping:true];
            }
        }
        //        else if(IS_PLAT2TYPE(spriteA, spriteB))
        //        {
        //            CCScene* scene = [[CCDirector sharedDirector] runningScene];
        //            GameLayer * layer = (GameLayer*)[scene getChildByTag:GAME_LAYER_TAG];
        //
        //            GameObject *grass=(spriteA.type==kGameObjectJoker)?spriteB:spriteA;
        //            GameObject *wood=[GameObject spriteWithFile:@"brick_wood_hd.png"];
        //            wood.position=ccp(grass.position.x,grass.position.y+grass.contentSize.height);
        //            [layer addChild:wood];
        //        }
    }
    //	GameObject *o1 = (__bridge GameObject*)contact->GetFixtureA()->GetBody()->GetUserData();
    //	GameObject *o2 = (__bridge GameObject*)contact->GetFixtureB()->GetBody()->GetUserData();
}
void ContactListener2::PreSolve(b2Contact *contact, const b2Manifold *oldManifold) {
}

void ContactListener2::PostSolve(b2Contact *contact, const b2ContactImpulse *impulse) {
}