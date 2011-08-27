//
//  Egg_TellerViewController.h
//  Egg Teller
//
//  Created by Ishaan Gandhi on 7/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Egg_TellerViewController : UIViewController <UIAccelerometerDelegate> {
    IBOutlet UIImageView *top;
    IBOutlet UIImageView *bottom;
    IBOutlet UIButton *newEggButton;
    IBOutlet UILabel *fortune;
    IBOutlet UIView *splashView;
    
    BOOL isNewEgg;
    
    BOOL isDoneAnimating;
    
    SystemSoundID _crackSound;
    
    UIAccelerometer *accelerometer;
    
}

-(IBAction)newEgg;
-(IBAction)info;
-(NSString *)answer;
-(void)showSplash;
-(void)hideSplash;

@property (nonatomic, retain) UIAccelerometer *accelerometer;

@end
