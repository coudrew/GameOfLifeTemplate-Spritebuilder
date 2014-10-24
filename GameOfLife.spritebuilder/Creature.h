//
//  Creature.h
//  GameOfLife
//
//  Created by Andrew R Couture on 2014-10-23.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

// stores current state of the creature
@property (nonatomic, assign) BOOL isAlive;

// stores amount of living neighbors
@property (nonatomic, assign) NSInteger livingNeighbors;

-(id)initCreature;

@end
