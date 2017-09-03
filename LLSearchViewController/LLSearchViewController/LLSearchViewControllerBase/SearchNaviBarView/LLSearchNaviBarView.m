//
//  LLSearchNaviBarView.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/12.
//
//

#import "LLSearchNaviBarView.h"
#import "LLSearchBar.h"
#import "LLSearchVCConst.h"
#import "UIView+LLRect.h"
#import "UIColor+LLHex.h"

@interface LLSearchNaviBarView ()<UISearchBarDelegate>

@property (nonatomic,strong) UIView *searchBgView;
@property (nonatomic,strong) UIImageView *searLogoIconV;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *rightOneBtn;

@property (nonatomic,copy) rightOneBtnOnClick rightBtnBlock;
@property (nonatomic,copy) backBtnOnClick backBtnBlock;
@property (nonatomic,copy) keyBoardSearchBtnOnClickBlock keyBoardSearchBtnBlock;
@property (nonatomic,copy) textofSearchBarDidChangeBlock textDidChangeBlock;
@property (nonatomic,strong) LLSearchBar *searchBar;

@end

@implementation LLSearchNaviBarView
{
    CGFloat searchBgViewH;
    CGFloat leftRightIconWH;
    CGFloat searchIconWH;
    CGFloat LeadMargin;
    CGFloat TrailMargin;
}


- (instancetype)init{
    if (self = [super init]) {
        
        leftRightIconWH = 44.f;
        searchIconWH = 15.f;
        LeadMargin = 13.f;
        TrailMargin = 13.f;
        searchBgViewH = 29;
        
        self.frame = CGRectMake(0, 0, ZYHT_ScreenWidth, ZYHT_StatusBarAndNavigationBarHeight);
        self.backgroundColor = ZYHT_Q_RGBColor(56, 153, 229);
        
        [self addSubview:self.rightOneBtn];
        [self addSubview:self.backBtn];
        [self addSubview:[self setupSearView]];
    }
    return self;
}

//---------------------------------------------------------------------------------------------------
#pragma mark ================================== 创建UI ==================================
//---------------------------------------------------------------------------------------------------

- (UIButton *)backBtn
{
    if (!_backBtn) {
        //左按钮
        _backBtn = ({
            UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ZYHT_StatusBarHeight, leftRightIconWH, leftRightIconWH)];
            [backBtn setImage:[UIImage imageNamed:@"navi_back_w"] forState:UIControlStateNormal];
            [backBtn addTarget:self action:@selector(backBtnOnCLick:) forControlEvents:UIControlEventTouchUpInside];
            backBtn.hidden = YES;
            backBtn;
        });
    }
    return _backBtn;
}




- (UIButton *)rightOneBtn
{
    if (!_rightOneBtn) {

        _rightOneBtn = ({
            UIButton *rightOneBtn = [[UIButton alloc] initWithFrame:CGRectMake(ZYHT_ScreenWidth-leftRightIconWH, ZYHT_StatusBarHeight, leftRightIconWH, leftRightIconWH)];
            rightOneBtn.titleLabel.font = ZYHT_F_NormalFontOfSize(13);
            [rightOneBtn addTarget:self action:@selector(rightOneBtnOnCkick:) forControlEvents:UIControlEventTouchUpInside];
            rightOneBtn.hidden = YES;
            rightOneBtn;
        });
    }
    return _rightOneBtn;
}


- (UIView *)setupSearView
{

    self.searchBgView = ({
        UIView *searchBgView = [[UIView alloc] initWithFrame:CGRectMake(LeadMargin, ZYHT_StatusBarHeight+(ZYHT_NavigationBarHeight-searchBgViewH)*0.5, ZYHT_ScreenWidth-TrailMargin-LeadMargin, searchBgViewH)];
        searchBgView.layer.cornerRadius = searchBgView.bounds.size.height*0.5;
        searchBgView.backgroundColor = ZYHT_Q_RGBAColor(255,255,255,0.3);
        searchBgView.clipsToBounds = YES;
        searchBgView;
    });
   
    self.searLogoIconV = ({
        UIImageView *searLogoIconV = [[UIImageView alloc] initWithFrame:(CGRect){CGRectGetWidth(self.searchBgView.frame)-searchBgViewH*0.5-searchIconWH, 0, searchIconWH, searchIconWH}];
        searLogoIconV.image =  [UIImage imageNamed:@"search"];
        searLogoIconV.centerY = self.searchBgView.centerYInSelf;
        searLogoIconV.hidden = YES;
        searLogoIconV;
    });
    

    self.searchBar = ({
        LLSearchBar *searchBar = [[LLSearchBar alloc] initWithFrame:CGRectMake(5, 0, self.searchBgView.bounds.size.width-10, self.searchBgView.bounds.size.height)];
        searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
        searchBar.delegate = self;
        // searchNaviBarViewDefault 情况下参数
        searchBar.placeholderColor = [UIColor whiteColor];
        searchBar.textFont = ZYHT_F_NormalFontOfSize(12);
        searchBar.placeHolderFont = ZYHT_F_NormalFontOfSize(12);
        
        searchBar.hasCentredPlaceholder = NO;
        searchBar.isHideClearButton = YES;
        [searchBar setShowsCancelButton:NO];
        searchBar;
    });

    
    [self.searchBgView addSubview:self.searLogoIconV];
    [self.searchBgView addSubview:self.searchBar];
    
    return self.searchBgView;
}


