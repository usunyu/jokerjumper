//
//  GameObject.h
//  JokerJumper
//
//  Created by Sun on 3/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"

@interface GameObject : CCSprite {
    GameObjectType  type;
}

@property (nonatomic, readwrite) GameObjectType type;
@end
