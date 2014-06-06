//
//  Creature.h
//  GameOfLife
//
//  Created by Dmitri Voronianski on 04.06.14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

@property (nonatomic) BOOL isAlive;
@property (nonatomic) NSInteger livingNeighbours;

- (instancetype)initCreature;

@end
