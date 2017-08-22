//
//  LLSearchHistorySaveUtils.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/14.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^dealCompleteBlock) (BOOL isComplete);

@interface LLSearchHistorySaveUtils : NSObject


/**
 The number of cache search record, default is 15.
 */
@property (nonatomic, assign) NSUInteger searchHistoriesCount;

- (instancetype)initWithSearchHistoriesCacheFileName:(NSString *)fileName;
- (void)saveSearchCache:(NSString *)searchText result:(dealCompleteBlock)complete;
- (void)clearSearchHistoryWithResult:(dealCompleteBlock)complete;
- (NSArray<NSString *> *)getSearchCache;


@end
