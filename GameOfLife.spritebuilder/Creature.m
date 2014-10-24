//
//  Creature.m
//  GameOfLife
//
//  Created by Andrew R Couture on 2014-10-23.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

- (instancetype)initCreature {
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];

    if (self) {
        self.isAlive = NO;
    }
return self;
    
}

- (void)setIsAlive:(BOOL)newState {
    _isAlive = newState;
    self.visible = _isAlive;
}
@end
