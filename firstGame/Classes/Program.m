//
//  Program.m
//  firstGame
//
//  Created by Carl Kruk on 1/23/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Program.h"

#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height
#define boardCenter ccp(screenWidth / 2, screenHeight / 2 + 100)
#define inputCenter ccp(screenWidth / 2, screenHeight / 2 - 100)
#define searchCenter ccp(screenWidth / 2 + 10, screenHeight / 2)

@implementation Program
@synthesize fontName, fontSize, easyButton, mediumButton, hardButton, inputButton, zeroButton, oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton,
breadthButton, depthButton, greedyBestButton, A1Button, A2Button,array, bFS, dFS, gBS, a1, a2, boardVisualizer, boardTypes, inputString, tilesClicked, restartButton, stats;

+(Program *) loadProgram
{
    return [[self alloc] initProgram];
}

-(id) initProgram
{
    self = [super init];
    if(!self) return(nil);
    
    //CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1.0f green:0.0f blue:1.0f alpha:1.0f]];
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor grayColor]];
    [self addChild:background];
    
    self.fontName = @"Helvetica";
    self.fontSize = 18.0f;
    
    //-----INIT DIFFICULTY BUTTONS
    self.easyButton = [CCButton buttonWithTitle:@"EASY" fontName:self.fontName fontSize:self.fontSize];
    self.mediumButton = [CCButton buttonWithTitle:@"MEDIUM" fontName:self.fontName fontSize:self.fontSize];
    self.hardButton = [CCButton buttonWithTitle:@"HARD" fontName:self.fontName fontSize:self.fontSize];
    self.inputButton = [CCButton buttonWithTitle:@"INPUT" fontName:self.fontName fontSize:self.fontSize];
    
    
    //-----INIT NUMBERED TILES
    self.zeroButton = [[tilebutton alloc] initTileButton:0 num:self];
    self.oneButton = [[tilebutton alloc] initTileButton:1 num:self];
    self.twoButton = [[tilebutton alloc] initTileButton:2 num:self];
    self.threeButton = [[tilebutton alloc] initTileButton:3 num:self];
    self.fourButton = [[tilebutton alloc] initTileButton:4 num:self];
    self.fiveButton = [[tilebutton alloc] initTileButton:5 num:self];
    self.sixButton = [[tilebutton alloc] initTileButton:6 num:self];
    self.sevenButton = [[tilebutton alloc] initTileButton:7 num:self];
    self.eightButton = [[tilebutton alloc] initTileButton:8 num:self];
    
    //-----INIT SEARCH BUTTONS
    self.breadthButton = [CCButton buttonWithTitle:@"BREADTH" fontName:@"Helvetica" fontSize:18.0f];
    self.depthButton = [CCButton buttonWithTitle:@"DEPTH" fontName:@"Helvetica" fontSize:18.0f];
    self.greedyBestButton = [CCButton buttonWithTitle:@"GREEDY BEST" fontName:@"Helvetica" fontSize:18.0f];
    self.A1Button = [[CCButton alloc] initWithTitle:@"A*1" fontName:self.fontName fontSize:self.fontSize];
    self.A2Button = [[CCButton alloc] initWithTitle:@"A*2" fontName:self.fontName fontSize:self.fontSize];
    
    //-----INIT ADDITIONAL CLASSES FOR PROGRAM CLASS TO USE
    self.bFS = [[breadthFirstSearch alloc] initBreadthFirstSearch];
    self.dFS = [[depthFirstSearch alloc] initDepthFirstSearch];
    self.gBS = [[greedyBestSearch alloc] initGreedyBestFirst];
    self.a1 = [[A1 alloc] initA1];
    self.a2 = [[A2 alloc] initA2];
    
    self.boardVisualizer = [[boardVisualizer alloc] initBoardVisualizer:self];
    self.boardTypes = [[boardTypes alloc] initBoardTypes];
    
    self.array = [[NSMutableArray alloc] initWithCapacity:3]; //INIT MUTABLE ARRAY
    
    [self.boardVisualizer spawnBackBoard:boardCenter];
    [self spawnDifficultyButtons];
    
    self.inputString = [[NSMutableArray alloc] init];
    self.tilesClicked = 0;
    
    self.restartButton = [CCButton buttonWithTitle:@"RESTART" fontName:self.fontName fontSize:self.fontSize];
    
    self.stats = [CCLabelTTF labelWithString:@"" fontName:self.fontName fontSize:self.fontSize];
    self.stats.position = ccp(screenWidth / 2, screenHeight / 2 - 200);
    self.stats.dimensions = CGSizeMake(screenWidth - 50, screenHeight - 50);
    self.stats.horizontalAlignment = CCTextAlignmentCenter;
    
    return self;
}


