//
//  boardVisualizer.m
//  firstGame
//
//  Created by Carl Kruk on 1/23/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "boardVisualizer.h"
#import <Foundation/Foundation.h>

@implementation boardVisualizer
@synthesize board, layer, zeroLocation, solution, backBoard;

#define actionTime 0.1f

-(id) initBoardVisualizer:(CCNode *)l
{
    self.layer = l;
    self.solution = @"";
    self.backBoard = [CCSprite spriteWithImageNamed:@"boardBackground.png"];
    self.board = [[NSMutableArray alloc] initWithCapacity:3];
    
    return self;
}

-(void) spawnBackBoard:(CGPoint) center
{
    self.backBoard.position = center;
    [self.layer addChild:self.backBoard];
}

-(void) unspawnBackBoard
{
    [self.layer removeChild:self.backBoard];
}

-(void) visualizeBoard:(CGPoint)p
{
    int pivot = (int)(self.board.count / 2);
    
    for (int i = 0; i < self.board.count; i++)
    {
        NSMutableArray *row = [self.board objectAtIndex:i];
        for (int j = 0; j < self.board.count; j++)
        {
            Tile *tile = [row objectAtIndex:j];
            CGPoint point = ccp( p.x + ((j - pivot) * [tile getSpriteSize].width) + ((j - pivot) * 5) , p.y + ((pivot - i) * [tile getSpriteSize].height)  + ((pivot - i) * 5) );
            if ([tile getNumber] == 0)
            {
                [tile getSprite].opacity = 0;
            }
            [tile visualizeTile:point];
        }
    }
}

-(void) unvisualizeBoard
{
    for (int i = 0; i < self.board.count; i++)
    {
        NSMutableArray *row = [self.board objectAtIndex:i];
        for (int j = 0; j < row.count; j++)
        {
            Tile *tile = [row objectAtIndex:j];
            [tile unvisualizeTile];
        }
    }
}

-(void) visualizeSolution:(NSString *)s
{
    self.solution = s;
    [self visualizeSolutionHelper]; //RECURSIVES PROCESSES SOLUTION STRING TO GENERATE ANIMATIONS AND ARRAY SWAPS
}

