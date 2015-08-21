//
//  tileButton.m
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "tilebutton.h"

@implementation tilebutton
@synthesize layer, button, number;

-(id) initTileButton:(int) n num: (CCNode *)l
{
    self.layer = l;
    self.button = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%d.png", n]]];
    self.number = n;
    
    return self;
}

-(int) getNumber
{
    return self.number;
}

-(CCButton *) getButton
{
    return self.button;
}

@end
