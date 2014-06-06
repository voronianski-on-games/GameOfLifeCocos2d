//
//  Grid.h
//  GameOfLife
//
//  Created by Dmitri Voronianski on 04.06.14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite

@property (nonatomic) NSInteger totalAlive;
@property (nonatomic) NSInteger generation;

- (void)evolveStep;

@end
