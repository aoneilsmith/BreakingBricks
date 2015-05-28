//
//  SettingsMenu.m
//  BreakingBricks
//
//  Created by Andrew O'Neil-Smith on 5/1/14.
//  Copyright (c) 2014 Andrew O'Neil-Smith. All rights reserved.
//

#import "SettingsMenu.h"
#import "StartMenu.h"

@implementation SettingsMenu

-(instancetype)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        
        self.backgroundColor = [SKColor blackColor];
        
        SKAction *play = [SKAction playSoundFileNamed:@"sbstartup3.wav" waitForCompletion:YES];
        [self runAction:play];
        
        SKLabelNode  *label = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        label.text = @"There are no settings!";
        label.fontColor = [SKColor whiteColor ];
        label.fontSize = 32;
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:label];
        // [self runAction:_gameOverSFX];
        NSLog(@"touched bottom");
        
        //second label
        SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"fixedsys"];
        tryAgain.text = @"y u want 2 change perfect game??";
        tryAgain.fontColor = [SKColor whiteColor];
        tryAgain.fontSize = 18;
        tryAgain.position = CGPointMake(size.width/2, CGRectGetMidY(self.frame)-30);
        
        [self addChild:tryAgain];
 
        
        SKLabelNode *settings = [SKLabelNode labelNodeWithFontNamed:@"Futura"];
        settings.text = @"back";
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
    

    if([node.name isEqualToString:@"settings"])  {
        StartMenu *firstScene = [StartMenu sceneWithSize:self.size];
        [self.view presentScene:firstScene transition:[SKTransition flipVerticalWithDuration:1.0]];
    }
    
}


@end
