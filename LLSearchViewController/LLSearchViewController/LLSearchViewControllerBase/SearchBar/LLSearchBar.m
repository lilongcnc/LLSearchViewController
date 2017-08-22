//
//  LLSearchBar.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/7/12.
//
//

#import "LLSearchBar.h"

@implementation LLSearchBar

- (instancetype)initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage placeholderColor:(UIColor *)placeholderColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.hasCentredPlaceholder = YES;
        self.leftImage = leftImage;
        self.placeholderColor = placeholderColor;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 通过遍历self.subviews找到searchField
    UITextField *searchField;
    NSUInteger numViews = [self.subviews count];
    for(int i = 0;i < numViews; i++) {
        if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) {
            searchField = [self.subviews objectAtIndex:i];
        }
    }
    // 如果上述方法找不到searchField,试试下面的方法
    if (searchField == nil) {
        NSArray *arraySub = [self subviews];
        UIView *viewSelf = [arraySub objectAtIndex:0];
        NSArray *arrayView = [viewSelf subviews];
        for(int i = 0;i < arrayView.count; i++) {
            if([[arrayView objectAtIndex:i] isKindOfClass:[UITextField class]]) {
                searchField = [arrayView objectAtIndex:i];
            }
        }
    }
    if (searchField) {
        [searchField setBorderStyle:UITextBorderStyleNone];
        //placeHolder颜色
        [searchField setValue:_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
        searchField.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        searchField.textColor = _textColor;
        
        //字体大小
        [searchField setValue:_placeHolderFont forKeyPath:@"_placeholderLabel.font"];
        searchField.font = _textFont;
        
        
        UIImage *image = _leftImage;
        UIImageView *leftImg = [[UIImageView alloc] initWithImage:image];
        leftImg.frame = CGRectMake(0,0,image.size.width, image.size.height);
        searchField.leftView = leftImg;
    }
    
    //修改字体
    
}


#pragma mark - Methods

- (void)setHasCentredPlaceholder:(BOOL)hasCentredPlaceholder {
    _hasCentredPlaceholder = hasCentredPlaceholder;
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&_hasCentredPlaceholder atIndex:2];
        [invocation invoke];
    }
}

-(void)setIsHideClearButton:(BOOL)isHideClearButton
{
    _isHideClearButton = isHideClearButton;
    if (_isHideClearButton) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 1) {
                if ( [[view.subviews objectAtIndex:1] isKindOfClass:[UITextField class]]) {
                    UITextField *textField = (UITextField *)[view.subviews objectAtIndex:1];
                    [textField setClearButtonMode:UITextFieldViewModeNever];    // 不需要出现clearButton
                }
                break;
            }
        }
    }
}

@end