//-----

-(void) spawnDifficultyButtons //SPAWNS DIFFICULTY BUTTONS ONTO SCREEN AND WHAT TO DO WHEN CLICKED
{
    self.easyButton.position = ccp(screenWidth / 2 - self.easyButton.boundingBox.size.width, screenHeight / 2 + self.easyButton.boundingBox.size.height);
    [self addChild:self.easyButton];
    [self.easyButton setTarget:self selector:@selector(easyClicked:)];
    
    self.mediumButton.position = ccp(screenWidth / 2 + self.easyButton.boundingBox.size.width, screenHeight / 2 + self.easyButton.boundingBox.size.height);
    [self addChild:self.mediumButton];
    [self.mediumButton setTarget:self selector:@selector(mediumClicked:)];
    
    self.hardButton.position = ccp(screenWidth / 2 - self.easyButton.boundingBox.size.width, screenHeight / 2 - self.easyButton.boundingBox.size.height);
    [self addChild:self.hardButton];
    [self.hardButton setTarget:self selector:@selector(hardClicked:)];
    
    self.inputButton.position = ccp(screenWidth / 2 + self.easyButton.boundingBox.size.width, screenHeight / 2 - self.easyButton.boundingBox.size.height);
    [self addChild:self.inputButton];
    [self.inputButton setTarget:self selector:@selector(inputClicked:)];
}

-(void) unspawnDifficultyButtons //REMOVES DIFFICULTY BUTTONS FROM SCREEN
{
    [self removeChild:self.easyButton];
    [self removeChild:self.mediumButton];
    [self removeChild:self.hardButton];
    [self removeChild:self.inputButton];
}

-(void) spawnSearchButtons //SPAWNS SEARCH BUTTONS ONTO SCREEN AND WHAT TO DO WHEN CLICKED
{
    self.breadthButton.position = ccp(searchCenter.x - self.breadthButton.boundingBox.size.width, searchCenter.y + self.breadthButton.boundingBox.size.height);
    [self addChild:self.breadthButton];
    [self.breadthButton setTarget:self selector:@selector(breadthClicked:)];
    
    self.depthButton.position = ccp(searchCenter.x + self.depthButton.boundingBox.size.width, searchCenter.y + self.depthButton.boundingBox.size.height);
    [self addChild:self.depthButton];
    [self.depthButton setTarget:self selector:@selector(depthClicked:)];
    
    self.greedyBestButton.position = ccp(searchCenter.x - self.depthButton.boundingBox.size.width, searchCenter.y - self.greedyBestButton.boundingBox.size.height);
    [self addChild:self.greedyBestButton];
    [self.greedyBestButton setTarget:self selector:@selector(greedyBestClicked:)];
    
    self.A1Button.position = ccp(searchCenter.x + self.depthButton.boundingBox.size.width, searchCenter.y - self.A1Button.boundingBox.size.height);
    [self addChild:self.A1Button];
    [self.A1Button setTarget:self selector:@selector(a1Clicked:)];
    
    self.A2Button.position = ccp(searchCenter.x - 10, searchCenter.y - self.A2Button.boundingBox.size.height * 2);
    [self addChild:self.A2Button];
    [self.A2Button setTarget:self selector:@selector(a2Clicked:)];
}

-(void) unspawnSearchButtons //REMOVES SEARCH BUTTONS FROM SCREEN
{
    [self removeChild:self.breadthButton];
    [self removeChild:self.depthButton];
    [self removeChild:self.greedyBestButton];
    [self removeChild:self.A1Button];
    [self removeChild:A2Button];
}

