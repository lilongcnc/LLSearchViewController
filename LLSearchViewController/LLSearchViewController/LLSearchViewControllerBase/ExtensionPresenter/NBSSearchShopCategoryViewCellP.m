//
//  NBSSearchShopCategoryViewCellP.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/13.
//
//

#import "NBSSearchShopCategoryViewCellP.h"
#import "TagTypeModel.h"

@interface NBSSearchShopCategoryViewCellP ()
@property (nonatomic,strong) TagTypeModel *myNearShopTypeModel;
@end
@implementation NBSSearchShopCategoryViewCellP


+(instancetype)presenterWithModel:(TagTypeModel *)model
{
    NBSSearchShopCategoryViewCellP *presenter = [NBSSearchShopCategoryViewCellP new];
    presenter.myNearShopTypeModel = model;
    return presenter;
}





//---------------------------------------------------------------------------------------------------
#pragma mark ================================== cell所需参数 ==================================
//---------------------------------------------------------------------------------------------------
-(NSString *)categotyTitle
{
    return _myNearShopTypeModel.TypeName;
}



-(NSString *)categotyID
{
    return _myNearShopTypeModel.TypeID;
}




@end
