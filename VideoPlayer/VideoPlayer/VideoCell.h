//
//  VideoCell.h
//  VideoPlayer
//
//  Created by eleme on 16/4/26.
//  Copyright © 2016年 zachary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zacharyPlayView.h"
#define VIEW_SCREEN [UIScreen mainScreen]
#define baseVideoWidth (VIEW_SCREEN.bounds.size.width)
#define VIDEO_SIZE_RATE (4.0 / 3.0)
#define baseVideoHeight (baseVideoWidth / VIDEO_SIZE_RATE)

@interface VideoCell : UITableViewCell
@property(nonatomic,strong)NSString *filePath;
@property(nonatomic,strong)zacharyPlayView *playView;



-(void)setData:(id)cellData;


@end
