//
//  LevelScrollScene.m
//  JokerJumper
//
//  Created by Sun on 4/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelScrollLayer.h"
#import "LevelScrollScene.h"


@implementation LevelScrollScene

-(id) init
{
	if( (self=[super init])) {
        // get screen size
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        /////////////////////////////////////////////////
        // PAGE 1
        ////////////////////////////////////////////////
        // create a blank layer for page 1
        CCLayer *pageOne = [[CCLayer alloc] init];
        
        // create a label for page 1
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Page 1" fontName:@"Arial Rounded MT Bold" fontSize:44];
        label.position =  ccp( screenSize.width /2 , screenSize.height/2 );
        
        // add label to page 1 layer
        [pageOne addChild:label];
        
        /////////////////////////////////////////////////
        // PAGE 2
        ////////////////////////////////////////////////
        // create a blank layer for page 2
        CCLayer *pageTwo = [[CCLayer alloc] init];
        
        // create a custom font menu for page 2
        CCLabelBMFont *tlabel = [CCLabelBMFont labelWithString:@"Page 2" fntFile:@"customfont.fnt"];
        CCMenuItemLabel *titem = [CCMenuItemLabel itemWithLabel:tlabel target:self selector:@selector(testCallback:)];
        CCMenu *menu = [CCMenu menuWithItems: titem, nil];
        menu.position = ccp(screenSize.width/2, screenSize.height/2);
        
        // add menu to page 2
        [pageTwo addChild:menu];
        ////////////////////////////////////////////////
        
        // now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
        LevelScrollLayer *scroller = [[LevelScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: pageOne,pageTwo,nil] widthOffset: 230];
        
        // finally add the scroller to your scene
        [self addChild:scroller];
    }
    return self;
}

@end
