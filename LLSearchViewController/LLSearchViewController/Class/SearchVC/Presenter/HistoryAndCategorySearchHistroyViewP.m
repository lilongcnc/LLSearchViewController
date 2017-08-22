//
//  HistoryAndCategorySearchHistroyViewP.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HistoryAndCategorySearchHistroyViewP.h"
#import "LLSearchHistorySaveUtils.h"
#import "ZYHTFileNameConst.h"

@implementation HistoryAndCategorySearchHistroyViewP

- (instancetype)init{
    if (self = [super init]) {
        
        //赋值
        self.saveUtils = [[LLSearchHistorySaveUtils alloc] initWithSearchHistoriesCacheFileName:NearByShopSearchShopNameHistoryCacheFileName];
    }
    return self;
}



@end
