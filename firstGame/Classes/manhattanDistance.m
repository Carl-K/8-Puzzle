//
//  manhattanDistance.m
//  firstGame
//
//  Created by Carl Kruk on 1/25/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "manhattanDistance.h"

@implementation manhattanDistance
@synthesize zero, one, two, three, four, five, six, seven, eight;

-(id) initManhattanDistance
{
    self.zero = CGPointMake(1, 1);
    self.one = CGPointMake(0, 0);
    self.two = CGPointMake(0, 1);
    self.three = CGPointMake(0, 2);
    self.four = CGPointMake(1, 2);
    self.five = CGPointMake(2, 2);
    self.six = CGPointMake(2, 1);
    self.seven = CGPointMake(2, 0);
    self.eight = CGPointMake(1, 0);
    
    return self;
}

-(int) computeDistance:(CGPoint)p point:(int) n //COMPUTES MANHATTAN VALUE FOR CERTAIN TILE, WHOLE BOARD COMPUTED IN NODE CLASS
{
    if (n == 0)
    {
        return abs(p.x - self.zero.x) + abs(p.y - self.zero.y);
    }
    else if (n == 1)
    {
        return abs(p.x - self.one.x) + abs(p.y - self.one.y);
    }
    else if (n == 2)
    {
        return abs(p.x - self.two.x) + abs(p.y - self.two.y);
    }
    else if (n == 3)
    {
        return abs(p.x - self.three.x) + abs(p.y - self.three.y);
    }
    else if (n == 4)
    {
        return abs(p.x - self.four.x) + abs(p.y - self.four.y);
    }
    else if (n == 5)
    {
        return abs(p.x - self.five.x) + abs(p.y - self.five.y);
    }
    else if (n == 6)
    {
        return abs(p.x - self.six.x) + abs(p.y - self.six.y);
    }
    else if (n == 7)
    {
        return abs(p.x - self.seven.x) + abs(p.y - self.seven.y);
    }
    else
    {
        return abs(p.x - self.eight.x) + abs(p.y - self.eight.y);
    }
}

-(int) computeMisplacedTiles:(CGPoint)p point:(int)n //IF TILE MISPLACES RETURN INT 1 ELSE RETURN INT 0 FOR CERTAIN TILE, WHOLE BOARD COMPUTED IN NODE CLASS
{
    if (n == 0 && p.x != 1 && p.y != 1 )
    {
        return 1;
    }
    else if (n == 1 && p.x != 0 && p.y != 0 )
    {
        return 1;
    }
    else if (n == 2 && p.x != 0 && p.y != 1 )
    {
        return 1;
    }
    else if (n == 3 && p.x != 0 && p.y != 2 )
    {
        return 1;
    }
    else if (n == 4 && p.x != 1 && p.y != 2 )
    {
        return 1;
    }
    else if (n == 5 && p.x != 2 && p.y != 2 )
    {
        return 1;
    }
    else if (n == 6 && p.x != 2 && p.y != 1 )
    {
        return 1;
    }
    else if (n == 7 && p.x != 2 && p.y != 0 )
    {
        return 1;
    }
    else if (n == 8 && p.x != 1 && p.y != 0 )
    {
        return 1;
    }
    return 0;
}

@end