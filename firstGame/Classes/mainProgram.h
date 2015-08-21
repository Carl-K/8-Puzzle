//
//  mainProgram.h
//  firstGame
//
//  Created by Carl Kruk on 1/17/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"

#import "queue.h"
#import "Node.h"
#import "boardVisualizer.h"

@interface mainProgram : CCScene

+(mainProgram *) loadMainProgram:(NSString *) typePuzzle level: (NSString *) searchMethod;
-(id) initMainProgram:(NSString *) typePuzzle level: (NSString *) searchMethod;

@property NSString *type;
@property NSString *search;

@property NSMutableArray *easyArray;
@property NSMutableArray *mediumArray;
@property NSMutableArray *hardArray;
@property NSMutableArray *inputArray;

@property NSMutableArray *correctArray;

@property queue *breadthFirstQueue;
@property boardVisualizer *boardVisualized;

@end
