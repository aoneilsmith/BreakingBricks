//
//  SSEndScene.m
//  BreakingBricks
//
//  Created by Andrew O'Neil-Smith on 4/17/14.
//  Copyright (c) 2014 Andrew O'Neil-Smith. All rights reserved.
//

#import "SSEndScene.h"
#import "SSEndScene.h"
#import "MyScene.h"

@implementation SSEndScene

-(instancetype)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        
        self.backgroundColor = [SKColor blackColor];
        
        SKLabelNode  *label = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        label.text = @"GAME OVER";
        label.fontColor = [SKColor whiteColor ];
        label.fontSize = 44;
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:label];
        
        SKAction *play = [SKAction playSoundFileNamed:@"ss_frustrating.mp3" waitForCompletion:YES];
        [self runAction:play];
        
        //[self runAction:_gameOverSFX];
        NSLog(@"touched bottom");
        
        //second label
        SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"fixedsys"];
        tryAgain.text = @"tap to play again";
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
    MyScene *firstScene = [MyScene sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    
}

@end
