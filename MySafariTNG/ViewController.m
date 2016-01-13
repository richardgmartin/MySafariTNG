//
//  ViewController.m
//  MySafariTNG
//
//  Created by Richard Martin on 2016-01-12.
//  Copyright © 2016 Richard Martin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *variableWebView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *comingSoonButton;

@end

@implementation ViewController

- (IBAction)onBackButtonPressed:(id)sender
{
    [self.variableWebView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    [self.variableWebView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [self.variableWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender
{
    
    [self.variableWebView reload];
    
}
- (IBAction)comingSoon:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"COMING SOON" message:@"This new feature is coming soon" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelButton];
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadGivenURL:@"http://www.google.com"];
    self.variableWebView.scrollView.delegate = self;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.urlTextField setHidden:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.urlTextField setHidden:NO];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.urlTextField setHidden:NO];
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
    if ([self.variableWebView canGoForward]) {
        [self.forwardButton setEnabled:YES];
    } else {
        [self.forwardButton setEnabled:NO];
    }
    
}

-(void)loadGivenURL:(NSString *)givenURL {
    self.urlTextField.text = givenURL;
    NSLog(@"givenURL == %@", givenURL);
    NSLog(@"self.urlTextField.text == %@", self.urlTextField.text);
    
    // NSURL *url = [NSURL URLWithString:givenURL];
    
    NSURL *url;
    
    if ([self.urlTextField.text hasPrefix:@"http://"] || [self.urlTextField.text hasPrefix:@"https://"]) {
         url = [NSURL URLWithString:givenURL];
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", givenURL]];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.variableWebView loadRequest:request];
    
}

@end
