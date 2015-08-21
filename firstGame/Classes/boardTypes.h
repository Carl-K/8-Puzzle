//
//  boardTypes.h
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

@interface boardTypes : NSObject

//-----SETS UP ARRAYS USED

-(id) initBoardTypes;

-(NSMutableArray *) getEasyArray;
-(NSMutableArray *) getMediumArray;
-(NSMutableArray *) getHardArray;
-(NSMutableArray *) getInputArray;
-(NSMutableArray *) getCorrectArray;
-(void) newInputBoard: (NSMutableArray *) a;

@property NSMutableArray *easyArray;
@property NSMutableArray *mediumArray;
@property NSMutableArray *hardArray;
@property NSMutableArray *inputArray;
@property NSMutableArray *correctArray;

@end
