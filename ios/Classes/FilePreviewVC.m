//
//  FilePreviewVC.m
//  barcode_scan
//
//  Created by wenjunhuang on 2018/9/6.
//

#import "FilePreviewVC.h"

@interface FilePreviewVC ()
@property (nonatomic, strong) UIWebView *myWebView;
@end

@implementation FilePreviewVC

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setNeedsStatusBarAppearanceUpdate];
//  UIImage *backIcon = [UIImage imageWithContentsOfFile:self.backImgPath];
//  UIButton *backBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 10, 20)];
//  [backBtn setImage:backIcon forState:UIControlStateNormal];
//  [backBtn setBounds:CGRectMake(0, 0, 10, 10)];
//  [backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item1];
    
  UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close)];
  self.navigationItem.leftBarButtonItem = item1;
  self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
  self.myWebView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  self.myWebView.scalesPageToFit = YES;//使文档的显示范围适合UIWebView的bounds
  [self.view addSubview:self.myWebView];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([self.url hasPrefix:@"/"]) {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:self.url];
        [self.myWebView loadData:data MIMEType:self.fileType textEncodingName:@"UTF-8" baseURL:nil];
    } else {
      NSURL *filePath = [NSURL URLWithString:self.url];
      NSURLRequest *request = [NSURLRequest requestWithURL: filePath];
      [self.myWebView loadRequest:request];
    }
}

- (void)close {
  [self dismissViewControllerAnimated:true completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
  if (@available(iOS 13.0, *)) {
    return UIStatusBarStyleDarkContent;
  } else {
    return UIStatusBarStyleDefault;
  }
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
  UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
  
  if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
    statusBar.backgroundColor = color;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
