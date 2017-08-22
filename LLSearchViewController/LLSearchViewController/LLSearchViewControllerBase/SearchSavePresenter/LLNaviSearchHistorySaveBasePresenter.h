//
//  LLNaviSearchHistorySaveBasePresenter.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/15.
//
//

#import <Foundation/Foundation.h>
#import "LLSearchHistorySaveUtils.h"

typedef void (^dealCompleteBlock) (BOOL isComplete);


@interface LLNaviSearchHistorySaveBasePresenter : NSObject

/*----------------------------------------------------------------
 *                          对子类抛出的属性                         *
 -----------------------------------------------------------------*/

@property (nonatomic,strong) LLSearchHistorySaveUtils *saveUtils;


/*----------------------------------------------------------------
 *                          接口方法                               *
 -----------------------------------------------------------------*/

- (void)saveSearchCache:(NSString *)searchText result:(dealCompleteBlock)complete;

- (void)clearSearchHistoryWithResult:(dealCompleteBlock)complete;

- (NSArray<NSString *> *)getSearchCache;


- (void)fetchAndHaveSearchCache:(dealCompleteBlock)complete;
@end
