//
//  Program.h
//  firstGame
//
//  Created by Carl Kruk on 1/23/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

#import "breadthFirstSearch.h"
#import "depthFirstSearch.h"
#import "greedyBestSearch.h"
#import "A1.h"
#import "A2.h"

#import "tilebutton.h"

#import "boardVisualizer.h"
#import "boardTypes.h"

#import "Node.h"

#import "queue.h"

//-----MAIN SCENE/WHAT LOADS ONTO SCREEN-----
//-----ALOT OF THIS STUFF IS JUST BASIC METHODS FOR CREATING OBJECTS ONTO THE SCREEN LIKE THE "EASY" BUTTON-----
//-----THE NSLog FUNCTION JUST PRINT STUFF INTO THE CONSOLE WINDOW
//----- TEXT THAT IS ENCAPSULATED WITH BRACKETS ( [ ... ] ) ARE FUNCTIONS AND TEXT SEPERATED WITH DOTS ( . ) ARE VARIABLES

@interface Program : CCScene

+(Program *) loadProgram; //CONSTRUCTOR TO SET UP SCENE/CONTENTS ON SCREEN
-(id) initProgram; //CONSTRUCTOR

@property NSString *fontName;
@property float fontSize;

//-----DIFFICULTY BUTTONS
@property CCButton *easyButton;
@property CCButton *mediumButton;
@property CCButton *hardButton;
@property CCButton *inputButton;

//-----NUMBERED BUTTONS FOR WHEN USER CLICKS "INPUT" BUTTON
@property tilebutton *zeroButton;
@property tilebutton *oneButton;
@property tilebutton *twoButton;
@property tilebutton *threeButton;
@property tilebutton *fourButton;
@property tilebutton *fiveButton;
@property tilebutton *sixButton;
@property tilebutton *sevenButton;
@property tilebutton *eightButton;

//-----HELPER VARIABLES FOR WHEN USER CLICKS "INPUT" BUTTON
@property NSMutableArray *inputString;
@property int tilesClicked;

//-----SEARCH TYPE BUTTONS
@property CCButton *breadthButton;
@property CCButton *depthButton;
@property CCButton *greedyBestButton;
@property CCButton *A1Button;
@property CCButton *A2Button;

@property NSMutableArray *array; //FACILITATES PASSING AROUND ARRAY USER WANTS TO PROCESS

//-----VARIABLES TO STORE AND ACCESS OTHER CLASSES
@property depthFirstSearch *dFS;
@property breadthFirstSearch *bFS;
@property greedyBestSearch *gBS;
@property A1 *a1;
@property A2 *a2;

@property boardVisualizer *boardVisualizer;
@property boardTypes *boardTypes;

@property CCButton *restartButton;
@property CCLabelTTF *stats; //outputs information at the end of finding a solution

@end
