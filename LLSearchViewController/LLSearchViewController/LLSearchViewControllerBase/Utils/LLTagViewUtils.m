//
//  LLTagViewUtils.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/13.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "LLTagViewUtils.h"
#import "UIView+LLRect.h"



#define LLTagViewUtils_COLORPolRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:(1.0)]
#define LLTagViewUtils_COLOR(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define PYSEARCH_REALY_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width



@interface LLTagViewUtils ()

/**
 The element of popular search
 */
@property (nonatomic, strong) NSMutableArray<UILabel *> *tagLabelArray;
@property (nonatomic, strong) NSArray<NSString *> *tagLabelTitleArray;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic,copy) tagLabelOnClickBlock myOnCickBlock;

@property (nonatomic, strong) NSArray<UILabel *> *rankTextLabels;
@property (nonatomic, strong) NSArray<UILabel *> *rankTagIndexs;
@property (nonatomic, strong) NSArray<UIView *> *rankViews;
@end

@implementation LLTagViewUtils



//---------------------------------------------------------------------------------------------------
#pragma mark ================================== 接口 ==================================
//---------------------------------------------------------------------------------------------------

- (void)tagLabelOnClick:(tagLabelOnClickBlock)clickBlock {
    _myOnCickBlock = clickBlock;
}





- (NSArray *)setupCommonTagsInView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts margin:(CGFloat)margin tagHeight:(CGFloat)tagHeight
{
    return [self zyht_setupCommonTagsInView:contentView tagTexts:tagTexts margin:margin tagHeight:(CGFloat)tagHeight];
}

- (void)setupRectangleTagsInView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts maxColumnNum:(int)maxColumnNum tagHeight:(CGFloat)tagHeight
{
    return [self zyht_setupRectangleTagsInView:contentView tagTexts:tagTexts maxColumnNum:maxColumnNum tagHeight:tagHeight];
}

- (void)setupRankTagsInView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts tagHeight:(CGFloat)tagHeight padding:(CGFloat)padding tagViewMargin:(CGFloat)tagViewMargin{
    return [self zyht_setupRankTagsInView:contentView tagTexts:tagTexts tagHeight:tagHeight padding:padding tagViewMargin:tagViewMargin];
}



//---------------------------------------------------------------------------------------------------
#pragma mark ================================== 绘制方法 ==================================
//---------------------------------------------------------------------------------------------------


- (NSArray *)zyht_setupCommonTagsInView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts margin:(CGFloat)margin tagHeight:(CGFloat)tagHeight
{
    
    self.contentView = contentView;
    self.tagLabelTitleArray = tagTexts;
    
//    [contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < tagTexts.count; i++) {
        UILabel *label = [self labelWithTitle:tagTexts[i]];
        label.height = tagHeight;
        label.tag = i; //区分点击的重要标记
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [contentView addSubview:label];
        [self.tagLabelArray addObject:label];
    }
    
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat countRow = 0;
    CGFloat countCol = 0;
    
    for (int i = 0; i < contentView.subviews.count; i++) {
        UILabel *subView = contentView.subviews[i];
        // When the number of search words is too large, the width is width of the contentView
        if (subView.width > contentView.width) subView.width = contentView.width;
        if (currentX + subView.width + margin * countRow > contentView.width) {
            subView.x = 0;
            subView.y = (currentY += subView.height) + margin * ++countCol;
            currentX = subView.width;
            countRow = 1;
        } else {
            subView.x = (currentX += subView.width) - subView.width + margin * countRow;
            subView.y = currentY + margin * countCol;
            countRow ++;
        }
    }
    
    contentView.height = CGRectGetMaxY(contentView.subviews.lastObject.frame);
    
    return  self.tagLabelArray;
}


