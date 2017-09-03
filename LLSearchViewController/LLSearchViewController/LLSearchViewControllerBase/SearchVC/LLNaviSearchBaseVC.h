//
//  LLNaviSearchBaseVC.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/15.
//
//


#import <UIKit/UIKit.h>
#import "LLSearchNaviBarView.h"
#import "LLSearchBar.h"
#import "NBSSearchShopCategoryView.h"
#import "NBSSearchShopHistoryView.h"

#import "NBSSearchShopCategoryViewCellP.h"
#import "LLSearchResultListView.h"


typedef NS_OPTIONS(NSUInteger, NaviBarSearchType) {
    NaviBarSearchTypeDefault = 0, //导航条输入搜索
    NaviBarSearchTypeCategory,
    NaviBarSearchTypeHistory,
    NaviBarSearchTypesearchBarDidChange //搜索框即时搜索完成
};

typedef void (^beginSearchBlock)(NaviBarSearchType searchType,NBSSearchShopCategoryViewCellP *categorytagP,UILabel *historyTagLabel,LLSearchBar *searchBar);

typedef void (^searchBarDidChangeBlock)(NaviBarSearchType searchType, LLSearchBar *searchBar,NSString *searchText);


@interface LLNaviSearchBaseVC : UIViewController

/*----------------------------------------------------------------
 *                          接口方法                               *
 -----------------------------------------------------------------*/
/**
 搜索条的文字
 */
@property (nonatomic,copy) NSString *searchBarText;

/**
 即时搜索匹配框,匹配的数据列表
 */
@property (nonatomic,strong) NSArray<NSString *> *resultListArray;

/**
 搜索框:用户即时输入完毕
 
 @param didChangeBlock 更改后的回调
 */
- (void)searchbarDidChange:(searchBarDidChangeBlock)didChangeBlock;

/**
 即时匹配结果列表cell点击事件
 */
- (void)resultListViewDidSelectedIndex:(resultListViewCellDidClickBlock)cellDidClickBlock;

/**
 点击键盘"搜索"按钮或者历史标签
 
 @param beginSearchBlock 搜索数据
 */
- (void)beginSearch:(beginSearchBlock)beginSearchBlock;

/**
 是否只显示历史记录模
 (
 1. 其实在 OC 中是多此一举,因为已经为子类提供了[shopCategoryP],[shopHistoryP]处理类,如果任意一个初始化,为 nil,则其不会调用代码写出的方法.
 这里为了更加安全,还是手动添加一个控制属性.
 2. 当然,1中所说的仅限于使用默认本类默认布局情况下
 )
 */
@property (nonatomic,assign) BOOL isOnlyShowHistoryView;



/*----------------------------------------------------------------
 *                          对子类抛出的属性                         *
 -----------------------------------------------------------------*/

@property (nonatomic,strong) UIScrollView *myBGScrollView;


/**
 分类模块的数据处理类,子类根据需要实现该属性,为界面提供数据
 */
@property (nonatomic,strong) id shopCategoryP;

/**
 历史记录模块的处理类,子类根据需要实现该属性,为界面提供数据
 */
@property (nonatomic,strong) id shopHistoryP;



@end
