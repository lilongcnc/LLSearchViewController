//
//  NBSSearchShopCategoryView.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/12.
//
//

#import <UIKit/UIKit.h>
@class HistoryAndCategorySearchCategoryViewP;
@class NBSSearchShopCategoryViewCellP;



typedef void (^categoryTagonClickBlock)(NBSSearchShopCategoryViewCellP *cellP);

@interface NBSSearchShopCategoryView : UIView



+ (instancetype)searchShopCategoryViewWithPresenter:(HistoryAndCategorySearchCategoryViewP *)presenter WithFrame:(CGRect)rect;


- (void)reloadData;

- (void)categoryTagonClick:(categoryTagonClickBlock)clickBlock;

@property (nonatomic,copy) void(^modifyFrameBlock)(CGRect rect);

@end
