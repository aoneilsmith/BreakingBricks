//
//  StartMenu.m
//  BreakingBricks
//
//  Created by Andrew O'Neil-Smith on 5/1/14.
//  Copyright (c) 2014 Andrew O'Neil-Smith. All rights reserved.
//

#import "StartMenu.h"
#import "MyScene.h"
#import "SettingsMenu.h"

@implementation StartMenu

-(instancetype)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        
        self.backgroundColor = [SKColor blackColor];
        
        SKAction *play = [SKAction playSoundFileNamed:@"sbstartup3.wav" waitForCompletion:YES];
        [self runAction:play];
        
        SKLabelNode  *label = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        label.text = @"The Best Game Ever";
        label.fontColor = [SKColor whiteColor ];
        label.fontSize = 32;
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:label];
        // [self runAction:_gameOverSFX];
        NSLog(@"touched bottom");
        
        //second label
        SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"fixedsys"];
        tryAgain.text = @"speak 'Start Game' to start";
        tryAgain.fontColor = [SKColor whiteColor];
        tryAgain.fontSize = 22;
        tryAgain.position = CGPointMake(size.width/2, CGRectGetMidY(self.frame)-30);
        
        SKLabelNode *justKidding = [SKLabelNode labelNodeWithFontNamed:@"fixedsys"];
        justKidding.text = @"Just kidding, tap these words, loser!";
        justKidding.fontColor = [SKColor whiteColor];
        justKidding.name   = @"justKidding";
        justKidding.fontSize = 16;
        justKidding.position = CGPointMake(size.width/2, -120);
        
        
        SKAction *moveLabel = [SKAction moveToY:(size.height/2 - 80) duration:6.0];
        SKAction *wait = [SKAction waitForDuration:3.0];
        SKAction *sequence = [SKAction sequence:@[wait,moveLabel]];
        [justKidding runAction:sequence];
        
        [self addChild:tryAgain];
        [self addChild:justKidding];
        
        SKLabelNode *settings = [SKLabelNode labelNodeWithFontNamed:@"Futura"];
        settings.text = @"settings";
        settings.name = @"settings";
        settings.fontColor = [SKColor whiteColor];
        settings.fontSize = 22;
        settings.position = CGPointMake(size.width/2 +100 , CGRectGetMidY(self.frame)-200);
        [self addChild:settings];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"justKidding"])  {
        MyScene *firstScene = [MyScene sceneWithSize:self.size];
        [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    }
    if([node.name isEqualToString:@"settings"])  {
        SettingsMenu *settingsScene = [SettingsMenu sceneWithSize:self.size];
        [self.view presentScene:settingsScene transition:[SKTransition flipVerticalWithDuration:1.5]];
    }
    
}

@end
