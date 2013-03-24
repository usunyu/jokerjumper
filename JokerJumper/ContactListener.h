//
//  ContactListener.h
//  JokerJumper
//
//  Created by Sun on 3/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Box2D.h"
#import <vector>
#import <algorithm>


struct MyContact {
    b2Fixture *fixtureA;
    b2Fixture *fixtureB;
    bool operator==(const MyContact& other) const
    {
        return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
    }
    };
    
class ContactListener : public b2ContactListener {
public:
    std::vector<MyContact>_contacts;
	ContactListener();
	~ContactListener();
	
	virtual void BeginContact(b2Contact *contact);
	virtual void EndContact(b2Contact *contact);
	virtual void PreSolve(b2Contact *contact, const b2Manifold *oldManifold);
	virtual void PostSolve(b2Contact *contact, const b2ContactImpulse *impulse);
};

/*
#import "Box2D.h"
#import <vector>
#import <algorithm>

struct MyContact {
    b2Fixture *fixtureA;
    b2Fixture *fixtureB;
    bool operator==(const MyContact& other) const
    {
        return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
    }
    };
    
    class ContactListener : public b2ContactListener {
        
    public:
        std::vector<MyContact>_contacts;
        
        ContactListener();
        ~ContactListener();
        
        virtual void BeginContact(b2Contact* contact);
        virtual void EndContact(b2Contact* contact);
        virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
        virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
        
    };
*/