//
//  textInput.m
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//
/*
#import <Foundation/Foundation.h>
#import "textInput.h"

@implementation textInput
@synthesize layer, zeroButton, oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton, tilesClicked, inputString;

-(id) initTextInput:(Program *) p program: (CCNode *)l
{
    self.layer = l;
    
    self.zeroButton = [[tilebutton alloc] initTileButton:0 num:self.layer];
    self.oneButton = [[tilebutton alloc] initTileButton:1 num:self.layer];
    self.twoButton = [[tilebutton alloc] initTileButton:2 num:self.layer];
    self.threeButton = [[tilebutton alloc] initTileButton:3 num:self.layer];
    self.fourButton = [[tilebutton alloc] initTileButton:4 num:self.layer];
    self.fiveButton = [[tilebutton alloc] initTileButton:5 num:self.layer];
    self.sixButton = [[tilebutton alloc] initTileButton:6 num:self.layer];
    self.sevenButton = [[tilebutton alloc] initTileButton:7 num:self.layer];
    self.eightButton = [[tilebutton alloc] initTileButton:8 num:self.layer];
    self.nineButton = [[tilebutton alloc] initTileButton:9 num:self.layer];
    
    //[self spawnTiles:ccp(self.layer.contentSize.width / 2, self.layer.contentSize.height / 2)];
    
    self.tilesClicked = 0;
    self.inputString = @"";
    
    [self spawnTiles:ccp(self.layer.contentSize.width / 2, self.layer.contentSize.height / 2)];

    return self;
}

-(void) spawnTiles:(CGPoint)center
{
    [self.oneButton getButton].position = ccp(center.x - [self.oneButton getButton].boundingBox.size.width, center.y + [self.oneButton getButton].boundingBox.size.height);
    [self.layer addChild:[self.oneButton getButton]];
    [[self.oneButton getButton] setTarget:self selector:@selector(oneClicked)];
    
    [self.twoButton getButton].position = ccp(center.x, center.y + [self.oneButton getButton].boundingBox.size.height);
    [self.layer addChild:[self.twoButton getButton]];
    [[self.twoButton getButton] setTarget:self selector:@selector(twoClicked)];
    
    [self.threeButton getButton].position = ccp(center.x + [self.oneButton getButton].boundingBox.size.width, center.y + [self.oneButton getButton].boundingBox.size.height);
    [self.layer addChild:[self.threeButton getButton]];
    [[self.threeButton getButton] setTarget:self selector:@selector(threeClicked)];
    
    [self.eightButton getButton].position = ccp(center.x - [self.oneButton getButton].boundingBox.size.width, center.y);
    [self.layer addChild:[self.eightButton getButton]];
    [[self.eightButton getButton] setTarget:self selector:@selector(eightClicked)];
    
    [self.zeroButton getButton].position = ccp(center.x, center.y);
    [self.layer addChild:[self.zeroButton getButton]];
    [[self.zeroButton getButton] setTarget:self selector:@selector(zeroClicked)];
    
    [self.fourButton getButton].position = ccp(center.x + [self.oneButton getButton].boundingBox.size.width, center.y);
    [self.layer addChild:[self.fourButton getButton]];
    [[self.fourButton getButton] setTarget:self selector:@selector(fourClicked)];
    
    [self.sevenButton getButton].position = ccp(center.x - [self.oneButton getButton].boundingBox.size.width, center.y - [self.oneButton getButton].boundingBox.size.height);
    [self.layer addChild:[self.sevenButton getButton]];
    [[self.sevenButton getButton] setTarget:self selector:@selector(sevenClicked)];
    
    [self.sixButton getButton].position = ccp(center.x, center.y - [self.oneButton getButton].boundingBox.size.height);
    [self.layer addChild:[self.sixButton getButton]];
    [[self.sixButton getButton] setTarget:self selector:@selector(sixClicked)];
    
    [self.fiveButton getButton].position = ccp(center.x + [self.oneButton getButton].boundingBox.size.width, center.y - [self.oneButton getButton].boundingBox.size.height);
    [self.layer addChild:[self.fiveButton getButton]];
    [[self.fiveButton getButton] setTarget:self selector:@selector(fiveClicked)];
}

-(void) oneClicked:(id)sender
{
    self.inputString = [NSString stringWithFormat:@"%@%d", self.inputString, [self.oneButton getNumber]];
    [self.layer removeChild:[self.oneButton getButton]];
}

-(void) twoClicked:(id)sender
{
    self.inputString = [NSString stringWithFormat:@"%@%d", self.inputString, [self.twoButton getNumber]];
    [self.layer removeChild:[self.twoButton getButton]];
}

-(void) threeClicked:(id)sender
{
    self.inputString = [NSString stringWithFormat:@"%@%d", self.inputString, [self.threeButton getNumber]];
    [self.layer removeChild:[self.threeButton getButton]];
}

-(void) fourClicked:(id)sender
{
    self.inputString = [NSString stringWithFormat:@"%@%d", self.inputString, [self.fourButton getNumber]];
    [self.layer removeChild:[self.fourButton getButton]];
}

-(void) fiveClicked:(id)sender
{
    self.inputString = [NSString stringWithFormat:@"%@%d", self.inputString, [self.fiveButton getNumber]];
    [self.layer removeChild:[self.fiveButton getButton]];
}

-(void) sixClicked:(id)sender
{
    self.inputString = [NSString stringWithFormat:@"%@%d", self.inputString, [self.sixButton getNumber]];
    [self.layer removeChild:[self.sixButton getButton]];
}

-(void) sevenClicked:(id)sender
{
    self.inputString = [NSString stringWithFormat:@"%@%d", self.inputString, [self.sevenButton getNumber]];
    [self.layer removeChild:[self.sevenButton getButton]];
}

-(void) eightClicked:(id)sender
{
    self.inputString = [NSString stringWithFormat:@"%@%d", self.inputString, [self.eightButton getNumber]];
    [self.layer removeChild:[self.eightButton getButton]];
}

-(void) nineClicked:(id)sender
{
    self.inputString = [NSString stringWithFormat:@"%@%d", self.inputString, [self.nineButton getNumber]];
    [self.layer removeChild:[self.nineButton getButton]];
}

-(void) zeroClicked:(id)sender
{
    self.inputString = [NSString stringWithFormat:@"%@%d", self.inputString, [self.zeroButton getNumber]];
    [self.layer removeChild:[self.zeroButton getButton]];
}

-(int) getTilesClicked
{
    return self.tilesClicked;
}

-(BOOL) areAllTilesClicked
{
    return ([self getTilesClicked] == 9);
}

@end
 */
