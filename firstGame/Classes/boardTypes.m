//
//  boardTypes.m
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "boardTypes.h"

@implementation boardTypes
@synthesize easyArray, mediumArray, hardArray, inputArray, correctArray;

-(id) initBoardTypes
{
    
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
    
    self.inputArray = [[NSMutableArray alloc] initWithCapacity:3];
    //[self.inputArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],nil] atIndex:0];
    //[self.inputArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:8],[NSNumber numberWithInt:5],[NSNumber numberWithInt:0],nil] atIndex:1];
    //[self.inputArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:7],[NSNumber numberWithInt:4],[NSNumber numberWithInt:6],nil] atIndex:2];
    
    self.correctArray = [[NSMutableArray alloc] initWithCapacity:3];
    [self.correctArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],nil] atIndex:0];
    [self.correctArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:8],[NSNumber numberWithInt:0],[NSNumber numberWithInt:4],nil] atIndex:1];
    [self.correctArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:7],[NSNumber numberWithInt:6],[NSNumber numberWithInt:5],nil] atIndex:2];
    
    return self;
}

-(NSMutableArray *) getEasyArray
{
    return self.easyArray;
}

-(NSMutableArray *) getMediumArray
{
    return self.mediumArray;
}

-(NSMutableArray *) getHardArray
{
    return self.hardArray;
}

-(NSMutableArray *) getInputArray
{
    return self.inputArray;
}

-(NSMutableArray *) getCorrectArray
{
    return self.correctArray;
}

-(void) newInputBoard:(NSMutableArray *) a
{
    [self.inputArray insertObject:[NSMutableArray arrayWithObjects:[a objectAtIndex:0],[a objectAtIndex:1],[a objectAtIndex:2],nil] atIndex:0];
    [self.inputArray insertObject:[NSMutableArray arrayWithObjects:[a objectAtIndex:3],[a objectAtIndex:4],[a objectAtIndex:5],nil] atIndex:1];
    [self.inputArray insertObject:[NSMutableArray arrayWithObjects:[a objectAtIndex:6],[a objectAtIndex:7],[a objectAtIndex:8],nil] atIndex:2];
}

@end
