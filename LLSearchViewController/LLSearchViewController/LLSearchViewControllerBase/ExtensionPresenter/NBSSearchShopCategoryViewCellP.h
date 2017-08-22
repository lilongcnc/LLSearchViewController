//
//  NBSSearchShopCategoryViewCellP.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/13.
//
//



#import <Foundation/Foundation.h>
@class TagTypeModel;

@interface NBSSearchShopCategoryViewCellP : NSObject

+(instancetype)presenterWithModel:(TagTypeModel *)model;

@property (nonatomic,copy,readonly) NSString *categotyTitle;
@property (nonatomic,copy,readonly) NSString *categotyID;


@end

