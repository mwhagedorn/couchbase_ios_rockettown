//
//  RocketDetailViewController.m
//  RocketTownIOS
//
//  Created by Mike Hagedorn on 3/12/16.
//  Copyright © 2016 Mike Hagedorn. All rights reserved.
//

#import "RocketDetailViewController.h"

typedef NS_ENUM (NSInteger, SSSActionType) {
    TextFieldTagName= 100,
    TextFieldTagDiameter= 110,
    TextFieldTagWeight= 120,
    TextFieldTagCoeff=130,
};

@interface RocketDetailViewController ()

@end

@implementation RocketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    self.rocketNameField.text = self.rocket.name;
    self.rocketNameLabel.text = self.rocket.name;
    self.rocketDiaField.text = [NSString stringWithFormat:@"%lf", self.rocket.diameter];
    self.rocketWeightField.text = [NSString stringWithFormat:@"%lf", self.rocket.weight];
    self.rocketCoefficientField.text = [NSString stringWithFormat:@"%lf", self.rocket.coefficientFriction];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    switch (textField.tag) {
        case TextFieldTagName:
            _rocket.name = textField.text;
            break;
            
        case TextFieldTagDiameter:
            _rocket.diameter = [textField.text doubleValue];
            break;
            
        case TextFieldTagWeight:
            _rocket.weight = [textField.text doubleValue];
            break;
            
        case TextFieldTagCoeff:
            _rocket.coefficientFriction = [textField.text doubleValue];
            break;

        default:
            break;
    }
    NSError* error;
    if (![self.rocket save: &error]){
        NSLog(@"Unable to save Rocket");
        return YES;
    }
    
    return YES;
}
- (IBAction)didDismissDetail:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