-(void)setCommonTagStyle:(ZYHTCommonTagStyle)commonTagStyle{
    
    _commonTagStyle = commonTagStyle;
    switch (commonTagStyle) {
        case ZYHTCommonTagStyleColorfulTag:
            for (UILabel *tag in self.tagLabelArray) {
                tag.textColor = [UIColor whiteColor];
                tag.layer.borderColor = nil;
                tag.layer.borderWidth = 0.0;
                tag.backgroundColor = LLTagViewUtils_COLORPolRandomColor;
            }
            break;
        case ZYHTCommonTagStyleBorderTag:
            for (UILabel *tag in self.tagLabelArray) {
                tag.backgroundColor = [UIColor clearColor];
                tag.layer.borderColor = LLTagViewUtils_COLOR(223, 223, 223).CGColor;
                tag.layer.borderWidth = 0.5;
            }
            break;
        case ZYHTCommonTagStyleARCBorderTag:
            for (UILabel *tag in self.tagLabelArray) {
                tag.backgroundColor = [UIColor clearColor];
                tag.layer.borderColor = LLTagViewUtils_COLOR(223, 223, 223).CGColor;
                tag.layer.borderWidth = 0.5;
                tag.layer.cornerRadius = tag.height * 0.5;
            }
            break;
        case ZYHTCommonTagStyleNormalWhiteTag:
            for (UILabel *tag in self.tagLabelArray) {
                tag.backgroundColor = [UIColor whiteColor];
                tag.textColor = LLTagViewUtils_COLOR(17, 17, 17);
            }
            break;
            //        case PYHotSearchStyleRankTag:
            //            self.rankTagBackgroundColorHexStrings = nil;
            //            break;
            
        default:
            break;
    }
}




