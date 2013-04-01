//
//  HUDLayer.m
//  JokerJumper
//
//  Created by Sun on 3/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "GameScene.h"

@implementation HUDLayer
@synthesize    lifeLabel;
@synthesize    statusLabel;
@synthesize    coinLabel;

+(HUDLayer*) getHUDLayer {
    return self;
}


-(id) init
{
	if ((self = [super init]))
	{
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.tag=HUD_LAYER_TAG;
        coinBar= [CCSprite spriteWithFile:@"diamond.png"];
        disBar=[CCSprite spriteWithFile:@"spade.png"];
        lifeBar=[CCSprite spriteWithFile:@"heart.png"];
        
        coinBar.position = ccp(COIN_LABEL_X,screenSize.height-30);
        disBar.position = ccp(STATUS_LABEL_X, screenSize.height-30);
        lifeBar.position=ccp(LIFE_LABEL_X, screenSize.height-30);
                
        // These values are hard coded for Drivers Ed, should be refacotred for more flexability
        statusLabel = [CCLabelBMFont labelWithString:@"0.0" fntFile:@"Arial.fnt"];
        lifeLabel=[CCLabelBMFont labelWithString:@"0" fntFile:@"Arial.fnt"];
        coinLabel=[CCLabelBMFont labelWithString:@"0" fntFile:@"Arial.fnt"];
        [statusLabel setColor:ccYELLOW];
        [lifeLabel setColor:ccYELLOW];
        [coinLabel setColor:ccYELLOW];
        [statusLabel setAnchorPoint:ccp(0.5f,1)];
        [coinLabel setAnchorPoint:ccp(0.5f,1)];
        [lifeLabel setAnchorPoint:ccp(0.5f,1)];
        [statusLabel setPosition:ccp(STATUS_LABEL_X+OFFSET_X,screenSize.height-30)];
        [coinLabel setPosition:ccp(COIN_LABEL_X+OFFSET_X,screenSize.height-30)];
        [lifeLabel setPosition:ccp(LIFE_LABEL_X+OFFSET_X,screenSize.height-30)];
		        
        pause = [CCMenuItemImage itemFromNormalImage:@"pauseButton.png" selectedImage:@"pauseButtonPressed.png" target:self selector:@selector(pauseButtonSelected)];
        CCMenu *menu = [CCMenu menuWithItems:pause, nil];
        menu.position = CGPointMake(35, screenSize.height - 30);
        
        [self addChild:menu z:100];
        [self addChild:coinBar z:100];
        [self addChild:disBar z:100];
        [self addChild:lifeBar z:100];
        [self addChild:statusLabel z:100];
        [self addChild:coinLabel z:100];
        [self addChild:lifeLabel z:100];
    }
	
	return self;
}
/*
- (void)pauseButtonSelected {
    
    if (![[GameScene sharedGameScene] isShowingPausedMenu]) {
        [[GameScene sharedGameScene] setShowingPausedMenu:YES];
        [[GameScene getGameScene showPausedMenu];
        [[CCDirector sharedDirector] pause];
    }
    
}
*/

-(void) updateLifeCounter:(int)amount
{
    if(amount<2)
    {
        [lifeLabel setColor:ccRED];
    }
    else
    {
        [lifeLabel setColor:ccORANGE];
    }
        NSString *amounts = [NSString stringWithFormat:@"%2d", amount];
        [lifeLabel setString:amounts];
}
-(void) updateCoinCounter:(int)amount
{
        NSString *amounts = [NSString stringWithFormat:@"%2d", amount];
        [coinLabel setString:amounts];
}
-(void) updateStatusCounter:(float)amount
{
        NSString *amounts = [NSString stringWithFormat:@"%.2f", amount];
        [statusLabel setString:amounts];
}


@end
