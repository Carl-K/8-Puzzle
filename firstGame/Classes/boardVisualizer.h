//
//  boardVisualizer.h
//  firstGame
//
//  Created by Carl Kruk on 1/23/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "CCSprite.h"
#import "Tile.h"

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface boardVisualizer : CCSprite

//-----HANDLES THE DISPLAY AND ANIMATIONS OF INDIVIDUAL TILES FOR SCREEN AND HANDLES AND PROCESSES ARRAY SWAPS INTERNALLY ONCE A SOLUTION HAS BEEN FOUND
//-----LOTS OF GUI STUFF

-(id) initBoardVisualizer:(CCNode *) l; //CONSTRUCTOR

//-----HANDLES BOARD VISUALS ON SCREEN
-(void) spawnBackBoard:(CGPoint) center;
-(void) unspawnBackBoard;
-(void) visualizeBoard:(CGPoint) p;
-(void) unvisualizeBoard;

//-----PROCESSES SOLUTION TO RUNS ANIMATIONS AND ARRAY SWAPS, RECURSIVE
-(void) visualizeSolution:(NSString *) s;

-(void) newBoard:(NSMutableArray *) a; //ASSIGNS ARRAY TO VARIABLE ONCE USERS SPECIFIES WHAT TYPE OF BOARD THEY WANT

@property CCNode *layer; //POINTS TO SCREEN
@property NSMutableArray *board;
@property CGPoint zeroLocation; //STORES LOCATION OF ZERO IN ARRAY FOR FASTER ACCESS OF ZERO TILE
@property NSString *solution;
@property CCSprite *backBoard;

@end
