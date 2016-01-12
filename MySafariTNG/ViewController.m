//
//  ViewController.m
//  MySafariTNG
//
//  Created by Richard Martin on 2016-01-12.
//  Copyright © 2016 Richard Martin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *variableWebView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation ViewController

- (IBAction)onBackButtonPressed:(id)sender {
    [self.variableWebView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    [self.variableWebView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.variableWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {
    
    [self.variableWebView reload];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadGivenURL:@"http://www.google.com"];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self loadGivenURL:self.urlTextField.text];
    
    return true;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self.spinner startAnimating];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.spinner stopAnimating];
    
    if ([self.variableWebView canGoBack]) {
        [self.backButton setEnabled:YES];
    } else {
        [self.backButton setEnabled:NO];
    }
    
}

-(void)loadGivenURL:(NSString *)givenURL {
    
    NSURL *url = [NSURL URLWithString:givenURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.variableWebView loadRequest:request];
    
}
@end
