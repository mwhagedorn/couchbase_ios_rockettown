//
//  RocketDetailViewController.h
//  RocketTownIOS
//
//  Created by Mike Hagedorn on 3/12/16.
//  Copyright © 2016 Mike Hagedorn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDRocket.h"

@interface RocketDetailViewController : UIViewController<UITextFieldDelegate>
    @property (strong, nonatomic) ASDRocket *rocket;
@property (weak, nonatomic) IBOutlet UITextField *rocketNameField;
@property (weak, nonatomic) IBOutlet UITextField *rocketDiaField;
@property (weak, nonatomic) IBOutlet UITextField *rocketWeightField;
@property (weak, nonatomic) IBOutlet UITextField *rocketCoefficientField;
@property (weak, nonatomic) IBOutlet UILabel *rocketNameLabel;

@end
