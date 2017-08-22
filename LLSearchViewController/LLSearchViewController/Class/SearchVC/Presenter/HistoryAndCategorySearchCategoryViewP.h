//
//  HistoryAndCategorySearchCategoryViewP.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/22.
//  Copyright © 2017年 李龙. All rights reserved.
//
/*----------------------------------------------------------------
 *       HistoryAndCategorySearchVC的分类页面的业务处理者             *
 -----------------------------------------------------------------*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class NBSSearchShopCategoryViewCellP;


typedef void (^FetchNetDataCompleteHandlerBlock)(NSError *error,id result);


@interface HistoryAndCategorySearchCategoryViewP : NSObject


/**
 获取商户分类
 */
- (NSArray<NBSSearchShopCategoryViewCellP *> *)allCategotyTypeData;

/**
 发送网络请求获取商户分类
 */
- (void)fetchCategotyTypeData:(FetchNetDataCompleteHandlerBlock)completeBlock;


/**
 获取商户分类的标题
 */
- (NSArray<NSString *> *)allCategotyTypeTitles;


@end
