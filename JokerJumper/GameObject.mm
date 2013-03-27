//
//  GameObject.m
//  JokerJumper
//
//  Created by Sun on 3/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject
@synthesize type;
//@synthesize posRect;

- (id)init
{
    self = [super init];
    if (self) {
        type = kGameObjectNone;
    }
    
    return self;
}
/*
-(CGRect) positionRect: (CCSprite*) Sprite
{
	CGSize contentSize = [Sprite contentSize];
	CGPoint contentPosition = [Sprite position];
	CGRect result = CGRectOffset(CGRectMake(0, 0, contentSize.width, contentSize.height), contentPosition.x-contentSize.width/2, contentPosition.y-contentSize.height/2);
	return result;
}
 */
@end
