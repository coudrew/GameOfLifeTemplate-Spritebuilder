//
//  Grid.m
//  GameOfLife
//
//  Created by Andrew R Couture on 2014-10-23.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}
- (void)onEnter
{
    [super onEnter];
    [self setupGrid];
    
    self.userInteractionEnabled = YES;
}

- (void)setupGrid
{
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0.0;
    float y = 0.0;
    
    // initialize array as blank NSMutableArray
    _gridArray = [NSMutableArray array];
    // initialize creatures
    for (int i = 0; i < GRID_ROWS; i++) {
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        for (int j = 0; j <GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            
            _gridArray[i][j] = creature;
            
            x+=_cellWidth;
        }
        y+=_cellHeight;
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //get xy coord of touch
    CGPoint touchLocation = [touch locationInNode:self];
    //get creature at that location
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    creature.isAlive = !creature.isAlive;
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    int row = touchPosition.y / _cellHeight;
    int column = touchPosition.x / _cellWidth;
    
    return _gridArray[row][column];
}

- (void)evolveStep
{
    //update each Creature neighbor count
    [self countNeighbors];
    //update each Creature state
    [self updateCreatures];
    //update generation label
    _generation++;
}

- (void)countNeighbors
{
    //iterate through rows
    for (int i = 0; i < [_gridArray count]; i++)
    {
        //iterate through all columns of given row
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            //access creatur in cell at current row/column
            Creature *currentCreature = _gridArray[i][j];
            currentCreature.livingNeighbors = 0;
            //examine neighbor cells
            //go through rows
            for (int x = (i-1); x <= (i+1); x++)
            {
                //go through columns
                for (int y = (j-1); y <= (j+1); y++)
                {
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    //skip offscreen and center cell
                    if (!((x==i) && (y==j)) && isIndexValid)
                    {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive)
                            {
                                currentCreature.livingNeighbors +=1;
                            }
                    }
                    
                }
                
            }
        }
    }
}

- (BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if (x < 0 || y < 0 || x>= GRID_ROWS || y >= GRID_COLUMNS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

- (void)updateCreatures
{
    for (int i = 0; i < [_gridArray count]; i++)
    {
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            if (currentCreature.livingNeighbors == 3) {
                currentCreature.isAlive = TRUE;
            }
            else if ((currentCreature.livingNeighbors <= 1)||(currentCreature.livingNeighbors >= 4)) {
                currentCreature.isAlive = FALSE;
            }
        }
    }
}

@end
