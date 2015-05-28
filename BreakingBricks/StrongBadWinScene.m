//
//  StrongBadWinScene.m
//  BreakingBricks
//
//  Created by Andrew O'Neil-Smith on 4/14/14.
//  Copyright (c) 2014 Andrew O'Neil-Smith. All rights reserved.
//

#import "StrongBadWinScene.h"
#import "StrongSadGameScene.h"

@implementation StrongBadWinScene

-(instancetype)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        
        self.backgroundColor = [SKColor blackColor];
        
        SKAction *play = [SKAction playSoundFileNamed:@"sb_pizza.mp3" waitForCompletion:YES];
        [self runAction:play];
        
        SKLabelNode  *label = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        label.text = @"LEVEL BEATEN!!";
        label.fontColor = [SKColor whiteColor ];
        label.fontSize = 42;
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:label];
       // [self runAction:_gameOverSFX];
        NSLog(@"touched bottom");
        
        //second label
        SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        tryAgain.text = @"touch me right here to go to the next level, baby";
        tryAgain.name = @"tryAgain";//how we will identify
        tryAgain.fontColor = [SKColor whiteColor];
        tryAgain.fontSize = 14;
        tryAgain.position = CGPointMake(size.width/2, -40);
        
        SKAction *moveLabel = [SKAction moveToY:(size.height/2 - 40) duration:2.0];
        [tryAgain runAction:moveLabel];
        
        [self addChild:tryAgain];
        
        SKSpriteNode *saveNode = [SKSpriteNode spriteNodeWithImageNamed:@"HomestarRunner-folder converted.png"];
        saveNode.position = CGPointMake(self.size.width/2, self.size.height/2 - 200);
        saveNode.name = @"saveButtonNode";//how we will identify
        saveNode.zPosition = 1.0;
        [self addChild:saveNode];
        
        SKLabelNode *saveLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        saveLabel.text = @"click icon to save progress";
        saveLabel.name = @"saveLabel";//how we will identify
        saveLabel.fontColor = [SKColor whiteColor];
        saveLabel.fontSize = 18;
        saveLabel.position = CGPointMake(size.width/2, 80);
        [self addChild:saveLabel];
        
    }
    return self;
}
-(SKSpriteNode *)saveButtonNode{
    return nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"tryAgain"])  {
    StrongSadGameScene *firstScene = [StrongSadGameScene sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    }
    if([node.name isEqualToString:@"saveButtonNode"])  {
        SKAction *play = [SKAction playSoundFileNamed:@"trash_sb.wav" waitForCompletion:YES];
        [self runAction:play];
    }
}

@end
