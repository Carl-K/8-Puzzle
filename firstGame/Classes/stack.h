//
//  stack.h
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "Node.h"

@interface stack : NSObject

//-----GENERIC STACK FOR DEPTH FIRST SEARCH-----

-(id) initStack; //CONSTUCTOR
-(void) push:(Node *) n;
-(Node *) pop;
-(BOOL) isEmpty; //IS THE STACK EMPTY?
-(int) getMaxSizeSeen; //RETURNS MAX SIZE THAT STACK HAD

@property int sizeOf; //STORES CURRENT AMOUNT OF OBJECTS STORED IN STACK
@property int maxSizeSeen; //STORES MAX AMOUNT OF OBJECTS STORED IN STACK

@property Node *top;

@end
