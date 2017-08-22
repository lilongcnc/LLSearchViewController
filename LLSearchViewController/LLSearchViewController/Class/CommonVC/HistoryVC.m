//
//  HistoryVC.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HistoryVC.h"
#import "HistorySearchVC.h"
#import "LLSearchVCConst.h"




@interface HistoryVC ()

@end

@implementation HistoryVC

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
        //(1)点击分类 (2)用户点击键盘"搜索"按钮  (3)点击历史搜索记录
        [searShopVC beginSearch:^(NaviBarSearchType searchType,NBSSearchShopCategoryViewCellP *categorytagP,UILabel *historyTagLabel,LLSearchBar *searchBar) {
            
            NSLog(@"historyTagLabel:%@--->searchBar:%@--->categotyTitle:%@--->%@",historyTagLabel.text,searchBar.text,categorytagP.categotyTitle,categorytagP.categotyID);
            
            searShopVC.searchBarText = @"你选择的搜索内容显示到这里";
        }];
        //执行即时搜索匹配
        NSArray *tempArray =  @[@"Java", @"Python"];
        [searShopVC searchbarDidChange:^(NaviBarSearchType searchType, LLSearchBar *searchBar, NSString *searchText) {
            //FIXME:这里模拟网络请求数据!!!
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                searShopVC.resultListArray = tempArray;
            });
        }];
        [self.navigationController presentViewController:searShopVC animated:nil completion:nil];
    }];
    
    [self.view addSubview:searchNaviBarView];
}



@end
