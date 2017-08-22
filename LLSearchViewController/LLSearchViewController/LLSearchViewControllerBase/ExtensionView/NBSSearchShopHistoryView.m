//
//  NBSSearchShopHistoryView.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/14.
//
//

#import "NBSSearchShopHistoryView.h"
#import "NBSSearchShopCategoryViewCellP.h"
#import "HistorySearchHistroyViewP.h"
#import "LLTagViewUtils.h"
#import "LLSearchVCConst.h"
#import "UIView+LLRect.h"
#import "UIColor+LLHex.h"



@interface NBSSearchShopHistoryView ()

@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UIButton *rightMoreBtn;
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) HistorySearchHistroyViewP *historyTagViewP;
@property (nonatomic,copy) historyTagonClickBlock myOnCickBlock;

@end

@implementation NBSSearchShopHistoryView{
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
    
    LLTagViewUtils *tagViewUtils;
}



//初始化
+ (instancetype)searchShopCategoryViewWithPresenter:(HistorySearchHistroyViewP *)presenter WithFrame:(CGRect)rect
{
    NBSSearchShopHistoryView *categoryView = [[NBSSearchShopHistoryView alloc] initWithFrame:rect];
    categoryView.historyTagViewP = presenter;
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

- (void)initialization
{
    
    //设置背景色
    //        self.backgroundColor = ZYHTBaseColorOfBackgorundView;
//    self.backgroundColor = [UIColor yellowColor];
    
    
    //初始化计量值
    leadPadding = 13;
    trailPadding = 13;
    topPadding = 20;
    
    leftTitleBtnHeight = 15;
    
    categoryTagViewHeight = 33;
    
    // cover view of categoryViewLLSearchVCConst
    shopCategoryCoverViewLTPadding = leadPadding;
    shopCategoryViewLTPadding = 10;
    shopCategoryCoverViewTopPadding = 15;
    shopCategoryCoverViewWidth = ZYHT_ScreenWidth - shopCategoryCoverViewLTPadding*2;
    
    
    //not open
    shopCategoryViewNotOpenHeight = topPadding+leftTitleBtnHeight + shopCategoryCoverViewTopPadding + categoryTagViewHeight;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftTitleLabel.frame = CGRectMake(leadPadding, topPadding, 70, leftTitleBtnHeight);
    self.rightMoreBtn.frame = CGRectMake(self.width-70-trailPadding, topPadding, 70, 50);
    self.rightMoreBtn.centerY = self.leftTitleLabel.centerY;
    
    
    self.coverView.frame = CGRectMake(leadPadding,self.leftTitleLabel.bottom+shopCategoryCoverViewTopPadding, shopCategoryCoverViewWidth, categoryViewHeight);
    
    self.height = shopCategoryViewNotOpenHeight + categoryViewHeight - categoryTagViewHeight;
    
}


- (UIView *)coverView
{
    if (!_coverView) {
        UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,shopCategoryCoverViewWidth,0}];
//        view.backgroundColor = [UIColor clearColor];
        view.clipsToBounds = YES;
        _coverView = view;
    }
    return _coverView;
}



- (UILabel *)leftTitleLabel
{
    if (!_leftTitleLabel) {
        
        UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectZero];
        labelName.text = @"历史搜索";
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
        [button  setTitle:@"清除历史" forState:UIControlStateNormal];
        button.titleLabel.font = ZYHT_F_MediumFontOfSize(13);
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button setTitleColor:[UIColor colorWithHexString:@"b2b2b2"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _rightMoreBtn = button;
    }
    return _rightMoreBtn;
}


- (void)rightBtnOnClick{
    //展开更多分类
    [self clearAllHistoryData];
    
}

//复制数据
- (void)setuphistoryViewAndData
{
    tagViewUtils = [LLTagViewUtils new];
    [tagViewUtils setupCommonTagsInView:self.coverView tagTexts:[self.historyTagViewP getSearchCache] margin:10 tagHeight:29];
    
    categoryViewHeight = self.coverView.height;
    tagViewUtils.commonTagStyle = ZYHTCommonTagStyleNormalWhiteTag;
    
    [tagViewUtils tagLabelOnClick:^(UITapGestureRecognizer *tapGes, UILabel *tagLabel) {
        !_myOnCickBlock ? :_myOnCickBlock(tagLabel);
    }];
}


//---------------------------------------------------------------------------------------------------
#pragma mark ================================= 私有方法 ==================================
//---------------------------------------------------------------------------------------------------
- (void)clearAllHistoryData
{
    !self.clearHistoryBtnOnClick ? : self.clearHistoryBtnOnClick();
}


//-----------------------------------------------------------------------------------------------------------
#pragma mark ================ 接口 ================
//-----------------------------------------------------------------------------------------------------------


-(void)reloadData
{
    [self setuphistoryViewAndData];
}

-(void)historyTagonClick:(historyTagonClickBlock)clickBlock
{
    _myOnCickBlock = clickBlock;
}


@end
