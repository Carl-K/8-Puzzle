//
//  Tile.h
//  firstGame
//
//  Created by Carl Kruk on 1/23/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "CCSprite.h"

@interface Tile : CCSprite

//-----CREATES AND HANDLES TILES USED BY BOARD VISUALIZER, NOTHING TO SEE HERE

-(id) initTile:(CCSprite *) s tile:(int) n number:(CCNode *) l;
-(void) visualizeTile:(CGPoint) p;
-(void) unvisualizeTile;
-(CGSize) getSpriteSize;
-(CGPoint) getTileLocation;
-(int) getNumber;
-(CCSprite *) getSprite;

@property CCNode *layer;
@property CCSprite *tile;
@property int number;

@end
