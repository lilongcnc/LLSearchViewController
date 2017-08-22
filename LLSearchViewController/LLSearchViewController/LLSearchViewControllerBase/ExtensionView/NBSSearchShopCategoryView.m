//
//  NBSSearchShopCategoryView.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/12.
//
//

#import "NBSSearchShopCategoryView.h"
#import "HistoryAndCategorySearchCategoryViewP.h"
#import "NBSSearchShopCategoryViewCellP.h"
#import "LLTagViewUtils.h"
#import "UIView+LLRect.h"
#import "LLSearchVCConst.h"
#import "UIColor+LLHex.h"


@interface NBSSearchShopCategoryView ()

@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UIButton *rightMoreBtn;
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) HistoryAndCategorySearchCategoryViewP *shopCategoryViewP;
@property (nonatomic,copy) categoryTagonClickBlock myOnCickBlock;

@end

@implementation NBSSearchShopCategoryView{
    CGFloat leadPadding;
    CGFloat trailPadding;
    CGFloat topPadding;
    
    CGFloat leftTitleBtnHeight;
    
    CGFloat shopCategoryViewLTPadding;
    CGFloat shopCategoryCoverViewLTPadding;
    CGFloat shopCategoryCoverViewTopPadding;
    CGFloat shopCategoryCoverViewWidth;
    
    CGFloat categoryTagViewHeight;
    
    CGFloat categoryViewHeight;
    
    BOOL _isShowAllCategory; //是否展开显示全部分类
    
    LLTagViewUtils *tagViewUtils;
}



//初始化
+ (instancetype)searchShopCategoryViewWithPresenter:(HistoryAndCategorySearchCategoryViewP *)presenter WithFrame:(CGRect)rect{
    NBSSearchShopCategoryView *categoryView = [[NBSSearchShopCategoryView alloc] initWithFrame:rect];
    categoryView.shopCategoryViewP = presenter;
    return categoryView;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //初始化设置参数
        [self initialization];
        
        self.clipsToBounds = YES;

        //添加子控件
        [self addSubview:self.leftTitleLabel];
        [self addSubview:self.rightMoreBtn];
        [self addSubview:self.coverView];
        
    }
    return self;
}

static CGFloat shopCategoryViewNotOpenHeight = 0;//分类模块未展开时的初始高度
static CGFloat shopCategoryViewOpenHeight = 0;//展开时的高度

- (void)initialization
{
    
    //设置背景色
    //        self.backgroundColor = ZYHTBaseColorOfBackgorundView;
//    self.backgroundColor = [UIColor cyanColor];
    
    
    //初始化计量值
    leadPadding = 13;
    trailPadding = 13;
    topPadding = 16;
    
    leftTitleBtnHeight = 15;
    
    categoryTagViewHeight = 33;
    
    // cover view of categoryView
    shopCategoryCoverViewLTPadding = leadPadding;
    shopCategoryViewLTPadding = 10;
    shopCategoryCoverViewTopPadding = 15;
    shopCategoryCoverViewWidth = ZYHT_ScreenWidth - shopCategoryCoverViewLTPadding*2;
    
    
    //not open
    shopCategoryViewNotOpenHeight = topPadding+leftTitleBtnHeight + shopCategoryCoverViewTopPadding + categoryTagViewHeight;
    

}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.leftTitleLabel.frame = CGRectMake(leadPadding, topPadding, 50, leftTitleBtnHeight);
    self.rightMoreBtn.frame = CGRectMake(self.width-50-trailPadding, topPadding, 50, 50);
    self.rightMoreBtn.centerY = self.leftTitleLabel.centerY;


    //open cayegotyView height
    shopCategoryViewOpenHeight = shopCategoryViewNotOpenHeight + categoryViewHeight - categoryTagViewHeight;
    
    //分类展示view
    self.coverView.frame = CGRectMake(leadPadding,self.leftTitleLabel.bottom+shopCategoryCoverViewTopPadding, shopCategoryCoverViewWidth, categoryViewHeight);
    
    if (!_isShowAllCategory)
    {
        self.height = shopCategoryViewNotOpenHeight;
    }
    else
    {
        self.height = shopCategoryViewOpenHeight;
    }
    
    
    //通知高度更新
    !self.modifyFrameBlock?:self.modifyFrameBlock(self.frame);
}


- (UIView *)coverView
{
    if (!_coverView) {
        UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,shopCategoryCoverViewWidth,0}];
        view.backgroundColor = [UIColor whiteColor];
        view.clipsToBounds = YES;
        _coverView = view;
    }
    return _coverView;
}


- (UILabel *)leftTitleLabel
{
    if (!_leftTitleLabel) {
        
        UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectZero];
        labelName.text = @"分类";
        labelName.font = ZYHT_F_MediumFontOfSize(14);
        labelName.textColor = [UIColor colorWithHexString:@"111111"];
        _leftTitleLabel = labelName;
        
    }
    return _leftTitleLabel;
}

- (UIButton *)rightMoreBtn
{
    if (!_rightMoreBtn) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button  setTitle:@"更多" forState:UIControlStateNormal];
        button.titleLabel.font = ZYHT_F_MediumFontOfSize(13);
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button setTitleColor:[UIColor colorWithHexString:@"b2b2b2"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightMoreBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _rightMoreBtn = button;
    }
    return _rightMoreBtn;
}

- (void)rightMoreBtnOnClick
{
    //展开更多分类
    [self openShopCategoryView];
}

//复制数据
- (void)setupCategoryViewAndData
{
    tagViewUtils = [LLTagViewUtils new];
    [tagViewUtils setupRectangleTagsInView:self.coverView tagTexts:[self.shopCategoryViewP allCategotyTypeTitles] maxColumnNum:4 tagHeight:33];
    
    /*
     rowNumber = [LLTools getRowNumberWithTotalCount:(int)self.shopCategoryViewP.allCategotyTypeData.count columnNumber:columnShowNumber];
     categoryViewHeight = rowNumber*categoryTagViewHeight;
    */
    categoryViewHeight = self.coverView.height;
    
    @LLWeakObj(self);
    [tagViewUtils tagLabelOnClick:^(UITapGestureRecognizer *tapGes, UILabel *tagLabel) {
        @LLStrongObj(self);
//        NSLog(@"%s-->%@--->%zd",__FUNCTION__,tagLabel.text,tagLabel.tag);
        if (tagLabel.tag <= self.shopCategoryViewP.allCategotyTypeData.count) {
            NBSSearchShopCategoryViewCellP *cellP = self.shopCategoryViewP.allCategotyTypeData[tagLabel.tag];
            !_myOnCickBlock ? :_myOnCickBlock(cellP);
        }

    }];
}


//---------------------------------------------------------------------------------------------------
#pragma mark ================================= 私有方法 ==================================
//---------------------------------------------------------------------------------------------------
- (void)openShopCategoryView
{
    _isShowAllCategory = !_isShowAllCategory;
    
    [self layoutSubviews];
}


//-----------------------------------------------------------------------------------------------------------
#pragma mark ================ 接口 ================
//-----------------------------------------------------------------------------------------------------------


-(void)reloadData
{
    [self setupCategoryViewAndData];
}

- (void)categoryTagonClick:(categoryTagonClickBlock)clickBlock {
    _myOnCickBlock = clickBlock;
}


@end
