//
//  LLSearchResultListView.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/28.
//
//

#import <UIKit/UIKit.h>

typedef void (^resultListViewCellDidClickBlock)(UITableView *tableView,NSInteger index);

@interface LLSearchResultListView : UIView

@property (nonatomic,strong) NSArray<NSString *> *resultArray;


/**
 列表被选中
 */
- (void)resultListViewDidSelectedIndex:(resultListViewCellDidClickBlock)cellDidClickBlock;



@end
