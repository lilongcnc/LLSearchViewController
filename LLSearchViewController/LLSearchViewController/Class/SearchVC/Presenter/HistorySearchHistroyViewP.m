//
//  HistorySearchHistroyViewP.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HistorySearchHistroyViewP.h"
#import "LLSearchHistorySaveUtils.h"
#import "ZYHTFileNameConst.h"

@implementation HistorySearchHistroyViewP

- (instancetype)init{
    if (self = [super init]) {
        //code...
        self.saveUtils = [[LLSearchHistorySaveUtils alloc] initWithSearchHistoriesCacheFileName:NearByShopSearchMapAddressHistoryCacheFileName];
        
    }
    return self;
}


@end
