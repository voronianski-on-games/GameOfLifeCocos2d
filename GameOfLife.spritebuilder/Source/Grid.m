//
//  Grid.m
//  GameOfLife
//
//  Created by Dmitri Voronianski on 04.06.14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

static const NSInteger GRID_ROWS = 8;
static const NSInteger GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    CGFloat _cellWidth;
    CGFloat _cellHeight;
}

- (void)onEnter
{
    [super onEnter];
    
    [self setupGrid];
    [self setUserInteractionEnabled:YES];
}

- (void)setupGrid
{
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    CGFloat posX = 0;
    CGFloat posY = 0;
    
    _gridArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < GRID_ROWS; i++) {
        _gridArray[i] = [NSMutableArray array];
        
        posX = 0; // start of every row
        
        for (NSInteger j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            [creature setAnchorPoint:ccp(0, 0)];
            [creature setPosition:ccp(posX, posY)];
            [self addChild:creature];
            
            _gridArray[i][j] = creature;
            
            posX += _cellWidth;
        }
        
        posY += _cellHeight;
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    [creature setIsAlive:!creature.isAlive];
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    NSInteger column = touchPosition.x / _cellWidth;
    NSInteger row = touchPosition.y / _cellHeight;
    Creature *creature = _gridArray[row][column];
    
    return creature;
}

#pragma mark - Rules

/*
 * GAME OF LIFE RULES
 *
 * If it has 0-1 live neighbors the Creature on that cell dies or stays dead. 
 * If it has 2-3 live neighbors it stays alive. 
 * If it has 4 or more, it stays dead or dies. 
 * If it has exactly 3 neighbors and it is dead, it comes to life!
 */

- (void)evolveStep
{
    [self countNeighbors];
    [self updateCreatures];
    _generation++;
}

- (void)countNeighbors
{
    for (NSInteger i = 0; i < [_gridArray count]; i++) {
        for (NSInteger j = 0; j < [_gridArray[i] count]; j++) {
            Creature *currentCreature = _gridArray[i][j];
            currentCreature.livingNeighbours = 0;
            
            for (NSInteger x = (i-1); x <= (i+1); x++) {
                for (NSInteger y = (j-1); y <= (j+1); y++) {
                    BOOL isIndexValid = [self isIndexValidForX:x andY:y];
                    if (isIndexValid && !((x == i) && (y == j))) {
                        Creature *neighbour = _gridArray[x][y];
                        if (neighbour.isAlive) {
                            currentCreature.livingNeighbours += 1;
                        }
                    }
                }
            }
        }
    }
}

- (void)updateCreatures
{
    NSInteger aliveNum = 0;
    
    for (NSInteger i = 0; i < [_gridArray count]; i++) {
        for (NSInteger j = 0; j < [_gridArray[i] count]; j++) {
            Creature *currentCreature = _gridArray[i][j];
            
            if (currentCreature.livingNeighbours == 3) {
                [currentCreature setIsAlive:YES];
            } else if (currentCreature.livingNeighbours <= 1 ||
                       currentCreature.livingNeighbours >= 4) {
                [currentCreature setIsAlive:NO];
            }
            
            if (currentCreature.isAlive) {
                aliveNum++;
            }
        }
    }
    
    [self setTotalAlive:aliveNum];
}

#pragma mark - Util

- (BOOL)isIndexValidForX:(NSInteger)x andY:(NSInteger)y
{
    
    return (x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS) ? NO : YES;
}

@end
