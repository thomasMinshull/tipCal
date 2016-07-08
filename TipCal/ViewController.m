//
//  ViewController.m
//  TipCal
//
//  Created by thomas minshull on 2016-07-08.
//  Copyright © 2016 thomas minshull. All rights reserved.
//

#import "ViewController.h"

#define INITIAL_LABEL_TEXT @"Enter your Bill amount to Calculate tip"
#define TOTAL_LABEL_PREFIX @"Your Total bill, inlcuding tip comes to: "
#define TIP_LABEL_PREFIX @"Tip Percentage: "

@interface ViewController ()
@property (assign, nonatomic, readonly) float tipAmount;
@property (assign, nonatomic) float tipPercentage;
@property (assign, nonatomic) float billAmount;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISlider *slider;


@end

@implementation ViewController

#pragma mark - LifeCycle Methods 


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    self.billAmount = 0.0;
    self.tipPercentage = 0.15;
    self.slider.value = self.tipPercentage;
    [self adjustTipPercentage:nil]; // sets label
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -Custom Getters/Setters

// Just for practice make a calculated property
- (float)tipAmount {
    return self.billAmount * (1 + self.tipPercentage);
}

#pragma mark -Actions 

- (IBAction)rootViewTapped:(id)sender {
    [self.view endEditing:YES];
    [self keyBoardWillHide:nil];
}

- (IBAction)adjustTipPercentage:(UISlider *)sender {
    self.tipPercentage = self.slider.value;
    [self updateLabels];
}

- (IBAction)billAmountChanged:(UITextField *)sender {
    self.billAmount = [sender.text doubleValue];
    [self updateLabels];
}

- (IBAction)buttonTapped:(UIButton *)sender {
    [sender setTitle:@"This button doesn't do anything!" forState:UIControlStateNormal];
}


#pragma mark -Helper Methods

- (void)updateLabels {
    if (self.billAmount == 0.0) {
        [self.totalLabel setText:INITIAL_LABEL_TEXT];
    } else {
        [self.totalLabel setText:[NSString stringWithFormat:@"%@%.2f", TOTAL_LABEL_PREFIX, self.tipAmount]];
    }
    [self.tipPercentLabel setText:[NSString stringWithFormat:@"%@%.2f", TIP_LABEL_PREFIX, self.tipPercentage]];
}


#pragma mark -KeyBoard Handling

- (void)keyBoardDidShow:(NSNotification *)paramNotification {
    NSValue *keyboardRectAsObject = [[paramNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = CGRectZero;
//    [keyboardRectAsObject getValue:&keyboardRect];
    keyboardRect = [keyboardRectAsObject CGRectValue];
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, keyboardRect.size.height, 0.0f);
}

-(void)keyBoardWillHide:(NSNotification *)paramNotification {
    self.scrollView.contentInset = UIEdgeInsetsZero;
}


@end
