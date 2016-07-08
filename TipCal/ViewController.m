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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (assign, nonatomic, readonly) float tipAmount;

@end

@implementation ViewController

#pragma mark - LifeCycle Methods 


- (void)viewDidLoad {
    [super viewDidLoad];

    self.tipPercentage = 0.15;
}

- (void)viewWillAppear:(BOOL)animated {
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
    return [self.billAmountTextField.text floatValue] * (1 + self.tipPercentage);
}

#pragma mark -Actions 

- (IBAction)rootViewTapped:(id)sender {
    [self.view endEditing:YES];
    [self keyBoardWillHide:nil];
}

- (IBAction)CalculateTip:(id)sender {
    if (self.tipAmount == 0) {
        [self.tipLabel setText:INITIAL_LABEL_TEXT];
    } else {
        [self.tipLabel setText:[NSString stringWithFormat:@"%@%.2f", LABEL_PREFIX, self.tipAmount]];
    }
   
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
