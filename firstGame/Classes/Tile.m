//
//  Tile.m
//  firstGame
//
//  Created by Carl Kruk on 1/23/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "Tile.h"
#import <Foundation/Foundation.h>

@implementation Tile
@synthesize layer, tile, number;

-(id) initTile:(CCSprite *)s tile:(int)n number:(CCNode *)l
{
    self.layer = l;
    self.tile = s;
    self.number = n;
    
    return self;
}

-(void) visualizeTile:(CGPoint) p
{
    self.tile.position = p;
    [self.layer addChild:self.tile];
}

-(void) unvisualizeTile
{
    [self.layer removeChild:self.tile];
}

-(CGSize) getSpriteSize
{
    return self.tile.textureRect.size;
}

-(CGPoint) getTileLocation
{
    return self.tile.position;
}

-(int) getNumber
{
    return self.number;
}

-(CCSprite *) getSprite
{
    return self.tile;
}

@end