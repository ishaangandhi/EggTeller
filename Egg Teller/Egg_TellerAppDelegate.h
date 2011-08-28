//
//  Egg_TellerAppDelegate.h
//  Egg Teller
//
//  Created by Ishaan Gandhi on 7/23/11.
//  Copyright 2011 Ishaan Gandhi Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Egg_TellerViewController;

@interface Egg_TellerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Egg_TellerViewController *viewController;

@end