//---------------------------------------------------------------------------------------------------
#pragma mark ================================== LLSearchBarDelegate ==================================
//---------------------------------------------------------------------------------------------------
- (BOOL)searchBarShouldBeginEditing:(LLSearchBar *)searchBar
{
    LLBLOCK_EXEC(_searchBarBeignOnClickBlock);
    return YES;
}

- (void)searchBarSearchButtonClicked:(LLSearchBar *)searchBar
{
    LLBLOCK_EXEC(_keyBoardSearchBtnBlock,searchBar);
}

- (void)searchBar:(LLSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    LLBLOCK_EXEC(self.textDidChangeBlock,searchBar,searchText);
}


//---------------------------------------------------------------------------------------------------
#pragma mark ================================== 私有方法 ==================================
//---------------------------------------------------------------------------------------------------
- (void)rightOneBtnOnCkick:(UIButton *)btn
{
    LLBLOCK_EXEC(_rightBtnBlock,btn);
}


- (void)modifySearchBarViewFrame
{
    if (!_backBtn.hidden && !_rightOneBtn.hidden) {
        self.searchBgView.x = self.backBtn.width;
        self.searchBgView.width = ZYHT_ScreenWidth-self.backBtn.width-self.rightOneBtn.width;
    }
    else if (_backBtn.hidden && !_rightOneBtn.hidden)
    {
        self.searchBgView.x = LeadMargin;
        self.searchBgView.width = ZYHT_ScreenWidth-LeadMargin-self.rightOneBtn.width;
    }
    else if (!_backBtn.hidden && _rightOneBtn.hidden)
    {
        self.searchBgView.x = self.backBtn.width;
        self.searchBgView.width = ZYHT_ScreenWidth-TrailMargin-self.backBtn.width;
    }
    
    
    self.searLogoIconV.x = self.searchBgView.width -searchBgViewH*0.5-searchIconWH;
    self.searchBar.width = self.searchBgView.bounds.size.width-10;
}

- (void)backBtnOnCLick:(UIButton *)btn
{
    LLBLOCK_EXEC(_backBtnBlock,btn);
}


//---------------------------------------------------------------------------------------------------
#pragma mark ================================== 接口 ==================================
//---------------------------------------------------------------------------------------------------
- (void)showRightOneBtnWith:(UIImage *)image onClick:(rightOneBtnOnClick)btnBlock
{
    _rightBtnBlock = btnBlock;
    _rightOneBtn.hidden = NO;
    [_rightOneBtn setImage:image forState:UIControlStateNormal];
    
    [self modifySearchBarViewFrame];
}

-(void)showbackBtnWith:(UIImage *)image onClick:(backBtnOnClick)btnBlock
{
    _backBtnBlock = btnBlock;
    _backBtn.hidden = NO;
    
    if (image)
        [_backBtn setImage:image forState:UIControlStateNormal];
    
    [self modifySearchBarViewFrame];
}

- (void)showRightOneBtnWithTitle:(NSString *)title onClick:(rightOneBtnOnClick)btnBlock {
    _rightBtnBlock = btnBlock;
    _rightOneBtn.hidden = NO;
    [_rightOneBtn setTitle:title forState:UIControlStateNormal];
    
    [self modifySearchBarViewFrame];
}



-(void)setRightOneBtnIconImage:(UIImage *)rightOneBtnIconImage
{
    [_rightOneBtn setImage:rightOneBtnIconImage forState:UIControlStateNormal];
}


-(void)setBackBtnIconImage:(UIImage *)backBtnIconImage
{
    if (backBtnIconImage)
        [_backBtn setImage:backBtnIconImage forState:UIControlStateNormal];
}



-(void)setSearbarPlaceHolder:(NSString *)searbarPlaceHolder
{
    self.searchBar.placeholder = searbarPlaceHolder;
}


-(void)setIsHideSearchBarRightIcon:(BOOL)isHideSearchBarRightIcon
{
    self.searLogoIconV.hidden = isHideSearchBarRightIcon;
}


-(void)setSearchBarRightIconImage:(UIImage *)searchBarRightIconImage
{
    if (!self.searLogoIconV.hidden) {
        self.searLogoIconV.image = searchBarRightIconImage;
    }
}

-(LLSearchBar *)naviSearchBar{
    return self.searchBar;
}

-(void)setSearchNaviBarViewType:(LLSearchNaviBarViewType)searchNaviBarViewType{
    _searchNaviBarViewType = searchNaviBarViewType;
    
    switch (searchNaviBarViewType) {
        case searchNaviBarViewDefault:
            break;
        case searchNaviBarViewWhiteAndGray:
        {
            self.backgroundColor = [UIColor whiteColor];
            self.searchBgView.backgroundColor = ZYHT_Q_RGBAColor(245, 245, 245, 1);
            self.searchBar.backgroundColor = ZYHT_Q_RGBAColor(245, 245, 245, 1);
            self.searchBar.placeholderColor = [UIColor colorWithHexString:@"686a6f"];
            [_rightOneBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            
            //增加下划线
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-0.5, ZYHT_ScreenWidth, 0.5)];
            view.backgroundColor = [UIColor colorWithHexString:@"d6d7dc"];
            [self addSubview:view];
        }
            break;
        default:
            break;
    }

}

- (void)keyBoardSearchBtnOnClick:(keyBoardSearchBtnOnClickBlock)searchBtnOnClickBlock {
    _keyBoardSearchBtnBlock = searchBtnOnClickBlock;
}

/**
 搜索框框输入文字之后的即时变化
 */
- (void)textOfSearchBarDidChangeBlock:(textofSearchBarDidChangeBlock)textofSearchBarDidChangeBlock
{
    _textDidChangeBlock = textofSearchBarDidChangeBlock;
}

@end
