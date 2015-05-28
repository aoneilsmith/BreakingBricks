//
//  ViewController.m
//  BreakingBricks
//
//  Created by Andrew O'Neil-Smith on 3/29/14.
//  Copyright (c) 2014 Andrew O'Neil-Smith. All rights reserved.
//


#import "ViewController.h"
#import "StartMenu.h"

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    //this code ran away to the method below
}
-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    if(!skView.scene){
           // Create and configure the scene.
    SKScene * scene = [StartMenu sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    /*
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/The System is Down.mp3", [[NSBundle mainBundle] resourcePath]]];
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        self.audioPlayer.numberOfLoops = -1;
        
        if(!self.audioPlayer)
            NSLog(@"error");//[error localizedDescription]);
        else
            [self.audioPlayer play];
    */
    // Present the scene.
    [skView presentScene:scene];
    }
 
}

- (BOOL)shouldAutorotate
{
    return YES;
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
