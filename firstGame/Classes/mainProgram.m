//
//  mainProgram.m
//  firstGame
//
//  Created by Carl Kruk on 1/17/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mainProgram.h"

#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

@implementation mainProgram
@synthesize type, search, easyArray, mediumArray, hardArray, inputArray, correctArray, breadthFirstQueue, boardVisualized;

+(mainProgram *) loadMainProgram:(NSString *) typePuzzle level: (NSString *) searchMethod
{
    return [[self alloc] initMainProgram:typePuzzle level:searchMethod];
}

-(id) initMainProgram:(NSString *) typePuzzle level: (NSString *) searchMethod
{
    self = [super init];
    if(!self) return(nil);
    
    [self addChild:[CCNodeColor nodeWithColor:[CCColor colorWithRed:1.0f green:0.0f blue:1.0f alpha:1.0f]]];
    
    self.type = typePuzzle;
    self.search = searchMethod;
    
    //NSLog(@"%@ %@", self.type, self.search);
    
    self.easyArray = [[NSMutableArray alloc] initWithCapacity:3];
    [self.easyArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],nil] atIndex:0];
    [self.easyArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:8],[NSNumber numberWithInt:6],[NSNumber numberWithInt:2],nil] atIndex:1];
    [self.easyArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:7],[NSNumber numberWithInt:0],[NSNumber numberWithInt:5],nil] atIndex:2];
    
    self.mediumArray = [[NSMutableArray alloc] initWithCapacity:3];
    [self.mediumArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:8],[NSNumber numberWithInt:1],nil] atIndex:0];
    [self.mediumArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:4],[NSNumber numberWithInt:3],nil] atIndex:1];
    [self.mediumArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:7],[NSNumber numberWithInt:6],[NSNumber numberWithInt:5],nil] atIndex:2];
    
    self.hardArray = [[NSMutableArray alloc] initWithCapacity:3];
    [self.hardArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:6],[NSNumber numberWithInt:7],nil] atIndex:0];
    [self.hardArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:4],[NSNumber numberWithInt:0],[NSNumber numberWithInt:8],nil] atIndex:1];
    [self.hardArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],nil] atIndex:2];
    
    /*
    self.inputArray = [[NSMutableArray alloc] initWithCapacity:3];
    [self.inputArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],nil] atIndex:0];
    [self.inputArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:8],[NSNumber numberWithInt:4],[NSNumber numberWithInt:0],nil] atIndex:1];
    [self.inputArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:7],[NSNumber numberWithInt:6],[NSNumber numberWithInt:5],nil] atIndex:2];
    */
    
    self.inputArray = [[NSMutableArray alloc] initWithCapacity:3];
    [self.inputArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],nil] atIndex:0];
    [self.inputArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:8],[NSNumber numberWithInt:5],[NSNumber numberWithInt:0],nil] atIndex:1];
    [self.inputArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:7],[NSNumber numberWithInt:4],[NSNumber numberWithInt:6],nil] atIndex:2];
    
    self.correctArray = [[NSMutableArray alloc] initWithCapacity:3];
    [self.correctArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],nil] atIndex:0];
    [self.correctArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:8],[NSNumber numberWithInt:0],[NSNumber numberWithInt:4],nil] atIndex:1];
    [self.correctArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:7],[NSNumber numberWithInt:6],[NSNumber numberWithInt:5],nil] atIndex:2];
    
    self.breadthFirstQueue = [[queue alloc] initQueue];
    /*
    for (int i = 0; i < 10; i++)
    {
        CCSprite *sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"%d.png", i]];
        sprite.position = ccp(100, 100);
        [self addChild:sprite];
    }
    */
    self.boardVisualized = [[boardVisualizer alloc] initBoardVisualizer:self.inputArray board:self];
    [self.boardVisualized visualizeBoard:ccp(screenWidth / 2, screenHeight / 2)];
    //[self.boardVisualized visualizeSolution:@"UUDDLRRL"];
    
    [self runSearch];
    
    NSLog(@"%@", self);
    
    return self;
}

-(void) runSearch
{
    if ([self.search isEqualToString:@"breadth"])
    {
        [self breadthFirstSearch];
    }
    else if ([self.search isEqualToString:@"depth"])
    {
        [self depthFirstSearch];
    }
    else if ([self.search isEqualToString:@"greedy"])
    {
        
    }
    else //twoA*
    {
        
    }
}

