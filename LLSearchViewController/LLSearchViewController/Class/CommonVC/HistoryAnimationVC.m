//
//  HistoryAnimationVC.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HistoryAnimationVC.h"
#import "HistorySearchVC.h"
#import "LLSearchVCConst.h"
#import "LLSearchNaviBarView.h"

@interface HistoryAnimationVC ()

@end

@implementation HistoryAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    
    [self creatSearchNaviBar];
    
}


- (void)creatSearchNaviBar{
    LLSearchNaviBarView *searchNaviBarView = [LLSearchNaviBarView new];
    searchNaviBarView.searbarPlaceHolder = @"请输入搜索关键词";
    
    [searchNaviBarView showbackBtnWith:[UIImage imageNamed:@"navi_back_w"] onClick:^(UIButton *btn) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    @LLWeakObj(self);
    [searchNaviBarView setSearchBarBeignOnClickBlock:^{
        @LLStrongObj(self);
        
        HistorySearchVC *searShopVC = [HistorySearchVC new];
        //在HistroySearchVC 中实现方法
        [searShopVC setSearchMethod];
        [self.navigationController presentViewController:searShopVC animated:YES completion:nil];
    }];
    
    [self.view addSubview:searchNaviBarView];
}

@end
