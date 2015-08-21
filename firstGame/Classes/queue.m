//
//  queue.m
//  firstGame
//
//  Created by Carl Kruk on 1/17/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "queue.h"

@implementation queue
@synthesize first, last, sizeOf, maxSizeSeen;

-(id) initQueue
{
    self.first = NULL;
    self.last = NULL;
    
    self.sizeOf = 0;
    self.maxSizeSeen = self.sizeOf;
    
    return self;
}

-(int) getQueueSize
{
    return self.sizeOf;
}

-(int) getMaxSizeSeen
{
    return self.maxSizeSeen;
}

-(void) updateMaxSizeSeen //if NEW MAX SIZE SEEN< UPDATE
{
    if (self.sizeOf > self.maxSizeSeen)
    {
        self.maxSizeSeen = self.sizeOf;
    }
}

-(void) enqueue:(Node *) newLast //ADDS NODE TO BACK OF QUEUE
{
    if (self.isEmpty) {
        self.first = self.last = newLast;
    }
    else {
        self.last.next = newLast;
        self.last = self.last.next;
    }
    self.sizeOf++;
    [self updateMaxSizeSeen];
}

-(Node *) dequeue //REMOVES NODE FROM FRONT OF QUEUE
{
    if (self.isEmpty) {
        return NULL;
    }
    Node *node = self.first;
    self.first = self.first.next;
    //self.size--;
    if (self.first == NULL) {
        self.last = NULL;
    }

    self.sizeOf--;
    return node;
}

-(void) sortByManhattanDistance //INSERTION SORT TO SORT QUEUE BY MANHATTAN DISTANCE
{
    
    for (int i = 1; i < self.sizeOf; i++)
    {
        for (int j = i; j > 0; j--)
        {
            Node *temp0;
            Node *temp1 = [self getNodeAt:j];
            Node *temp2 = [self getNodeAt:j - 1];
            
            if ([temp1 getManhattanDistance] < [temp2 getManhattanDistance])
            {
                if (j == 1)
                {
                    temp2.next = temp1.next;
                    temp1.next = temp2;
                    self.first = temp1;
                    if (self.sizeOf == 2)
                    {
                        self.last = temp2;
                    }
                }
                else if (j == i) //BROKEN CODE SECTION/SORTING IS NOT COMPLETE BUT PARTIALLY CORRECT
                {
                    /*
                    //temp0 = [self getNodeAt:j - 2];
                    //temp0.next = temp1;
                    if (self.sizeOf > 2)
                    {
                        temp0 = [self getNodeAt:j - 2];
                        temp0.next = temp1;
                    }
                    temp2.next = temp1.next;
                    temp1.next = temp2;
                    self.last = temp2;
                    if (self.sizeOf == j - 1)
                    {
                        self.last = temp1;
                    }
                     */
                }
                else
                {
                    temp0 = [self getNodeAt:j - 2];
                    temp2.next = temp1.next;
                    temp1.next = temp2;
                    temp0.next = temp1;
                }
            }
        }
    }
}

-(void) sortByFOfNManhattan //INSERTION SORT TO SORT QUEUE BY f(n) MANHATTAN DISTANCE
{
    //NSLog(@"QUEUE SIZE: %d", self.sizeOf);
    for (int i = 1; i < self.sizeOf; i++)
    {
        for (int j = i; j > 0; j--)
        {
            Node *temp0;
            Node *temp1 = [self getNodeAt:j];
            Node *temp2 = [self getNodeAt:j - 1];
            
            if ([temp1 getFofNfromManhattan] < [temp2 getFofNfromManhattan])
            {
                if (j == 1)
                {
                    temp2.next = temp1.next;
                    temp1.next = temp2;
                    self.first = temp1;
                    if (self.sizeOf == 2)
                    {
                        self.last = temp2;
                    }
                }
                else if (j == i) //BROKEN CODE SECTION/SORTING IS NOT COMPLETE BUT PARTIALLY CORRECT
                {
                    /*
                     //temp0 = [self getNodeAt:j - 2];
                     //temp0.next = temp1;
                     if (self.sizeOf > 2)
                     {
                     temp0 = [self getNodeAt:j - 2];
                     temp0.next = temp1;
                     }
                     temp2.next = temp1.next;
                     temp1.next = temp2;
                     self.last = temp2;
                     if (self.sizeOf == j - 1)
                     {
                     self.last = temp1;
                     }
                     */
                }
                else
                {
                    temp0 = [self getNodeAt:j - 2];
                    temp2.next = temp1.next;
                    temp1.next = temp2;
                    temp0.next = temp1;
                }
            }
        }
    }
}

-(void) sortByFOfNMisplaced //INSERTION SORT TO SORT QUEUE BY f(n) MISPLACED TILES
{
    for (int i = 1; i < self.sizeOf; i++)
    {
        for (int j = i; j > 0; j--)
        {
            Node *temp0;
            Node *temp1 = [self getNodeAt:j];
            Node *temp2 = [self getNodeAt:j - 1];
            
            if ([temp1 getFofNfromMisplaced] < [temp2 getFofNfromMisplaced])
            {
                if (j == 1)
                {
                    temp2.next = temp1.next;
                    temp1.next = temp2;
                    self.first = temp1;
                    if (self.sizeOf == 2)
                    {
                        self.last = temp2;
                    }
                }
                else if (j == i) //BROKEN CODE SECTION/SORTING IS NOT COMPLETE BUT PARTIALLY CORRECT
                {
                    /*
                     //temp0 = [self getNodeAt:j - 2];
                     //temp0.next = temp1;
                     if (self.sizeOf > 2)
                     {
                     temp0 = [self getNodeAt:j - 2];
                     temp0.next = temp1;
                     }
                     temp2.next = temp1.next;
                     temp1.next = temp2;
                     self.last = temp2;
                     if (self.sizeOf == j - 1)
                     {
                     self.last = temp1;
                     }
                     */
                }
                else
                {
                    temp0 = [self getNodeAt:j - 2];
                    temp2.next = temp1.next;
                    temp1.next = temp2;
                    temp0.next = temp1;
                }
            }
        }
    }
}

-(Node *) getNodeAt:(int) i //RETURN NODE FOUND AT "INDEX" IN QUEUE
{
    int tempI = 0;
    Node *temp = self.first;
    while (tempI != i)
    {
        temp = temp.next;
        tempI++;
    }
    return temp;
}

-(BOOL) isEmpty
{
    return (self.first == NULL) && (self.last == NULL);
}


@end