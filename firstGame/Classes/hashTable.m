//
//  hashTable.m
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "hashTable.h"

#define R 31 //FULLY UTILIZES ALL BITS IN A 32 BIT INTEGER

@implementation hashTable
@synthesize hashArray;

-(id) initHashTable:(int) initialSize
{
    self.hashArray = [[NSMutableArray alloc] initWithCapacity:initialSize]; //HASH TABLE WITH SEPERATE CHAINING
    for (int i = 0; i < initialSize; i++)
    {
        [self.hashArray insertObject:[[NSMutableArray alloc] init] atIndex:i]; //NSMutableArray TYPE ALLOWS FOR EASY INSERTION OR DELETION OF OBJECTS INTO AND OUT OF ARRAY, NATURAL FOR SEPERATE CHAINING. THINK ARRAY OF ARRAYS
    }
    return self;
}

-(int) hashFunction:(Node *) n //COMPUTES HASH CODE IN LINEAR TIME RESPECTIVE TO A 3x3 int BOARD
{
    int hash = 0;
    NSMutableArray *temp = [n getBoard];
    for (int i = 0; i < 3; i++) //ITERATE THROUGH BOARD
    {
        NSMutableArray *row = [temp objectAtIndex:i];
        for (int j = 0; j < 3; j++)
        {
            hash = hash * R + [[row objectAtIndex:j] intValue]; //COMPUTES INT VALLUE FROM EACH INDICE IN BOARD
        }
    }
    return hash;
}

-(int) hashFunctionObj:(hashObject *) hObj //QUICK WAY TO CHECK HASH OF OBJECT ALREADY IN THE TABLE, OTHERWISE I WOULD HAVE TO CONVERT hashObject TO Node OR VICE VERSA. LINEAR TIME HASH COMPUTATION
{
    int hash = 0;
    NSMutableArray *temp = [hObj getArray];
    for (int i = 0; i < 3; i++)
    {
        NSMutableArray *row = [temp objectAtIndex:i];
        for (int j = 0; j < 3; j++)
        {
            hash = hash * R + [[row objectAtIndex:j] intValue];
        }
    }
    return hash;
}

-(int) hash:(Node *) n //RETURNS INDEX
{
    return ([self hashFunction:n] & 0x7fffffff) % self.hashArray.count; 
}

-(void) insertInto:(Node *)n
{
    int index = [self hash:n]; //GET INDEX
    NSMutableArray *row = [self.hashArray objectAtIndex:index]; //FIND ROW
    hashObject *hashObj = [[hashObject alloc] initHashObject:[n getBoard] array:[n getIteration]]; //MAKE HASH OBJECT TO STORE PERTINENT INFORMATION IN HASH TABLE
    [row addObject:hashObj]; //INSERT INTO TABLE
}

-(void) deleteObject:(Node *) n //REMOVE OBJECT FROM HASH TABLE
{
    int hash = [self hashFunction:n];
    int index = [self hash:n];
    
    NSMutableArray *row = [self.hashArray objectAtIndex:index]; //FIND CORRECT ROW STORED IN TABLE
    for (int i = 0; i < row.count; i++)
    {
        if ( hash == [self hashFunctionObj:[row objectAtIndex:i]] ) //COMPARE HASHES, NOT INDICES TO FIND
        {
            [row removeObjectAtIndex:i];
            return;
        }
    }
}

-(BOOL) checkForDuplicate:(Node *) n //CHECK FOR DUPLICATES
{
    int hash = [self hashFunction: n];
    int index = [self hash:n];
    
    NSMutableArray *row = [self.hashArray objectAtIndex:index];
    for (int i = 0; i < row.count; i++)
    {
        hashObject *hObj = [row objectAtIndex:i];
        if (hash == [self hashFunctionObj:hObj]) //COMPARE HASHES, NOT INDICES TO FIND
        {
            return TRUE;
        }
    }
    return FALSE;
}

@end