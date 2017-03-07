//
//  Defines.h
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/11/15.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#if (DEBUG)
    #define NSLog(...) NSLog(__VA_ARGS__)
#else
    #define NSLog(...) {}
#endif

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//------------------方法简写----------------
/// 读取本地图片文件包含图片的获取方式(不采用 imageName:xxx方式, 这种方式会一直驻留内存无法及时释放) (PS: 不支付Images.xcassets中的图片)
#define LoadLocalImgByName(X)               ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[(X) stringByDeletingPathExtension] ofType:[(X) pathExtension]]])
/// 加载图片
#define UIImageByName(name)                 [UIImage imageNamed:name]

///颜色设置
#define UICOLOR_RGB(R,G,B)                  ([UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1])
#define UICOLOR_RGBA(R,G,B,A)               ([UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)])



///SVP
#define SHOW_SVP(title)                     ([SVProgressHUD showWithStatus:title])