-(void) spawnInputTiles //SPAWNS INPUT TILES TO SCREEN AND WHAT TO DO WHEN CLICKED
{
    [self.oneButton getButton].position = ccp(inputCenter.x - [self.oneButton getButton].boundingBox.size.width, inputCenter.y + [self.oneButton getButton].boundingBox.size.width);
    [self addChild:[self.oneButton getButton]];
    [[self.oneButton getButton] setTarget:self selector:@selector(oneClicked:)];
    
    [self.twoButton getButton].position = ccp(inputCenter.x, inputCenter.y + [self.oneButton getButton].boundingBox.size.width);
    [self addChild:[self.twoButton getButton]];
    [[self.twoButton getButton] setTarget:self selector:@selector(twoClicked:)];
    
    [self.threeButton getButton].position = ccp(inputCenter.x + [self.oneButton getButton].boundingBox.size.width, inputCenter.y + [self.oneButton getButton].boundingBox.size.width);
    [self addChild:[self.threeButton getButton]];
    [[self.threeButton getButton] setTarget:self selector:@selector(threeClicked:)];
    
    [self.fourButton getButton].position = ccp(inputCenter.x + [self.oneButton getButton].boundingBox.size.width, inputCenter.y);
    [self addChild:[self.fourButton getButton]];
    [[self.fourButton getButton] setTarget:self selector:@selector(fourClicked:)];
    
    [self.zeroButton getButton].position = inputCenter;
    [self addChild:[self.zeroButton getButton]];
    [[self.zeroButton getButton] setTarget:self selector:@selector(zeroClicked:)];
    
    [self.eightButton getButton].position = ccp(inputCenter.x - [self.oneButton getButton].boundingBox.size.width, inputCenter.y);
    [self addChild:[self.eightButton getButton]];
    [[self.eightButton getButton] setTarget:self selector:@selector(eightClicked:)];
    
    [self.fiveButton getButton].position = ccp(inputCenter.x + [self.oneButton getButton].boundingBox.size.width, inputCenter.y - [self.oneButton getButton].boundingBox.size.width);
    [self addChild:[self.fiveButton getButton]];
    [[self.fiveButton getButton] setTarget:self selector:@selector(fiveClicked:)];
    
    [self.sixButton getButton].position = ccp(inputCenter.x, inputCenter.y - [self.oneButton getButton].boundingBox.size.width);
    [self addChild:[self.sixButton getButton]];
    [[self.sixButton getButton] setTarget:self selector:@selector(sixClicked:)];
    
    [self.sevenButton getButton].position = ccp(inputCenter.x - [self.oneButton getButton].boundingBox.size.width, inputCenter.y - [self.oneButton getButton].boundingBox.size.width);
    [self addChild:[self.sevenButton getButton]];
    [[self.sevenButton getButton] setTarget:self selector:@selector(sevenClicked:)];
}

//----- FUNCTIONS THAT EXECUTE WHEN A CERTAIN DIFFICULTY BUTTON IS CLICKED

-(void)easyClicked:(id)sender
{
    NSLog(@"EASY CLICKED");
    NSMutableArray *temp = [self.boardTypes getEasyArray];
    
    //deep copy array
    for (NSMutableArray *row in temp)
    {
        NSMutableArray *rowCopy = [NSMutableArray new];
        for (id item in row)
        {
            [rowCopy addObject:[item copy]];
        }
        [self.array addObject: rowCopy];
    }
    //
    
    [self.boardVisualizer newBoard:temp];
    [self.boardVisualizer visualizeBoard:boardCenter];
    [self unspawnDifficultyButtons];
    [self spawnSearchButtons];
}
-(void)mediumClicked:(id)sender
{
    NSLog(@"MEDIUM CLICKED");
    NSMutableArray *temp = [self.boardTypes getMediumArray];
    
    //deep copy array
    for (NSMutableArray *row in temp)
    {
        NSMutableArray *rowCopy = [NSMutableArray new];
        for (id item in row)
        {
            [rowCopy addObject:[item copy]];
        }
        [self.array addObject: rowCopy];
    }
    //
    
    [self.boardVisualizer newBoard:temp];
    [self.boardVisualizer visualizeBoard:boardCenter];
    [self unspawnDifficultyButtons];
    [self spawnSearchButtons];
}

-(void)hardClicked:(id)sender
{
    NSLog(@"HARD CLICKED");
    NSMutableArray *temp = [self.boardTypes getHardArray];
    
    //deep copy array
    for (NSMutableArray *row in temp)
    {
        NSMutableArray *rowCopy = [NSMutableArray new];
        for (id item in row)
        {
            [rowCopy addObject:[item copy]];
        }
        [self.array addObject: rowCopy];
    }
    //
    
    [self.boardVisualizer newBoard:temp];
    [self.boardVisualizer visualizeBoard:boardCenter];
    [self unspawnDifficultyButtons];
    [self spawnSearchButtons];
}

