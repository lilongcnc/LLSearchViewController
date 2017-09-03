//
//  LLSearchVCConst.h
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>
/*----------------------------------------------------------------------------------
 *                                手机尺寸信息                                       *
 ----------------------------------------------------------------------------------*/
// UIScreen width.
#define  ZYHT_ScreenWidth   [UIScreen mainScreen].bounds.size.width

// UIScreen height.
#define  ZYHT_ScreenHeight  [UIScreen mainScreen].bounds.size.height

// Status bar height.
#define  ZYHT_StatusBarHeight      20.f

// Navigation bar height.
#define  ZYHT_NavigationBarHeight  44.f

// Tabbar height.
#define  ZYHT_TabbarHeight         49.f

// Status bar & navigation bar height.
#define  ZYHT_StatusBarAndNavigationBarHeight   (20.f + 44.f)


/*----------------------------------------------------------------------------------
 *                                全局字体引用                                        *
 ----------------------------------------------------------------------------------*/
#define ZYHT_F_NormalFontOfSize(fontSize)      [UIFont systemFontOfSize:fontSize]
#define ZYHT_F_MediumFontOfSize(fontSize)      [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium]


/*----------------------------------------------------------------------------------
 *                      Block/Block-weak-strong避免循环引用                                *
 ----------------------------------------------------------------------------------*/
#define LLBLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); }

//#define LLWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
//#define LLStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

// 避免宏循环引用
#ifndef LLWeakObj
#if DEBUG
#if __has_feature(objc_arc)
#define LLWeakObj(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define LLWeakObj(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define LLWeakObj(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define LLWeakObj(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef LLStrongObj
#if DEBUG
#if __has_feature(objc_arc)
#define LLStrongObj(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define LLStrongObj(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define LLStrongObj(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define LLStrongObj(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif





/*----------------------------------------------------------------------------------
 *                                全局快捷代码                                        *
 ----------------------------------------------------------------------------------*/
// 自定义颜色
#define ZYHT_Q_RGBAColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
// 自定义颜色,alpha默认为1
#define ZYHT_Q_RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
// 随机颜色
#define ZYHT_Q_RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];



@interface LLSearchVCConst : NSObject



@end
