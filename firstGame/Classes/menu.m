//
//  menu.m
//  firstGame
//
//  Created by Carl Kruk on 1/17/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "menu.h"
#import "mainProgram.h"

#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

@implementation menu
@synthesize runEasy, runMedium, runHard, runInput, breadthFirst, depthFirst, greedyBest_First, twoA, fontName, fontSize, fontColor, back, level, search;

+(menu *) loadMenu
{
    return [[self alloc] initMenu];
}

-(id) initMenu
{
    self = [super init];
    if(!self) return(nil);
    
    [self addChild:[CCNodeColor nodeWithColor:[CCColor colorWithRed:1.0f green:0.0f blue:1.0f alpha:1.0f]]];
    
    self.fontName = @"Helvetica";
    self.fontSize = 18.0f;
    self.fontColor = [CCColor blackColor];
    
    self.level = @"";
    self.search = @"";
    
    [self addFirstSet];
    
    return self;
}

-(void) mainProgramClicked
{
    [[CCDirector sharedDirector] replaceScene:[mainProgram loadMainProgram:self.level level:self.search]];
    CCLOG(@"Scene changed to mainProgram");
}

-(void) removeFirstSet
{
    [self removeChild:self.runEasy];
    [self removeChild:self.runMedium];
    [self removeChild:self.runHard];
    [self removeChild:self.runInput];
}

-(void) removeSecondSet
{
    [self removeChild:self.breadthFirst];
    [self removeChild:self.depthFirst];
    [self removeChild:self.greedyBest_First];
    [self removeChild:self.twoA];
}

-(void) addFirstSet
{
    self.runEasy = [CCButton buttonWithTitle:@"run the easy problem" fontName:self.fontName fontSize:self.fontSize];
    self.runEasy.position = ccp(screenWidth/2, screenHeight/2 + self.runEasy.boundingBox.size.height);
    self.runEasy.color = self.fontColor;
    [self addChild:self.runEasy];
    [self.runEasy setTarget:self selector:@selector(easyClicked:)];
    
    self.runMedium = [CCButton buttonWithTitle:@"run the medium problem" fontName:self.fontName fontSize:self.fontSize];
    self.runMedium.position = ccp(screenWidth/2, screenHeight/2 + (self.runMedium.boundingBox.size.height / 2));
    self.runMedium.color = self.fontColor;
    [self addChild:self.runMedium];
    [self.runMedium setTarget:self selector:@selector(mediumClicked:)];
    
    self.runHard = [CCButton buttonWithTitle:@"run the hard problem" fontName:self.fontName fontSize:self.fontSize];
    self.runHard.position = ccp(screenWidth/2, screenHeight/2);
    self.runHard.color = self.fontColor;
    [self addChild:self.runHard];
    [self.runHard setTarget:self selector:@selector(hardClicked:)];
    
    self.runInput = [CCButton buttonWithTitle:@"input a new problem" fontName:self.fontName fontSize:self.fontSize];
    self.runInput.position = ccp(screenWidth/2, screenHeight/2 - (self.runInput.boundingBox.size.height/2));
    self.runInput.color = self.fontColor;
    [self addChild:self.runInput];
    [self.runInput setTarget:self selector:@selector(inputClicked:)];
}

-(void) easyClicked:(id)sender
{
    self.level = @"easy";
    [self removeFirstSet];
    [self addSecondSet];
}

-(void) mediumClicked:(id)sender
{
    self.level = @"medium";
    [self removeFirstSet];
    [self addSecondSet];
}

-(void) hardClicked:(id)sender
{
    self.level = @"hard";
    [self removeFirstSet];
    [self addSecondSet];
}

-(void) inputClicked:(id)sender
{
    self.level = @"input";
    [self removeFirstSet];
    [self addSecondSet];
}

-(void) addSecondSet
{
    self.breadthFirst = [CCButton buttonWithTitle:@"breadth first" fontName:self.fontName fontSize:self.fontSize];
    self.breadthFirst.position = ccp(screenWidth/2, screenHeight/2 + self.breadthFirst.boundingBox.size.height);
    self.breadthFirst.color = self.fontColor;
    [self addChild:self.breadthFirst];
    [self.breadthFirst setTarget:self selector:@selector(breadthClicked:)];
    
    self.depthFirst = [CCButton buttonWithTitle:@"depth first" fontName:self.fontName fontSize:self.fontSize];
    self.depthFirst.position = ccp(screenWidth/2, screenHeight/2 + (self.depthFirst.boundingBox.size.height/2));
    self.depthFirst.color = self.fontColor;
    [self addChild:self.depthFirst];
    [self.depthFirst setTarget:self selector:@selector(depthClicked:)];
    
    self.greedyBest_First = [CCButton buttonWithTitle:@"greedy best-first" fontName:self.fontName fontSize:self.fontSize];
    self.greedyBest_First.position = ccp(screenWidth/2, screenHeight/2);
    self.greedyBest_First.color = self.fontColor;
    [self addChild:self.greedyBest_First];
    [self.greedyBest_First setTarget:self selector:@selector(greedyClicked:)];
    
    self.twoA = [CCButton buttonWithTitle:@"two A*" fontName:self.fontName fontSize:self.fontSize];
    self.twoA.position = ccp(screenWidth/2, screenHeight/2 - (self.twoA.boundingBox.size.height/2));
    self.twoA.color = self.fontColor;
    [self addChild:self.twoA];
    [self.twoA setTarget:self selector:@selector(twoAClicked:)];
    
    self.back = [CCButton buttonWithTitle:@"back" fontName:self.fontName fontSize:self.fontSize];
    self.back.position = ccp(screenWidth/2, screenHeight/2 - self.back.boundingBox.size.height);
    self.back.color = self.fontColor;
    [self addChild:self.back];
    [self.back setTarget:self selector:@selector(backClicked:)];
    
    NSLog(@"%@", self.level);
}

-(void) breadthClicked:(id)sender
{
    self.search = @"breadth";
    [self mainProgramClicked];
}

-(void) depthClicked:(id)sender
{
    self.search = @"depth";
    [self mainProgramClicked];
}

-(void) greedyClicked:(id)sender
{
    self.search = @"greedy";
    [self mainProgramClicked];
}

-(void) twoAClicked:(id)sender
{
    self.search = @"twoA";
    [self mainProgramClicked];
}

-(void) backClicked:(id)sender
{
    [self removeSecondSet];
    [self addFirstSet];
}

@end
