//
//  stack.m
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "stack.h"

@implementation stack
@synthesize top, maxSizeSeen, sizeOf;

-(id) initStack
{
    self.top = NULL;
    
    self.sizeOf = 0;
    self.maxSizeSeen = self.sizeOf;
    
    return self;
}

-(int) getMaxSizeSeen
{
    return self.maxSizeSeen;
}

-(void) updateMaxSizeSeen
{
    if (self.sizeOf > self.maxSizeSeen)
    {
        self.maxSizeSeen = self.sizeOf;
    }
}

-(void) push:(Node *)n //ADDS OBJECT TO TOP OF STACK
{
    if (self.isEmpty)
    {
        self.top = n;
    }
    else
    {
        Node *temp = self.top;
        self.top = n;
        self.top.next = temp;
    }
    self.sizeOf++;
    [self updateMaxSizeSeen];
}

-(Node *) pop //REMOVES OBJECT FROM TOP OF STACK
{
    if ([self isEmpty])
    {
        return NULL;
    }
    Node *temp = self.top;
    self.top = self.top.next;
    self.sizeOf++;
    return temp;
}

-(BOOL) isEmpty
{
    return (self.top == NULL);
}

@end