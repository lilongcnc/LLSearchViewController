//
//  HistoryAndCategorySearchVC.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HistoryAndCategorySearchVC.h"
#import "HistoryAndCategorySearchHistroyViewP.h"
#import "HistoryAndCategorySearchCategoryViewP.h"
#import "LLSearchVCConst.h"

@interface HistoryAndCategorySearchVC ()

@end

@implementation HistoryAndCategorySearchVC

- (void)viewDidLoad {
    
    //告诉父类你的prestenter是什么
    self.shopHistoryP = [HistoryAndCategorySearchHistroyViewP new];
    
    self.shopCategoryP = [HistoryAndCategorySearchCategoryViewP new];
    
    [super viewDidLoad];
    
}


-(void)dealloc
{
    NSLog(@"HistoryAndCategorySearchVC 页面销毁");
}


@end
