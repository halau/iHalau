//
//  GraphViewController.m
//  iHalau
//
//  Created by mzp on 2012/08/22.
//  Copyright (c) 2012年 mzp. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
}

- (void)viewDidUnload {
    webView = nil;
    [super viewDidUnload];
}
- (IBAction)done:(id)sender {
    [self dismissModalViewControllerAnimated:TRUE];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [loadingView removeFromSuperview];
    loadingView = [[UIView alloc] initWithFrame: [[self view] bounds]];
    [loadingView setBackgroundColor:[UIColor blackColor]];
    [loadingView setAlpha:0.5];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [[self view] addSubview:loadingView];
    [loadingView addSubview:indicator];
    [indicator setFrame: CGRectMake((320/2-20),480/2-20,40,40)];
    [indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [loadingView removeFromSuperview];
    loadingView = nil;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [loadingView removeFromSuperview];
    loadingView = nil;
}
@end
