//
//  LLNaviSearchHistorySaveBasePresenter.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/15.
//
//

#import "LLNaviSearchHistorySaveBasePresenter.h"
#import "LLSearchVCConst.h"

@implementation LLNaviSearchHistorySaveBasePresenter

- (instancetype)init{
    if (self = [super init]) {
        //code...
        _saveUtils = nil;
    }
    return self;
}

- (void)saveSearchCache:(NSString *)searchText result:(dealCompleteBlock)complete {
    [_saveUtils saveSearchCache:searchText result:complete];
}


- (void)clearSearchHistoryWithResult:(dealCompleteBlock)complete {
    [self.saveUtils clearSearchHistoryWithResult:complete];
}

- (NSArray<NSString *> *)getSearchCache{
//    NSLog(@"%@",[self.saveUtils getSearchCache]);
    return [self.saveUtils getSearchCache];
}



- (void)fetchAndHaveSearchCache:(dealCompleteBlock)complete {
    LLBLOCK_EXEC(complete,[self.saveUtils getSearchCache].count);
}






@end
