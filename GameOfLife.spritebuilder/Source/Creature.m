//
//  Creature.m
//  GameOfLife
//
//  Created by Dmitri Voronianski on 04.06.14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

- (instancetype)initCreature
{
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
    }
    
    return self;
}

- (void)setIsAlive:(BOOL)isAlive
{
    _isAlive = isAlive;
    self.visible = _isAlive;
}

@end
