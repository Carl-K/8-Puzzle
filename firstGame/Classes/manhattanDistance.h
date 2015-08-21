//
//  manhattanDistance.h
//  firstGame
//
//  Created by Carl Kruk on 1/25/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

//-----IMPLEMENTS COMPUTATION FOR MANHATTAN VALUES AND MISPLACED TILES

@interface manhattanDistance : NSObject

-(id) initManhattanDistance;
-(int) computeDistance:(CGPoint) p point:(int) n; //COMPUTES MANHATTAN VALUE FOR A CERTAIN TILE IF IT IS MISPLACED OR NOT
-(int) computeMisplacedTiles:(CGPoint) p point:(int) n; //COMPUTES VALUE FOR A CERTAIN TILE IF IT IS MISPLACED OR NOT

//STORES CORRECT INDICES OF EACH NUMBER
@property CGPoint zero;
@property CGPoint one;
@property CGPoint two;
@property CGPoint three;
@property CGPoint four;
@property CGPoint five;
@property CGPoint six;
@property CGPoint seven;
@property CGPoint eight;

@end
