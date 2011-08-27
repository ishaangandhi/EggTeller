//
//  Egg_TellerViewController.m
//  Egg Teller
//
//  Created by Ishaan Gandhi on 7/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Egg_TellerViewController.h"

@implementation Egg_TellerViewController
@synthesize accelerometer;

//  Release outlets //

- (void)dealloc
{
    [top release];
    [bottom release];
    [newEggButton release];
    [fortune release];
    [splashView release];
    [accelerometer release];
    [super dealloc];
}

//  Initialize accelerometer    //

-(void)viewDidLoad {
    [super viewDidLoad];
    self.accelerometer = [UIAccelerometer sharedAccelerometer];
    self.accelerometer.updateInterval = 0.2;
    self.accelerometer.delegate = self;
    isNewEgg = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [[self view] becomeFirstResponder];
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

//  Set outlets to nil  //

-(void)viewDidUnload {
    top = nil;
    bottom = nil;
    newEggButton = nil;
    fortune = nil;
    splashView = nil;
    self.accelerometer = nil;
}


//  Manage Splash Screen //


-(void)showSplash {
    UIViewController *modalViewController = [[UIViewController alloc] init];
    modalViewController.view = splashView;
    [self presentModalViewController:modalViewController animated:NO];
    [self performSelector:@selector(hideSplash) withObject:nil afterDelay:3.0];
}

-(void)hideSplash {
    self.modalViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[self modalViewController] dismissModalViewControllerAnimated:YES];
}

//  Detect A Shake To Determine if egg should break  //

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{    
    double xVal = acceleration.x;
    double zVal = acceleration.z;
    if((xVal > 1.9 || xVal < -1.9 || zVal > 1.9 || zVal < -1.9) && isNewEgg){
       
        //  Move the bottom part of the egg //
        
        fortune.text = [self answer];
        newEggButton.alpha = 1;
        [UIView beginAnimations:@"MoveAndStrech" context:nil];
        [UIView setAnimationDuration:.4];
        [UIView setAnimationBeginsFromCurrentState:YES];
        bottom.center = CGPointMake(153.0, 454.0);
        [UIView commitAnimations];
        fortune.alpha = 1;
        isNewEgg = NO;
        
        //  Play the Sound Effect   //
        
        NSURL *crackURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"crackSoundEffect" ofType:@"aif"]];
        AudioServicesCreateSystemSoundID((CFURLRef)crackURL, &_crackSound);
        AudioServicesPlaySystemSound(_crackSound);
    }
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"Motion Began");
    if(motion == UIEventSubtypeMotionShake) {
        fortune.text = [self answer];
        newEggButton.alpha = 1;
        [UIView beginAnimations:@"MoveAndStrech" context:nil];
        [UIView setAnimationDuration:.4];
        [UIView setAnimationBeginsFromCurrentState:YES];
        bottom.center = CGPointMake(153.0, 454.0);
        [UIView commitAnimations];
        fortune.alpha = 1;
        isNewEgg = NO;
        
        //  Play the Sound Effect   //
        
        NSURL *crackURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"crackSoundEffect" ofType:@"aif"]];
        AudioServicesCreateSystemSoundID((CFURLRef)crackURL, &_crackSound);
        AudioServicesPlaySystemSound(_crackSound);
    }
}

//  Detect A Flick To Determine if egg should break  //


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{       
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    CGPoint oldLocation = [touch previousLocationInView:self.view];
    float yDif = location.y - oldLocation.y;
    if(yDif > 30 && isNewEgg) {
        
        //  Move the bottom part of the egg //
        
        isDoneAnimating = NO;
        
        fortune.text = [self answer];
        newEggButton.alpha = 1;
        [UIView beginAnimations:@"MoveAndStrech" context:nil];
        [UIView setAnimationDuration:.4];
        [UIView setAnimationBeginsFromCurrentState:YES];
        bottom.center = CGPointMake(160.0, 454.0);
        [UIView commitAnimations];
        fortune.alpha = 1;
        isNewEgg = NO;
        
        //  Play the Sound Effect   //
        
        NSURL *crackURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"crackSoundEffect" ofType:@"aif"]];
        AudioServicesCreateSystemSoundID((CFURLRef)crackURL, &_crackSound);
        AudioServicesPlaySystemSound(_crackSound);
        
        //  Enable Second Flick //
        [self performSelector:@selector(setIsDoneAnimatingToYes) withObject:nil afterDelay:0.4];
        
    }  
    if(yDif > 30 && !isNewEgg && isDoneAnimating) {
        fortune.alpha = 0;
        newEggButton.alpha = 0;
        [UIView beginAnimations:@"MoveAndStrech" context:nil];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationBeginsFromCurrentState:YES];
        top.center = CGPointMake(160.0, 585);
        bottom.center = CGPointMake(160, 733);
        [UIView commitAnimations];
        
        [self performSelector:@selector(animateEgg) withObject:nil afterDelay:1];
    }
}

-(void)setIsDoneAnimatingToYes {
    isDoneAnimating = YES;
}

//  Drop Egg out of the bottom of the screen    //

-(IBAction)newEgg {
    fortune.alpha = 0;
    newEggButton.alpha = 0;
    [UIView beginAnimations:@"MoveAndStrech" context:nil];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationBeginsFromCurrentState:YES];
    top.center = CGPointMake(160.0, 585);
    bottom.center = CGPointMake(160, 733);
    [UIView commitAnimations];
    
    [self performSelector:@selector(animateEgg) withObject:nil afterDelay:1];
}

//  Drop Egg in from the top of the screen  //

-(void)animateEgg {
    top.center = CGPointMake(160, -227);
    bottom.center = CGPointMake(160, -100);
    [UIView beginAnimations:@"MoveAndStrech" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:NO];
    top.center = CGPointMake(160.0, 189);
    bottom.center = CGPointMake(160, 316);
    [UIView commitAnimations];
    isNewEgg = YES;
}

//  Display Instructions    //

-(IBAction)info {
    UIAlertView *instructionAlert = [[UIAlertView alloc] initWithTitle:@"Instructions"                                  message:@"1.  Ask the egg a question \n2.  Shake your device, or flick down\n3.  Tap 'New Egg' or flick down" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    ((UILabel*)[[instructionAlert subviews] objectAtIndex:1]).textAlignment = UITextAlignmentLeft;
    
    
    [instructionAlert show];
}

//  Randomly Generate a result  //

-(NSString *) answer {
    int random = arc4random() % 9;
    NSString *theAnswer = [[NSString alloc] init];
    switch (random) {
        case 0:
            theAnswer = @"Most definitely";
            break;
        case 1:
            theAnswer = @"No doubts";
            break;        
        case 2:
            theAnswer = @"I see it that way";
            break;
        case 3:
            theAnswer = @"Unlikely";
            break;
        case 4:
            theAnswer = @"Probably";
            break;
        case 5:
            theAnswer = @"No way";
            break;
        case 6:
            theAnswer = @"Yes";
            break;
        case 7:
            theAnswer = @"Unable to forecast";
            break;
        case 8:
            theAnswer = @"No";
            break;
        default:
            break;
    }
    return theAnswer;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end