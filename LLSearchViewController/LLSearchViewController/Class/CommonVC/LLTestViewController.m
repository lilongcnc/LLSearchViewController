//
//  LLTestViewController.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/9/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "LLTestViewController.h"

@interface LLTestViewController ()

@end

@implementation LLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button  setTitle:@"1000" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonOnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc
{
    NSLog(@"LLTestViewController 页面销毁");
}

@end
