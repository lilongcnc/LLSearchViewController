//
//  LLSearchHistorySaveUtils.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/14.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "LLSearchHistorySaveUtils.h"
//#import "ZYHTHistoryDataSaveUtils.h"


@interface LLSearchHistorySaveUtils ()

/**
 Whether remove the space of search string, default is YES.
 */
@property (nonatomic, assign) BOOL removeSpaceOnSearchString;



/**
 The records of search
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *searchHistories;


/**
 The path of cache search record, default is `PYSEARCH_SEARCH_HISTORY_CACHE_PATH`.
 */
@property (nonatomic, copy) NSString *searchHistoriesCachePath;


@end

@implementation LLSearchHistorySaveUtils



- (NSString *)getPathWithFileName:(NSString *)fileName
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [paths objectAtIndex:0];
    NSString *dstPath = [documentDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",fileName]];
    return dstPath;
}




- (instancetype)initWithSearchHistoriesCacheFileName:(NSString *)fileName
{
    if (self = [super init]) {
        //code...
        _removeSpaceOnSearchString = YES;
        _searchHistoriesCachePath = [self getPathWithFileName:fileName];
        _searchHistoriesCount = 15;
    }
    return self;
}




- (void)saveSearchCache:(NSString *)searchText result:(dealCompleteBlock)complete
{
    BOOL saveFlag = NO; //存储是否成功,默认为不成功
    
    if (self.removeSpaceOnSearchString) { // remove sapce on search string
        searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if (searchText.length > 0) {
        
        //移除之前存储的相同的记录,重新储存到最前边
        [self.searchHistories removeObject:searchText];
        [self.searchHistories insertObject:searchText atIndex:0];
        
        //如果当前存储超过了规定存储的最大数量,则删除最开始的一个存储记录,再进行存储
        if (self.searchHistories.count > self.searchHistoriesCount) {
            [self.searchHistories removeLastObject];
        }
        
        //存储消息记录,返回标识
        saveFlag = [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    }
    
    //返回结果
    !complete ? : complete(saveFlag);
}



- (void)clearSearchHistoryWithResult:(dealCompleteBlock)complete
{
    BOOL dealFlag = NO; //删除是否成功

    if (_searchHistoriesCachePath) {
        [self.searchHistories removeAllObjects];
        dealFlag = [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    }
    
    //返回结果
    !complete ? : complete(dealFlag);
}



- (NSArray<NSString *> *)getSearchCache{
    return self.searchHistories;
}



- (NSMutableArray *)searchHistories
{
    if (!_searchHistories) {
        _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
    }
    return _searchHistories;
}



@end
