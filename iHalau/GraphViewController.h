//
//  GraphViewController.h
//  iHalau
//
//  Created by mzp on 2012/08/22.
//  Copyright (c) 2012年 mzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphViewController :UIViewController<UIWebViewDelegate>{
    
    __weak IBOutlet UIWebView *webView;
    UIView *loadingView;
}
- (IBAction)done:(id)sender;

@end