-(void) breadthFirstSearch
{
    //self.inputArray board:0
    
    [self.breadthFirstQueue enqueue:[[Node alloc] initNode:self.inputArray board:0 depth:@""]];
    Node *board;
    
    while(![self.breadthFirstQueue isEmpty])
    {
        board = [self.breadthFirstQueue dequeue]; //points to board, does not make a copy
        
        if ([board compareBoards:self.correctArray])
        {
            break;
        }
        /*
        for (int i = 0; i < 3; i++)
        {
            NSMutableArray *row = [[board getBoard] objectAtIndex:i];
            for (int j = 0; j < 3; j++)
            {
                //NSLog(@"%@", [row objectAtIndex:j]);
            }
        }
        NSLog(@"DONE");
         */
        
        //makes a move for all directions the 0 tile can go
        if ([board zeroLocation].x > 0)
        {
             //pass parameters of board and the direction the 0 tile will move
            [self.breadthFirstQueue enqueue:[self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"U"]];
        }
        if ([board zeroLocation].x < 2)
        {
             [self.breadthFirstQueue enqueue:[self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"D"]];////
        }
        if ([board zeroLocation].y > 0)
        {
             [self.breadthFirstQueue enqueue:[self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"L"]];////
        }
        if ([board zeroLocation].y < 2)
        {
             [self.breadthFirstQueue enqueue:[self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"R"]];////
        }
    }
    
    //NSLog(@"%@", [board getMoves]);
    [self.boardVisualized visualizeSolution:[board getMoves]];
}

-(void) depthFirstSearch
{
    
}

-(Node *) generateMove:(NSMutableArray *) a array: (int) i depth: (CGPoint) p zeroLocation: (NSString *) m moves: (NSString *) move
{
    
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:3]; //deep copy array
    for (NSMutableArray *row in a)
    {
        NSMutableArray *rowCopy = [NSMutableArray new];
        for (id item in row)
        {
            [rowCopy addObject:[item copy]];
        }
        [newArray addObject: rowCopy];
    }
    /*
     for (int i = 0; i < 3; i++)
     {
     for (int j = 0; j < 3; j++)
     {
     NSLog(@"%@", [[newArray objectAtIndex:i] objectAtIndex:j]);
     }
     }
     NSLog(@"DONE");
    
    NSLog(@"%f, %f", p.x, p.y);
    */
    //applies move
    if ([move  isEqual: @"U"])
    {
        NSLog(@"__U__");
        id temp = [[newArray objectAtIndex:(int)p.x - 1] objectAtIndex:(int)p.y];                                       //temporarily store non 0 number;
        //NSLog(@"TEMP IS %@", temp);
        [[newArray objectAtIndex:(int)p.x - 1] replaceObjectAtIndex:(int)p.y withObject:[NSNumber numberWithInt:0]];    //put 0 in the non 0 number's location based on direction
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y withObject:temp];                              //put non 0 number in the old 0 location
        p = CGPointMake( p.x - 1 ,  p.y);                                                                               //update 0 location
    }
    else if ([move  isEqual: @"D"])
    {
        NSLog(@"__D__");
        id temp = [[newArray objectAtIndex:(int)p.x + 1] objectAtIndex:(int)p.y];
        //NSLog(@"TEMP IS %@", temp);
        [[newArray objectAtIndex:(int)p.x + 1] replaceObjectAtIndex:(int)p.y withObject:[NSNumber numberWithInt:0]];
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y withObject:temp];
        p = CGPointMake( p.x + 1 ,  p.y );
    }
    else if ([move  isEqual: @"L"])
    {
        NSLog(@"__L__");
        id temp = [[newArray objectAtIndex:(int)p.x] objectAtIndex:(int)p.y - 1];                   ////
        //NSLog(@"TEMP IS %@", temp);
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y - 1 withObject:[NSNumber numberWithInt:0]];
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y withObject:temp];
        p = CGPointMake( p.x ,  p.y - 1 );
    }
    else
    {
        NSLog(@"__R__");
        
        id temp = [[newArray objectAtIndex:(int)p.x] objectAtIndex:(int)p.y + 1];                   ////
        //NSLog(@"TEMP IS %@", temp);
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y + 1 withObject:[NSNumber numberWithInt:0]];
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y withObject:temp];
        p = CGPointMake( p.x ,  p.y + 1 );
    }
    //
    
    Node *newNode = [[Node alloc] initNode: newArray board: (i + 1) depth: [NSString stringWithFormat:@"%@%@", m, move]]; //creates new node with updated board, current depth, and current set of moves
    /*
    for (int i = 0; i < 3; i++)
    {
        NSLog(@"%@ %@ %@", [[newArray objectAtIndex:i] objectAtIndex:0], [[newArray objectAtIndex:i] objectAtIndex:1], [[newArray objectAtIndex:i] objectAtIndex:2]);
    }
    NSLog(@"DONE");
    
    NSLog(@"%f, %f", p.x, p.y);
    */
    return newNode;
}

@end