- (void)zyht_setupRectangleTagsInView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts maxColumnNum:(int)maxColumnNum tagHeight:(CGFloat)tagHeight
{
    
    //设置tag标签
    CGFloat rectangleTagH = tagHeight;
    for (int i = 0; i < tagTexts.count; i++) {
        UILabel *rectangleTagLabel = [[UILabel alloc] init];
        rectangleTagLabel.userInteractionEnabled = YES;
        rectangleTagLabel.font = [UIFont systemFontOfSize:14];
        rectangleTagLabel.textColor = LLTagViewUtils_COLOR(18, 18, 18);
//        rectangleTagLabel.backgroundColor = [UIColor clearColor];
        rectangleTagLabel.text = tagTexts[i];
        rectangleTagLabel.width = contentView.width / maxColumnNum;
        rectangleTagLabel.height = rectangleTagH;
        rectangleTagLabel.textAlignment = NSTextAlignmentCenter;
        [rectangleTagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        rectangleTagLabel.x = rectangleTagLabel.width * (i % maxColumnNum);
        rectangleTagLabel.y = rectangleTagLabel.height * (i / maxColumnNum);
        rectangleTagLabel.tag = i; //区分点击的重要标记

        [contentView addSubview:rectangleTagLabel];
        [self.tagLabelArray addObject:rectangleTagLabel];
    }
    

    
    contentView.height = CGRectGetMaxY(contentView.subviews.lastObject.frame);

    //设置分割线
    int rowNumber = [self getRowNumberWithTotalCount:(int)tagTexts.count columnNumber:maxColumnNum];
    CGFloat verticalLineHeight = rectangleTagH-10;
    CGFloat tbPadding = (rectangleTagH-verticalLineHeight)*0.5;
    for (int colIndex = 0; colIndex < maxColumnNum - 1; colIndex++) {
        
        for (int rowIndex = 0; rowIndex < rowNumber; rowIndex++) {
            UIImageView *verticalLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-content-line-vertical"]];
            verticalLine.height = verticalLineHeight;
            verticalLine.y = rectangleTagH*rowIndex + tbPadding;
            verticalLine.alpha = 0.7;
            verticalLine.x = contentView.width / maxColumnNum * (colIndex + 1);
            verticalLine.width = 0.5;
            [contentView addSubview:verticalLine];
        }
    }
    
    for (int i = 0; i < ceil(((double)tagTexts.count / maxColumnNum)) - 1; i++) {
        UIImageView *verticalLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-content-line"]];
        verticalLine.height = 0.5;
        verticalLine.alpha = 0.7;
        verticalLine.y = rectangleTagH * (i + 1);
        verticalLine.width = contentView.width;
        [contentView addSubview:verticalLine];
    }
}













- (void)zyht_setupRankTagsInView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts tagHeight:(CGFloat)tagHeight padding:(CGFloat)padding tagViewMargin:(CGFloat)tagViewMargin
{
    
    NSMutableArray *rankTextLabelsArr = [NSMutableArray array]; //文字数组
    NSMutableArray *rankTagIndexArr = [NSMutableArray array]; //序号数组
    NSMutableArray<UIView *> *rankViewArr = [NSMutableArray<UIView *> array];
    for (int i = 0; i < tagTexts.count; i++) {
        UIView *rankView = [[UIView alloc] init];
        rankView.height = tagHeight;
        rankView.width = (contentView.width-tagViewMargin) * 0.5;
        rankView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addSubview:rankView];
        
        // rank tag
        UILabel *rankIndexTag = [[UILabel alloc] init];
        rankIndexTag.textAlignment = NSTextAlignmentCenter;
        rankIndexTag.font = [UIFont systemFontOfSize:10];
        rankIndexTag.layer.cornerRadius = 3;
        rankIndexTag.clipsToBounds = YES;
        rankIndexTag.text = [NSString stringWithFormat:@"%d", i + 1];
        [rankIndexTag sizeToFit];
        rankIndexTag.width = rankIndexTag.height += padding * 0.5;
        rankIndexTag.y = (rankView.height - rankIndexTag.height) * 0.5;
        [rankView addSubview:rankIndexTag];
        [rankTagIndexArr addObject:rankIndexTag];
        
        // rank text
        UILabel *rankTextLabel = [[UILabel alloc] init];
        rankTextLabel.text = tagTexts[i];
        rankTextLabel.userInteractionEnabled = YES;
        [rankTextLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        rankTextLabel.tag = i;
        rankTextLabel.textAlignment = NSTextAlignmentLeft;
        rankTextLabel.backgroundColor = [UIColor clearColor];
        rankTextLabel.textColor = LLTagViewUtils_COLOR(113, 113, 113);
        rankTextLabel.font = [UIFont systemFontOfSize:14];
        rankTextLabel.x = CGRectGetMaxX(rankIndexTag.frame) + padding;
        rankTextLabel.width = rankView.width - rankTextLabel.x;
        
        rankTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        rankTextLabel.height = rankView.height;
        [rankTextLabelsArr addObject:rankTextLabel];
        [rankView addSubview:rankTextLabel];
        
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-content-line"]];
        line.height = 0.5;
        line.alpha = 0.7;
        line.x = 0;
        line.y = rankView.height - 1;
        line.width = rankView.width;
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [rankView addSubview:line];//分割线
        [rankViewArr addObject:rankView];//
        
        // set tag's background color and text color
        switch (i) {
            case 0: // NO.1
                rankIndexTag.backgroundColor = LLTagViewUtils_COLORPolRandomColor;
                rankIndexTag.textColor = [UIColor whiteColor];
                break;
            case 1: // NO.2
                rankIndexTag.backgroundColor = LLTagViewUtils_COLORPolRandomColor;
                rankIndexTag.textColor = [UIColor whiteColor];
                break;
            case 2: // NO.3
                rankIndexTag.backgroundColor = LLTagViewUtils_COLORPolRandomColor;
                rankIndexTag.textColor = [UIColor whiteColor];
                break;
            default: // Other
                rankIndexTag.backgroundColor = LLTagViewUtils_COLOR(235, 235, 235);
                rankIndexTag.textColor = LLTagViewUtils_COLOR(18, 18, 18);
                break;
        }
    }
    
    
    self.rankTextLabels = [NSArray arrayWithArray:rankTextLabelsArr];
    self.rankTagIndexs = [NSArray arrayWithArray:rankTagIndexArr];
    self.rankViews = [NSArray arrayWithArray:rankViewArr];
    
    for (int i = 0; i < rankViewArr.count; i++) { // default is two column
        UIView *rankView = rankViewArr[i];
        rankView.x = (tagViewMargin + rankView.width) * (i % 2);
        rankView.y = rankView.height * (i / 2);
    }
    
    contentView.height = CGRectGetMaxY(rankViewArr.lastObject.frame);
}


//---------------------------------------------------------------------------------------------------
#pragma mark ================================== 私有方法 ==================================
//---------------------------------------------------------------------------------------------------
- (NSMutableArray<UILabel *> *)tagLabelArray
{
    if (!_tagLabelArray) {
        _tagLabelArray = [[NSMutableArray<UILabel *>  alloc] init];
    }
    return _tagLabelArray;
}



- (NSArray<NSString *> *)tagLabelTitleArray
{
    if (!_tagLabelTitleArray) {
        _tagLabelTitleArray = [[NSArray<NSString *> alloc] init];
    }
    return _tagLabelTitleArray;
}

- (int)getRowNumberWithTotalCount:(int)count columnNumber:(int)columnNumber {
    return count/columnNumber+(count%columnNumber==0?0:1);
}

- (void)tagDidCLick:(UITapGestureRecognizer *)tapGesture{
    !_myOnCickBlock ? :_myOnCickBlock(tapGesture,(UILabel *)tapGesture.view);
}

- (UILabel *)labelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:12];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.backgroundColor = LLTagViewUtils_COLOR(250, 250, 250);
    label.layer.cornerRadius = 3;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.width += 20;
    label.height += 14;
    return label;
}



@end
