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

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    // get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    /////////////////////////////////////////////////
    // PAGE 1
    ////////////////////////////////////////////////
    // create a blank layer for page 1
    CCLayer *pageOne = [[CCLayer alloc] init];
    
    // create a label for page 1
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Stage 1" fontName:@"Arial Rounded MT Bold" fontSize:44];
    label1.position =  ccp( screenSize.width /2 , 50 );
    
    // add label to page 1 layer
    [pageOne addChild:label1];
    
    /////////////////////////////////////////////////
    // PAGE 2
    ////////////////////////////////////////////////
    // create a blank layer for page 2
    CCLayer *pageTwo = [[CCLayer alloc] init];
    

    
    CCMenuItem *button = [CCMenuItemImage itemFromNormalImage:@"menu.png" selectedImage:@"menu.png" target:scene selector:@selector(buttonAction:)];
    // create a custom font menu for page 2
    CCMenu *Menu = [CCMenu menuWithItems:button, nil];
    Menu.position=ccp(screenSize.width/2, screenSize.height/2);
    
    [Menu alignItemsHorizontally];
    
    [pageTwo addChild:Menu];
    
//    CCLabelBMFont *tlabel = [CCLabelBMFont labelWithString:@"Page 2" fntFile:@"Arial.fnt"];
//    CCMenuItemLabel *titem = [CCMenuItemLabel itemWithLabel:tlabel target:self selector:@selector(testCallback:)];
//    CCMenu *menu = [CCMenu menuWithItems: titem, nil];
//    menu.position = ccp(screenSize.width/2, screenSize.height/2);
    
    // add menu to page 2
//    [pageTwo addChild:menu];
    
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Stage 2" fontName:@"Arial Rounded MT Bold" fontSize:44];
    label2.position =  ccp( screenSize.width /2 , 50 );
    
    // add label to page 2 layer
    [pageTwo addChild:label2];
    ////////////////////////////////////////////////
    
    /////////////////////////////////////////////////
    // PAGE 3
    ////////////////////////////////////////////////
    CCLayer *pageThree = [[CCLayer alloc] init];
    CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"Stage 3" fontName:@"Arial Rounded MT Bold" fontSize:44];
    label3.position =  ccp( screenSize.width /2 , 50 );
    
    [pageThree addChild:label3];
    
    // now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
    LevelScrollLayer *scroller = [[LevelScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: pageOne,pageTwo,pageThree,nil] widthOffset: 230];
    
    // finally add the scroller to your scene
    [scene addChild:scroller];
    
	// return the scene
	return scene;
}

- (void)buttonAction:(id)sender {
    int i = 0;
}

-(id) init
{
	if( (self=[super init])) {
        
    }
    return self;
}

@end
