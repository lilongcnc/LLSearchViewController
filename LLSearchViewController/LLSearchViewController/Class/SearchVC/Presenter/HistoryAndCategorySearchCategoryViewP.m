//
//  HistoryAndCategorySearchCategoryViewP.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HistoryAndCategorySearchCategoryViewP.h"
#import "NBSSearchShopCategoryViewCellP.h"
#import "TagTypeModel.h"


@interface HistoryAndCategorySearchCategoryViewP ()

@property (nonatomic,strong) NSMutableArray<NBSSearchShopCategoryViewCellP *> *collectionDataArray;

@end


@implementation HistoryAndCategorySearchCategoryViewP


- (NSArray<NBSSearchShopCategoryViewCellP *> *)allCategotyTypeData
{
    return self.collectionDataArray;
}

- (NSArray<NSString *> *)allCategotyTypeTitles{
    
    return [self.collectionDataArray valueForKeyPath:@"categotyTitle"];
    
}

- (void)fetchCategotyTypeData:(FetchNetDataCompleteHandlerBlock)completeBlock {
    
    //FIXME:模拟网络请求!!!
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *titleArray = @[@"全部",@"美女",@"烟酒",@"汽车",@"服装",@"超市",@"洗发水",@"电视机",@"洗衣用品",@"家具电器",@"家具用品",@"篮球",@"运动鞋",@"裤子",@"袜子",@"面包",@"水果"];
        NSArray *tagArray = @[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),@(14),@(15),@(16),@(17),@(18),@(19),@(20),@(21)];
        
        for (int i = 0; i < titleArray.count; i++) {
            TagTypeModel *shopM = [TagTypeModel new];
            shopM.TypeName = titleArray[i];
            shopM.TypeID = tagArray[i];
            [self.collectionDataArray addObject:[NBSSearchShopCategoryViewCellP presenterWithModel:shopM]];
        }
        
        
        
        //返回block
        completeBlock(nil,nil);//这里实际返回的是你真实网络请求数据
    });
    
}




- (NSMutableArray<NBSSearchShopCategoryViewCellP *> *)collectionDataArray
{
    if (!_collectionDataArray) {
        _collectionDataArray = [[NSMutableArray alloc] init];
    }
    return _collectionDataArray;
}

@end
