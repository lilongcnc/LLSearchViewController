//
//  NBSSearchShopHistoryView.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/14.
//
//

#import <UIKit/UIKit.h>
@class HistorySearchHistroyViewP;

typedef void (^historyTagonClickBlock)(UILabel *tagLabel);

@interface NBSSearchShopHistoryView : UIView


+ (instancetype)searchShopCategoryViewWithPresenter:(HistorySearchHistroyViewP *)presenter WithFrame:(CGRect)rect;


/**
 刷新数据
 */
- (void)reloadData;


/**
 历史标签被点击

 @param clickBlock <#clickBlock description#>
 */
- (void)historyTagonClick:(historyTagonClickBlock)clickBlock;


/**
 消除所有按钮被点击
 */
@property (nonatomic,copy) void(^clearHistoryBtnOnClick)();

@end
