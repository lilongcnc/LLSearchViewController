//
//  ViewController.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "ViewController.h"
#import "HistoryAndCategorySearchVC.h"
#import "HistorySearchVC.h"
#import "CategoryAndHistoryVC.h"
#import "HistoryVC.h"

#import <objc/runtime.h>
#import "UIView+LLRect.h"
#import "HistoryAnimationVC.h"


@interface ViewController ()
@property (nonatomic,strong) UIScrollView *myBGScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.hidden = YES;
    [self creatSearchNaviBarStyle1];
    [self creatSearchNaviBarStyle2];
    [self creatSearchNaviBarStyle3];
    [self creatSearchNaviBarStyle4];
    [self creatSearchNaviBarStyle5];
    
    
    
    [self setButton:@"分类和历史记录搜索页面->" x:15 y:500 sel:@selector(buttonObClick1)];
    [self setButton:@"历史记录搜索页面->" x:160 y:500 sel:@selector(buttonObClick2)];
    [self setButton:@"历史记录搜索页面(动画)->" x:15 y:565 sel:@selector(buttonObClick3)];
//    [self setButton:@"push界面->" x:160 y:565 sel:@selector(buttonObClick4)]; //暂时不实现
}



//---------------------------------------------------------------------------------------------------
#pragma mark ================================== LLSearchNaviBarView样式 ==================================
//---------------------------------------------------------------------------------------------------
- (void)creatSearchNaviBarStyle1{
    LLSearchNaviBarView *searchNaviBarView = [LLSearchNaviBarView new];
    searchNaviBarView.searbarPlaceHolder = @"请输入搜索关键词";
    
    [searchNaviBarView setSearchBarBeignOnClickBlock:nil];
    searchNaviBarView.y = -20;
    [self.myBGScrollView addSubview:searchNaviBarView];
}



- (void)creatSearchNaviBarStyle2{
    LLSearchNaviBarView *searchNaviBarView = [LLSearchNaviBarView new];
    searchNaviBarView.searbarPlaceHolder = @"请输入搜索关键词";

    [searchNaviBarView showRightOneBtnWith:[UIImage imageNamed:@"nearbyshop_showMap"] onClick:nil];
    
    [searchNaviBarView setSearchBarBeignOnClickBlock:nil];
    
    searchNaviBarView.y = 100;
    [self.myBGScrollView addSubview:searchNaviBarView];
}


- (void)creatSearchNaviBarStyle3{
    LLSearchNaviBarView *searchNaviBarView = [LLSearchNaviBarView new];
    searchNaviBarView.searbarPlaceHolder = @"请输入搜索关键词";
    
    [searchNaviBarView showbackBtnWith:[UIImage imageNamed:@"navi_back_w"] onClick:nil];
    [searchNaviBarView showRightOneBtnWith:[UIImage imageNamed:@"nearbyshop_showMap"] onClick:nil];
    
    [searchNaviBarView setSearchBarBeignOnClickBlock:nil];
    
    searchNaviBarView.y = 200;
    [self.myBGScrollView addSubview:searchNaviBarView];
}


- (void)creatSearchNaviBarStyle4{
    LLSearchNaviBarView *searchNaviBarView = [LLSearchNaviBarView new];
    searchNaviBarView.searbarPlaceHolder = @"请输入搜索关键词";
    
    [searchNaviBarView showbackBtnWith:[UIImage imageNamed:@"navi_back_w"] onClick:nil];
    
    [searchNaviBarView setSearchBarBeignOnClickBlock:nil];
    
    searchNaviBarView.y = 300;
    [self.myBGScrollView addSubview:searchNaviBarView];
}


- (void)creatSearchNaviBarStyle5{
    LLSearchNaviBarView *searchNaviBarView = [LLSearchNaviBarView new];
    searchNaviBarView.searbarPlaceHolder = @"请输入搜索关键词";
    searchNaviBarView.backgroundColor = [UIColor redColor];
    
    [searchNaviBarView showbackBtnWith:[UIImage imageNamed:@"navi_back_w"] onClick:nil];
    
    [searchNaviBarView setSearchBarBeignOnClickBlock:nil];
    
    searchNaviBarView.y = 400;
    [self.myBGScrollView addSubview:searchNaviBarView];
}



//---------------------------------------------------------------------------------------------------
#pragma mark ================================== 跳转到搜索界面 ==================================
//---------------------------------------------------------------------------------------------------
- (void)buttonObClick1
{
    CategoryAndHistoryVC *chVC = [CategoryAndHistoryVC new];
    [self.navigationController pushViewController:chVC animated:YES];
}

- (void)buttonObClick2
{
    HistoryVC *hVC = [HistoryVC new];
    [self.navigationController pushViewController:hVC animated:YES];
}

- (void)buttonObClick3
{
    HistoryAnimationVC *haVC = [HistoryAnimationVC new];
    [self.navigationController pushViewController:haVC animated:YES];
}

- (void)buttonObClick4
{
    HistorySearchVC *searShopVC = [HistorySearchVC new];
    [self.navigationController pushViewController:searShopVC animated:YES];
}




//---------------------------------------------------------------------------------------------------
#pragma mark ================================== 私有方法 ==================================
//---------------------------------------------------------------------------------------------------

- (void)setButton:(NSString *)title x:(CGFloat)x y:(CGFloat)y sel:(SEL)method
{
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 130, 50)];
    [button2  setTitle:title forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor cyanColor];
    button2.titleLabel.adjustsFontSizeToFitWidth = YES;
    button2.titleLabel.translatesAutoresizingMaskIntoConstraints = YES;
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    [self.myBGScrollView addSubview:button2];
}

- (UIScrollView *)myBGScrollView
{
    if (!_myBGScrollView) {
        _myBGScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
        _myBGScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
        _myBGScrollView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
        [_myBGScrollView addGestureRecognizer:tapGes];
        [self.view addSubview:_myBGScrollView];
    }
    return _myBGScrollView;
}


- (void)endEdit
{
    [self.myBGScrollView endEditing:YES];
}


@end
