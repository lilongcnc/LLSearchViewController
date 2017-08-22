//
//  LLSearchBar.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/12.
//
//

#import <UIKit/UIKit.h>

@interface LLSearchBar : UISearchBar

// 默认YES居中，通过设置NO，可居左
@property (nonatomic, assign, setter = setHasCentredPlaceholder:) BOOL hasCentredPlaceholder;

// searchField 左侧图片
@property (nonatomic, strong) UIImage *leftImage;

// placeholder颜色
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic,strong) UIFont *placeHolderFont;
@property (nonatomic,strong) UIFont *textFont;


- (instancetype)initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage placeholderColor:(UIColor *)placeholderColor;

@property (nonatomic,assign) BOOL isHideClearButton;


@end
