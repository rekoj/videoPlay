//
//  ZacharyPlay.h
//  VideoPlayer
//
//  Created by zachary on 2016/9/29.
//  Copyright © 2016年 zachary. All rights reserved.
//

#ifndef ZacharyPlay_h
#define ZacharyPlay_h

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define defaultFrame CGRectMake(0, 0, SCREEN_WIDTH, 200)
typedef NS_ENUM(NSInteger,PlayType)
{
    AtMostOnce,
    AtLeastOnce
    
};


typedef void(^VideoCode)(CGImageRef imageData);


#endif /* ZacharyPlay_h */