-(void)inputClicked:(id)sender
{
    NSLog(@"INPUT CLICKED");
    [self spawnInputTiles];
}

-(void) inputFinish
{
    [self.boardTypes newInputBoard:self.inputString];
    NSMutableArray *temp = [self.boardTypes getInputArray];
    
    //deep copy array
    for (NSMutableArray *row in temp)
    {
        NSMutableArray *rowCopy = [NSMutableArray new];
        for (id item in row)
        {
            [rowCopy addObject:[item copy]];
        }
        [self.array addObject: rowCopy];
    }
    //
    
    [self.boardVisualizer newBoard:[self.boardTypes getInputArray]];
    [self.boardVisualizer visualizeBoard:boardCenter];
    [self unspawnDifficultyButtons];
    [self spawnSearchButtons];
}

//----- FUNCTIONS THAT EXECUTE WHEN CERTAIN SEARCH BUTTONS ARE CLICKED
//----- THIS IS WHERE THE SEARCH FUNCTIONS ARE EXECUTED AND THEN PASS ON THE RESULT TO THE BOARD TO DO THE TILE MOVING ANIMATIONS

-(void)breadthClicked:(id)sender
{
    NSLog(@"BREADTH CLICKED");
    [self unspawnSearchButtons];
    Node *node = [[Node alloc] initNode:self.array board:0 depth:@""];
    
    NSLog(@"START NOW");
    NSString *str = [self.bFS breadthFirst:node]; //<----- BREADTH FIRST SEARCH
    NSLog(@"STOP NOW");
    
    NSLog(@"PATH: %@", str);
    [self.boardVisualizer visualizeSolution:str]; //<----- ANIMATION VISUALIZER
    [self spawnRestart];
    
    [self.stats setString:[NSString stringWithFormat:@"NUMBER OF MOVES = %lu\nMOVES: %@", (unsigned long)str.length, str]];
    self.stats.fontColor = [CCColor blackColor];
    [self addChild:self.stats];
}

-(void)depthClicked:(id)sender
{
    NSLog(@"DEPTH CLICKED");
    [self unspawnSearchButtons];
    Node *node = [[Node alloc] initNode:self.array board:0 depth:@""];
    
    NSLog(@"START NOW");
    NSString *str = [self.dFS depthFirst:node]; //<----- DEPTH FIRST SEARCH
    NSLog(@"STOP NOW");
    
    NSLog(@"PATH: %@", str);
    [self.boardVisualizer visualizeSolution:str]; //<----- ANIMATION VISUALIZER
    [self spawnRestart];
    
    [self.stats setString:[NSString stringWithFormat:@"NUMBER OF MOVES = %lu\nMOVES: %@", (unsigned long)str.length, str]];
    self.stats.fontColor = [CCColor whiteColor];
    [self addChild:self.stats];
}

-(void)greedyBestClicked:(id)sender
{
    NSLog(@"GREEDY BEST CLICKED");
    [self unspawnSearchButtons];
    Node *node = [[Node alloc] initNode:self.array board:0 depth:@""];
    
    NSLog(@"START NOW");
    NSString *str = [self.gBS greedyBestFirst:node]; //<----- GREEDY BEST FIRST SEARCH
    NSLog(@"STOP NOW");
    
    NSLog(@"PATH: %@", str);
    [self.boardVisualizer visualizeSolution:str]; //<----- ANIMATION VISUALIZER
    [self spawnRestart];
    
    [self.stats setString:[NSString stringWithFormat:@"NUMBER OF MOVES = %lu\nMOVES: %@", (unsigned long)str.length, str]];
    self.stats.fontColor = [CCColor whiteColor];
    [self addChild:self.stats];
}

-(void)a1Clicked:(id)sender
{
    NSLog(@"A*1 CLICKED");
    [self unspawnSearchButtons];
    Node *node = [[Node alloc] initNode:self.array board:0 depth:@""];
    
    NSLog(@"START NOW");
    NSString *str = [self.a1 a1Search:node]; //<----- A*1 FIRST SEARCH
    NSLog(@"STOP NOW");
    
    NSLog(@"PATH: %@", str);
    [self.boardVisualizer visualizeSolution:str]; //<----- ANIMATION VISUALIZER
    [self spawnRestart];
    
    [self.stats setString:[NSString stringWithFormat:@"NUMBER OF MOVES = %lu\nMOVES: %@", (unsigned long)str.length, str]];
    self.stats.fontColor = [CCColor whiteColor];
    [self addChild:self.stats];
}

