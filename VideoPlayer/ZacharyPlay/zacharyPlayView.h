//
//  zacharyPlayView.h
//  VideoPlayer
//
//  Created by zachary on 2016/9/29.
//  Copyright © 2016年 zachary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZacharyPlayOperation.h"

@interface zacharyPlayView : UIView
{
}


@property(nonatomic,strong)NSURL *url;
@property(nonatomic,readonly)PlayType playType;




-(instancetype)initWithPlayType:(PlayType)type;

-(instancetype)initWithVideoUrl:(NSURL *)url;


-(instancetype)initWithVideoUrl:(NSURL *)url
                       andFrame:(CGRect)frame;



-(instancetype)initWithVideoUrl:(NSURL *)url
                    andPlayType:(PlayType)type;

-(instancetype)initWithVideoUrl:(NSURL *)url
                       andFrame:(CGRect)frame
                   exraPlayType:(PlayType)type;



-(void)playWithUrl:(NSURL *)url;


@end
