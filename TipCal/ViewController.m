//
//  ViewController.m
//  TipCal
//
//  Created by thomas minshull on 2016-07-08.
//  Copyright © 2016 thomas minshull. All rights reserved.
//

#import "ViewController.h"

#define INITIAL_LABEL_TEXT @"Enter your Bill amount to Calculate tip"
#define LABEL_PREFIX @"Your Total bill, inlcuding tip comes to: "

@interface ViewController ()
@property (assign, nonatomic) float tipPercentage;
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (assign, nonatomic, readonly) float tipAmount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tipPercentage = 0.15;
}

// Just for practice make a calculated property
- (float)tipAmount {
    return [self.billAmountTextField.text floatValue] * (1 + self.tipPercentage);
}

- (IBAction)CalculateTip:(id)sender {
    if (self.tipAmount == 0) {
        [self.tipLabel setText:INITIAL_LABEL_TEXT];
    } else {
        [self.tipLabel setText:[NSString stringWithFormat:@"%@%.2f", LABEL_PREFIX, self.tipAmount]];
    }
   
}

@end
