//
//  menu.h
//  firstGame
//
//  Created by Carl Kruk on 1/17/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface menu : CCScene

+(menu *) loadMenu;
-(id) initMenu;

@property CCButton *runEasy;
@property CCButton *runMedium;
@property CCButton *runHard;
@property CCButton *runInput;

@property CCButton *breadthFirst;
@property CCButton *depthFirst;
@property CCButton *greedyBest_First;
@property CCButton *twoA;

@property NSString *fontName;
@property float fontSize;
@property CCColor *fontColor;

@property CCButton *back;

@property NSString *level;
@property NSString *search;

@end
