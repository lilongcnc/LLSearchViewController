//
//  HistorySearchVC.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HistorySearchVC.h"
#import "HistorySearchHistroyViewP.h"
#import "LLSearchVCConst.h"

@interface HistorySearchVC ()

@end

@implementation HistorySearchVC

- (void)viewDidLoad {
    
    //告诉父类你的prestenter是什么
    self.shopHistoryP = [HistorySearchHistroyViewP new];
    //告诉只显示历史搜索界面
    self.isOnlyShowHistoryView = YES;
    
    
    
    
    
    [super viewDidLoad];
}


- (void)setSearchMethod
{
    //FIXME:也可以在这里实现搜索页面相关方法!!!
    @LLWeakObj(self);
    [self searchbarDidChange:^(NaviBarSearchType searchType, LLSearchBar *searchBar, NSString *searchText) {
        @LLStrongObj(self);
        //FIXME:这里是用的模拟数据!!!
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.resultListArray = @[@"春天", @"秋田", @"夏天-C", @"冬天"];
        });
    }];

}
@end