-(void) visualizeSolutionHelper
{
    if (![self.solution isEqualToString:@""])
    {
        if ([self.solution characterAtIndex:0] == 'U')
        {
            NSMutableArray *rowWithZero = [self.board objectAtIndex:(int)self.zeroLocation.x];
            Tile *tileZero = [rowWithZero objectAtIndex:(int)self.zeroLocation.y];
            
            NSMutableArray *rowAbove = [self.board objectAtIndex:(int)self.zeroLocation.x - 1];
            Tile *tileAbove = [rowAbove objectAtIndex:(int)self.zeroLocation.y];
            
            CCActionMoveTo *moveZeroTile = [CCActionMoveTo actionWithDuration:actionTime position:[tileAbove getTileLocation]];
            [[tileZero getSprite] runAction:moveZeroTile];
            
            CCActionMoveTo *moveAboveTile = [CCActionMoveTo actionWithDuration:actionTime position:[tileZero getTileLocation]];
            
            CCActionSequence *actionSequence = [CCActionSequence actions:moveAboveTile, [CCActionCallFunc actionWithTarget:self selector:@selector(visualizeSolutionHelper)], nil];
            
            [[tileAbove getSprite] runAction:actionSequence];
            
            [rowWithZero replaceObjectAtIndex:self.zeroLocation.y withObject:tileAbove];
            [rowAbove replaceObjectAtIndex:self.zeroLocation.y withObject:tileZero];

            self.zeroLocation = ccp(self.zeroLocation.x - 1, self.zeroLocation.y);
        }
        else if ([self.solution characterAtIndex:0] == 'D')
        {
            NSMutableArray *rowWithZero = [self.board objectAtIndex:(int)self.zeroLocation.x];
            Tile *tileZero = [rowWithZero objectAtIndex:(int)self.zeroLocation.y];
            NSMutableArray *rowBelow = [self.board objectAtIndex:(int)self.zeroLocation.x + 1];
            Tile *tileBelow = [rowBelow objectAtIndex:(int)self.zeroLocation.y];
            
            CCActionMoveTo *moveZeroTile = [CCActionMoveTo actionWithDuration:actionTime position:[tileBelow getTileLocation]];
            [[tileZero getSprite] runAction:moveZeroTile];
            
            CCActionMoveTo *moveBelowTile = [CCActionMoveTo actionWithDuration:actionTime position:[tileZero getTileLocation]];
            
            CCActionSequence *actionSequence = [CCActionSequence actions:moveBelowTile, [CCActionCallFunc actionWithTarget:self selector:@selector(visualizeSolutionHelper)], nil];
            
            [[tileBelow getSprite] runAction:actionSequence];
            
            [rowWithZero replaceObjectAtIndex:self.zeroLocation.y withObject:tileBelow];
            [rowBelow replaceObjectAtIndex:self.zeroLocation.y withObject:tileZero];
            
            self.zeroLocation = ccp(self.zeroLocation.x + 1, self.zeroLocation.y);
        }
        else if ([self.solution characterAtIndex:0] == 'L')
        {
            NSMutableArray *row = [self.board objectAtIndex:(int)self.zeroLocation.x];
            Tile *tileZero = [row objectAtIndex:zeroLocation.y];
            Tile *tileLeft = [row objectAtIndex:zeroLocation.y - 1];
            
            CCActionMoveTo *moveZeroTile = [CCActionMoveTo actionWithDuration:actionTime position:[tileLeft getTileLocation]];
            [[tileZero getSprite] runAction:moveZeroTile];
            
            CCActionMoveTo *moveLeftTile = [CCActionMoveTo actionWithDuration:actionTime position:[tileZero getTileLocation]];
            
            CCActionSequence *actionSequence = [CCActionSequence actions:moveLeftTile, [CCActionCallFunc actionWithTarget:self selector:@selector(visualizeSolutionHelper)], nil];
            
            [[tileLeft getSprite] runAction:actionSequence];
            
            [row replaceObjectAtIndex:self.zeroLocation.y withObject:tileLeft];
            [row replaceObjectAtIndex:self.zeroLocation.y - 1 withObject:tileZero];
            
            self.zeroLocation = ccp(self.zeroLocation.x, self.zeroLocation.y - 1);
        }
        else
        {
            NSMutableArray *row = [self.board objectAtIndex:(int)self.zeroLocation.x];
            Tile *tileZero = [row objectAtIndex:zeroLocation.y];
            Tile *tileRight = [row objectAtIndex:zeroLocation.y + 1];
            
            CCActionMoveTo *moveZeroTile = [CCActionMoveTo actionWithDuration:actionTime position:[tileRight getTileLocation]];
            [[tileZero getSprite] runAction:moveZeroTile];
            
            CCActionMoveTo *moveRightTile = [CCActionMoveTo actionWithDuration:actionTime position:[tileZero getTileLocation]];
            
            CCActionSequence *actionSequence = [CCActionSequence actions:moveRightTile, [CCActionCallFunc actionWithTarget:self selector:@selector(visualizeSolutionHelper)], nil];
            
            [[tileRight getSprite] runAction:actionSequence];
            
            [row replaceObjectAtIndex:self.zeroLocation.y withObject:tileRight];
            [row replaceObjectAtIndex:self.zeroLocation.y + 1 withObject:tileZero];
            
            self.zeroLocation = ccp(self.zeroLocation.x, self.zeroLocation.y + 1);
        }
        self.solution = [self.solution substringFromIndex:1];
    }
}

-(void) newBoard:(NSMutableArray *)a
{
    //deep copy array
    for (NSMutableArray *row in a)
    {
        NSMutableArray *rowCopy = [NSMutableArray new];
        for (id item in row)
        {
            [rowCopy addObject:[item copy]];
        }
        [self.board addObject: rowCopy];
    }
    //
    
    //create tiles from number array
    for (int i = 0; i < 3; i++)
    {
        NSMutableArray *row = [self.board objectAtIndex:i];
        for (int j = 0; j < 3; j++)
        {
            //NSLog(@"%d", [[row objectAtIndex:j] intValue]);
            Tile *tile = [[Tile alloc] initTile:[CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"%d.png", [[row objectAtIndex:j] intValue] ]] tile:[[row objectAtIndex:j] intValue] number:self.layer];
            if ([[row objectAtIndex:j] intValue] == 0)
            {
                self.zeroLocation = ccp(i, j);
            }
            [row replaceObjectAtIndex:j withObject:tile];
        }
    }
    /*
    for (int i = 0; i < 3; i++)
    {
        NSMutableArray *row = [self.board objectAtIndex:i];
        for (int j = 0; j < 3; j++)
        {
            NSLog(@"%@", [row objectAtIndex:j]);
        }
    }
     */
}

@end