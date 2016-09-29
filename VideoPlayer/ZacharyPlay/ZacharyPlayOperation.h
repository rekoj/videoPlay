//
//  zacharyPlayOperation.h
//  VideoPlayer
//
//  Created by zachary on 2016/9/29.
//  Copyright © 2016年 zachary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "ZacharyPlay.h"


@interface ZacharyPlayOperation : NSBlockOperation
{
    VideoCode videoBlock;
}
@property(nonatomic,strong)NSURL *url;
@property(nonatomic,assign)PlayType type;

-(void)startVithBlock:(VideoCode)video;
-(instancetype)initWithUrl:(NSURL *)url
               andPlayType:(PlayType)type;




@end
