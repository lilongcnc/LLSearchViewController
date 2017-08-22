//
//  LLTagViewUtils.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/13.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 style of CommonTags
 */
typedef NS_ENUM(NSInteger, ZYHTCommonTagStyle)  {
    ZYHTCommonTagStyleNormalTag,      // normal tag without border
    ZYHTCommonTagStyleColorfulTag,    // colorful tag without border, color of background is randrom and can be custom by `colorPol`
    ZYHTCommonTagStyleBorderTag,      // border tag, color of background is `clearColor`
    ZYHTCommonTagStyleARCBorderTag,   // broder tag with ARC, color of background is `clearColor`
    ZYHTCommonTagStyleNormalWhiteTag,
    ZYHTCommonTagStyleDefault = ZYHTCommonTagStyleNormalTag // default is `PYHotSearchStyleNormalTag`
};


typedef void (^tagLabelOnClickBlock)(UITapGestureRecognizer *tapGes,UILabel *tagLabel);

@interface LLTagViewUtils : NSObject


/**
 创建普通标签,可以通过ZYHTCommonTagStyle设置样式

 @param contentView 展示位置
 @param tagTexts 标签文字数组
 @param margin 标签间距
 @return 标签数组
 */
- (NSArray *)setupCommonTagsInView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts margin:(CGFloat)margin tagHeight:(CGFloat)tagHeight;

/**
 The style of CommonTags, default is `ZYHTCommonTagStyleNormalTag`.
 */
@property (nonatomic, assign) ZYHTCommonTagStyle commonTagStyle;



/**
 设置矩形布局样式

 @param contentView 展示位置
 @param tagTexts 标签文字数组
 @param maxColumnNum 展示列数
 @param tagHeight 标签的高度
 */
- (void)setupRectangleTagsInView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts maxColumnNum:(int)maxColumnNum tagHeight:(CGFloat)tagHeight;


/**
 设置行样式标签布局

 @param contentView 展示位置
 @param tagTexts 标签文字数组
 @param padding 序号标签和文字标签的内间距
 @param tagViewMargin 标签控件的外间距
 */
- (void)setupRankTagsInView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts tagHeight:(CGFloat)tagHeight padding:(CGFloat)padding tagViewMargin:(CGFloat)tagViewMargin ;


- (void)tagLabelOnClick:(tagLabelOnClickBlock)clickBlock;





@end