-(void)a2Clicked:(id)sender
{
    NSLog(@"A*2 CLICKED");
    [self unspawnSearchButtons];
    Node *node = [[Node alloc] initNode:self.array board:0 depth:@""];
    
    NSLog(@"START NOW");
    NSString *str = [self.a2 a2Search:node]; //<----- A*2 FIRST SEARCH
    NSLog(@"STOP NOW");
    
    NSLog(@"PATH: %@", str);
    [self.boardVisualizer visualizeSolution:str]; //<----- ANIMATION VISUALIZER
    [self spawnRestart];
    
    [self.stats setString:[NSString stringWithFormat:@"NUMBER OF MOVES = %lu\nMOVES: %@", (unsigned long)str.length, str]];
    self.stats.fontColor = [CCColor whiteColor];
    [self addChild:self.stats];
}

//-----  FUNCTIONS THAT EXECUTE WHEN CERTAIN TILED NUMBER BUTTONS ARE CLICKED WHEN USER CLICKS "INPUT"

-(void)oneClicked:(id)sender
{
    [self.inputString addObject:[NSNumber numberWithInt:1]];
    [self removeChild:[self.oneButton getButton]];
    self.tilesClicked++;
    if (self.tilesClicked == 9)
    {
        [self inputFinish];
    }
}

-(void)twoClicked:(id)sender
{
    [self.inputString addObject:[NSNumber numberWithInt:2]];
    [self removeChild:[self.twoButton getButton]];
    self.tilesClicked++;
    if (self.tilesClicked == 9)
    {
        [self inputFinish];
    }
}

-(void)threeClicked:(id)sender
{
    [self.inputString addObject:[NSNumber numberWithInt:3]];
    [self removeChild:[self.threeButton getButton]];
    self.tilesClicked++;
    if (self.tilesClicked == 9)
    {
        [self inputFinish];
    }
}

-(void)eightClicked:(id)sender
{
    [self.inputString addObject:[NSNumber numberWithInt:8]];
    [self removeChild:[self.eightButton getButton]];
    self.tilesClicked++;
    if (self.tilesClicked == 9)
    {
        [self inputFinish];
    }
}

-(void)zeroClicked:(id)sender
{
    [self.inputString addObject:[NSNumber numberWithInt:0]];
    [self removeChild:[self.zeroButton getButton]];
    self.tilesClicked++;
    if (self.tilesClicked == 9)
    {
        [self inputFinish];
    }
}

-(void)fourClicked:(id)sender
{
    [self.inputString addObject:[NSNumber numberWithInt:4]];
    [self removeChild:[self.fourButton getButton]];
    self.tilesClicked++;
    if (self.tilesClicked == 9)
    {
        [self inputFinish];
    }
}

-(void)sevenClicked:(id)sender
{
    [self.inputString addObject:[NSNumber numberWithInt:7]];
    [self removeChild:[self.sevenButton getButton]];
    self.tilesClicked++;
    if (self.tilesClicked == 9)
    {
        [self inputFinish];
    }
}

-(void)sixClicked:(id)sender
{
    [self.inputString addObject:[NSNumber numberWithInt:6]];
    [self removeChild:[self.sixButton getButton]];
    self.tilesClicked++;
    if (self.tilesClicked == 9)
    {
        [self inputFinish];
    }
}

-(void)fiveClicked:(id)sender
{
    [self.inputString addObject:[NSNumber numberWithInt:5]];
    [self removeChild:[self.fiveButton getButton]];
    self.tilesClicked++;
    if (self.tilesClicked == 9)
    {
        [self inputFinish];
    }
}

//----- RESTART BUTTON FUNCTIONS

-(void) spawnRestart
{
    self.restartButton.position = ccp(screenWidth / 2, screenHeight - 50);
    [self addChild:self.restartButton];
    [self.restartButton setTarget:self selector:@selector(restartClicked:)];
}

-(void) unspawnRestart
{
    [self removeChild:self.restartButton];
}

-(void) restartClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[Program loadProgram]];
}

@end