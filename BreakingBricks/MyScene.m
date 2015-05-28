//
//  MyScene.m
//  BreakingBricks
//
//  Created by Andrew O'Neil-Smith on 3/29/14.
//  Copyright (c) 2014 Andrew O'Neil-Smith. All rights reserved.
//

#import "MyScene.h"
#import "EndScene.h"
#import "StrongBadWinScene.h"

@interface MyScene() {
    
    SKLabelNode *_scoreLabel;
    NSUInteger _score;

}

@property (nonatomic) SKSpriteNode *paddle;
@property (strong, nonatomic) SKAction *blipSFX;
@property (strong, nonatomic) SKAction *brickSFX;
@property (strong, nonatomic) SKAction *bgMusic;
@property (strong, nonatomic) SKAction *winSFX;
@property (strong, nonatomic) SKAction *gameOverSFX;
@property (strong,nonatomic) AVAudioPlayer *audioPlayer;



@end




static const uint32_t ballCategory      = 1; //000...00001
static const uint32_t brickCategory     = 2; //0x1 << 1
static const uint32_t paddleCategory    = 4;
static const uint32_t edgeCategory      = 8;
static const uint32_t bottomEdgeCategory      = 16;

@implementation MyScene

-(void)didBeginContact:(SKPhysicsContact *)contact {
    //NSLog(@"boing!");
//    if (contact.bodyA.categoryBitMask == brickCategory) {
//        NSLog(@"bodyA is a brick");
//        [contact.bodyA.node removeFromParent];
//    }
//    
//    if (contact.bodyB.categoryBitMask == brickCategory) {
//        NSLog(@"bodyB is a brick");
//        [contact.bodyB.node removeFromParent];
//    }
    
    //create placeholder reference for non ball
    SKPhysicsBody *notTheBall;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        notTheBall = contact.bodyB;
    } else {
        notTheBall = contact.bodyA;
    }
    
    if (notTheBall.categoryBitMask == brickCategory) {
 
        [self runAction:_brickSFX];
        [notTheBall.node removeFromParent];
        
        ++_score;
        _scoreLabel.text = [NSString stringWithFormat:@"Scores: %d", _score];
        
        if(_score==4){
            //[self runAction:_winSFX];
            //go to transition scene where strongbad will congratulate you
            StrongBadWinScene *sbWinScene = [StrongBadWinScene sceneWithSize:self.size];
            [self.view presentScene:sbWinScene transition:[SKTransition doorwayWithDuration:0.5]];
        }
        
        
        }
    
    if (notTheBall.categoryBitMask == paddleCategory) {
        [self runAction:_blipSFX];
    }
    /* if number of bricks = 0, go to win screen
    if (notTheBall.categoryBitMask == brickCategory) {
        //[self.audioPlayer stop];
        [self runAction:_winSFX];
    }
    */
    if (notTheBall.categoryBitMask == bottomEdgeCategory){
        
        //SKAction *play = [SKAction playSoundFileNamed:@"sbmin.wav" waitForCompletion:YES];
        //self runAction:play];
        [self runAction:_gameOverSFX];

        EndScene *end = [EndScene sceneWithSize:self.size];
        [self.view presentScene:end transition:[SKTransition doorsCloseHorizontalWithDuration:0.5]];
        
        
    }
    
}

-(void)addBottomEdge:(CGSize) size {
    
    SKNode *bottomEdge = [SKNode node];
    bottomEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 1) toPoint:CGPointMake(size.width, 1)];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    [self addChild:bottomEdge];
    
}

- (void)addBall:(CGSize)size {
    //sprite
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"strongbad-head-aqua"];
    //set position
    CGPoint myPoint = CGPointMake(size.width/2, size.height/2);
    ball.position = myPoint;
    //physics
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:(ball.size.width/2)];
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1.0;
    ball.physicsBody.categoryBitMask = ballCategory;
    ball.physicsBody.contactTestBitMask = brickCategory | paddleCategory | bottomEdgeCategory;
    //ball.physicsBody.collisionBitMask = edgeCategory | brickCategory; //troll game
    
    
    //add to scene
    [self addChild:ball];
    
    //create ball vector
    CGVector myVector = CGVectorMake(-2, -20);
    //apply to the phsics body of sprite
    [ball.physicsBody applyImpulse:myVector];
}

-(void)addPlayer:(CGSize)size{

    self.paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    self.paddle.position = CGPointMake(self.size.width/2, 100);
    self.paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.paddle.frame.size];
    
    self.paddle.physicsBody.dynamic = NO;
    self.paddle.physicsBody.categoryBitMask = paddleCategory;
    
    [self addChild:self.paddle];
    
    
    
}
-(void)addBricks:(CGSize)size{
    for(int i = 0; i<4; i++){
        SKSpriteNode *brick = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        
        brick.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brick.frame.size];
        brick.physicsBody.dynamic = NO;
        brick.physicsBody.categoryBitMask = brickCategory;
        
        int xpos = size.width/5 * (i+1);
        int ypos = size.height - 50;
        brick.position = CGPointMake(xpos, ypos);
        
        [self addChild:brick];
    }

    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    for (UITouch *touch in touches) {
        CGPoint location= [touch locationInNode:self];
        CGPoint newposition = CGPointMake(location.x, 100);

        //limit the left/right position
        if(newposition.x < self.paddle.size.width/2)
            newposition.x = self.paddle.size.width/2;
        if(newposition.x > self.size.width - (self.paddle.size.width/2))
            newposition.x = self.size.width - (self.paddle.size.width/2) ;
        
            self.paddle.position = newposition;
    }

}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        //scene background
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"sbmonitor1.png"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+25);
        [self addChild:background];
      //  self.backgroundColor = [SKColor colorWithPatternImage:[UIImage imageNamed:@"sbmonitor1.png"]];
        //self.backgroundColor = [SKColor whiteColor];
        //scene physics
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = edgeCategory;
        
        //change gravity settings
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        self.physicsWorld.contactDelegate = self;
        
        // add a score label to our scene
        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura"];
        _scoreLabel.text = @"Scores: 0";
        _scoreLabel.fontColor = [UIColor whiteColor];
        _scoreLabel.fontSize = 24.0f;
        _scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _scoreLabel.position = CGPointMake(10, 10);
        [self.scene addChild:_scoreLabel];
        
        [self addBall:size];
        [self addPlayer:size];
        [self addBricks:size];
        [self addBottomEdge:size];
        
        self.brickSFX = [SKAction playSoundFileNamed:@"sb_dubdeuce_1.mp3" waitForCompletion:NO];
        self.blipSFX = [SKAction playSoundFileNamed:@"sbmax.wav" waitForCompletion:NO];
        self.winSFX = [SKAction playSoundFileNamed:@"sb_pizza.mp3" waitForCompletion:YES];
        self.gameOverSFX = [SKAction playSoundFileNamed:@"sbmin.wav" waitForCompletion:YES];



        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/The System is Down.mp3", [[NSBundle mainBundle] resourcePath]]];
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        self.audioPlayer.numberOfLoops = -1;
        
        if(!self.audioPlayer)
            NSLog(@"error");//[error localizedDescription]);
        else
            [self.audioPlayer play];
    
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
