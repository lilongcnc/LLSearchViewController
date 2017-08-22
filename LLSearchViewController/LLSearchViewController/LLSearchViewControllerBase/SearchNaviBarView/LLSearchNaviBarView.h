//
//  LLSearchNaviBarView.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/12.
//
//

/*----------------------------------------------------------------------------------
 *                                自定义搜索导航条     *
 ----------------------------------------------------------------------------------*/

#import <UIKit/UIKit.h>
@class LLSearchBar;

typedef NS_OPTIONS(NSUInteger, LLSearchNaviBarViewType) {
    searchNaviBarViewDefault = 0,
    searchNaviBarViewWhiteAndGray
};


typedef void (^rightOneBtnOnClick) (UIButton *btn);
typedef void (^backBtnOnClick) (UIButton *btn);
typedef void (^keyBoardSearchBtnOnClickBlock) (LLSearchBar *searchBar);
typedef void (^textofSearchBarDidChangeBlock) (LLSearchBar *searchBar,NSString *searchText);

@interface LLSearchNaviBarView : UIView

/**
 实现该方法,则搜索框右边的按钮显示

 @param image 图片名称
 @param btnBlock 点击block
 */
- (void)showRightOneBtnWith:(UIImage *)image onClick:(rightOneBtnOnClick)btnBlock;

/**
 实现该方法,则搜索框右边的按钮显示
 
 @param title 按钮名称
 @param btnBlock 点击block
 */
- (void)showRightOneBtnWithTitle:(NSString *)title onClick:(rightOneBtnOnClick)btnBlock;


/**
 实现该方法,显示出导航条返回按钮,可以自定义返回按钮的图片,如果默认,则传入nil

 @param image 返回按钮图片,不需要则传Nil
 @param btnBlock 点击block
 */
- (void)showbackBtnWith:(UIImage *)image onClick:(backBtnOnClick)btnBlock;



/**
 导航条右边按钮图片
 */
@property (nonatomic,assign) UIImage *rightOneBtnIconImage;


/**
 导航条返回按钮图片
 */
@property (nonatomic,assign) UIImage *backBtnIconImage;

/**
 搜索框
 */
@property (nonatomic,strong,readonly) LLSearchBar *naviSearchBar;



/**
 搜索导航条样式
 */
@property (nonatomic,assign) LLSearchNaviBarViewType searchNaviBarViewType;


/**
 导航条搜索框中的searchbar的占位文字
 */
@property (nonatomic,copy) NSString *searbarPlaceHolder;



/**
 是否隐藏searchbar中的右边的图片
 */
@property (nonatomic,assign) BOOL isHideSearchBarRightIcon;

/**
 自定义searchbar中的右边的图片
 */
@property (nonatomic,assign) UIImage *searchBarRightIconImage;


/**
 searchbar被点击
 */
@property (nonatomic,copy) void(^searchBarBeignOnClickBlock)();


/**
 键盘上搜索按钮被点击
 */
- (void)keyBoardSearchBtnOnClick:(keyBoardSearchBtnOnClickBlock)searchBtnOnClickBlock;


/**
 搜索框框输入文字之后的即时变化
 */
- (void)textOfSearchBarDidChangeBlock:(textofSearchBarDidChangeBlock)textofSearchBarDidChangeBlock;

@end






