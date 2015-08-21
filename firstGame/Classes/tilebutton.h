//
//  tilebutton.h
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

//-----CREATES AND HANDLES THE NUMBERED BUTTONS WHEN USER CLICKS THE "INPUT" BUTTON IN THE PROGRAM, NOTHING TO SEE HERE

@interface tilebutton : NSObject

-(id) initTileButton:(int) n num:(CCNode *) l;
-(int) getNumber;
-(CCButton *) getButton;

@property CCNode *layer;
@property CCButton *button;
@property int number;

@end
