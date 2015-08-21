//
//  hashObject.m
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "hashObject.h"

@implementation hashObject
@synthesize array;

-(id) initHashObject:(NSMutableArray *)a array:(int)d
{
    //self.array = [[NSMutableArray alloc] init];
    self.array = a;
    
    /* MAYBE I DONT NEED A WHOLE NEW COPY TO STORE ARRAY INTO HASH TABLE, JUST A POINTER TO THE CORRECT ONE
    //deep copy array
    for (NSMutableArray *row in a)
    {
        NSMutableArray *rowCopy = [NSMutableArray new];
        for (id item in row)
        {
            [rowCopy addObject:[item copy]];
        }
        [self.array addObject: rowCopy];
    }
    //
     */
    
    return self;
}

-(NSMutableArray *) getArray
{
    return self.array;
}

@end