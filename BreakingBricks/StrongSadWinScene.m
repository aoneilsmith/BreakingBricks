//
//  StrongSadWinScene.m
//  BreakingBricks
//
//  Created by Andrew O'Neil-Smith on 5/1/14.
//  Copyright (c) 2014 Andrew O'Neil-Smith. All rights reserved.
//

#import "StrongSadWinScene.h"
#import "HomestarGameScene.h"

@implementation StrongSadWinScene


-(instancetype)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        
        self.backgroundColor = [SKColor blackColor];
        
        SKAction *play = [SKAction playSoundFileNamed:@"sb_pizza.mp3" waitForCompletion:YES];
        [self runAction:play];
        
        SKLabelNode  *label = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
        label.text = @"you win...";
        label.fontColor = [SKColor whiteColor ];
        label.fontSize = 44;
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:label];
        // [self runAction:_gameOverSFX];
        NSLog(@"touched bottom");
        
        //second label
        SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
        tryAgain.text = @"tap to leave this level";
        tryAgain.fontColor = [SKColor whiteColor];
        tryAgain.fontSize = 24;
        tryAgain.position = CGPointMake(size.width/2, -40);
        
        SKAction *moveLabel = [SKAction moveToY:(size.height/2 - 40) duration:2.0];
        [tryAgain runAction:moveLabel];
        
        [self addChild:tryAgain];
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    HomestarGameScene *firstScene = [HomestarGameScene sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    
}

@end
