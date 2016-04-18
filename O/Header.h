//
//  Header.h
//  yo_parking
//
//  Created by zhanghangzhen on 16/4/14.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#ifndef Header_h
#define Header_h


 

#define screen_width     [UIScreen mainScreen].bounds.size.width
#define screen_height    [UIScreen mainScreen].bounds.size.height


#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width

#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define user_id     @"userId"





#endif /* Header_h */
