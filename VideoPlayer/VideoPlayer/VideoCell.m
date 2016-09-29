//
//  VideoCell.m
//  VideoPlayer
//
//  Created by eleme on 16/4/26.
//  Copyright © 2016年 zachary. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.playView=[[zacharyPlayView alloc]initWithPlayType:AtLeastOnce];
        [self.contentView addSubview: _playView];
        
    }
    return self;
}

-(void)setData:(id)cellData
{
    NSURL *url=[NSURL fileURLWithPath:cellData];
    [self.contentView addSubview:_playView];
    
    [_playView  playWithUrl:url];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
