//
//  EndScene.m
//  BreakingBricks
//
//  Created by Andrew O'Neil-Smith on 3/31/14.
//  Copyright (c) 2014 Andrew O'Neil-Smith. All rights reserved.
//

#import "EndScene.h"
#import "MyScene.h"


@implementation EndScene
/*
@synthesize itemName, serialNumber, dateCreated, valueInDollars;


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:itemName forKey:@"itemName"];
    [aCoder encodeObject:serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:imageKey forKey:@"imageKey"];
    
    [aCoder encodeInt:valueInDollars forKey:@"valueInDollars"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setItemName:[aDecoder decodeObjectForKey:@"itemName"]];
        [self setSerialNumber:[aDecoder decodeObjectForKey:@"serialNumber"]];
        [self setImageKey:[aDecoder decodeObjectForKey:@"imageKey"]];
        
        [self setValueInDollars:[aDecoder decodeIntForKey:@"valueInDollars"]];
        
        dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
    }
    return self;
}
*/
-(instancetype)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        
        self.backgroundColor = [SKColor blackColor];
        
        
        SKAction *play = [SKAction playSoundFileNamed:@"sbmin.wav" waitForCompletion:YES];
        [self runAction:play];
        
        SKLabelNode  *label = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        label.text = @"GAME OVER";
        label.fontColor = [SKColor whiteColor ];
        label.fontSize = 44;
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:label];
        //[self runAction:_gameOverSFX];
        NSLog(@"touched bottom");
        
        //second label
        SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"fixedsys"];
        tryAgain.text = @"tap to play again... ";
        tryAgain.fontColor = [SKColor whiteColor];
        tryAgain.fontSize = 18;
        tryAgain.position = CGPointMake(size.width/2 -30, -40);
        
        //second label
        SKLabelNode *tryAgainLoser = [SKLabelNode labelNodeWithFontNamed:@"fixedsys"];
        tryAgainLoser.text = @"loser!";
        tryAgainLoser.fontColor = [SKColor whiteColor];
        tryAgainLoser.fontSize = 24;
        tryAgainLoser.position = CGPointMake(size.width/2+100, -40);
        
        SKAction *moveLabel = [SKAction moveToY:(size.height/2 - 40) duration:2.0];
        [tryAgain runAction:moveLabel];
        [tryAgainLoser runAction:moveLabel];
        
        [self addChild:tryAgain];
        [self addChild:tryAgainLoser];
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    MyScene *firstScene = [MyScene sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    
}

@end
