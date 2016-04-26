//
//  VideoCell.m
//  VideoPlayer
//
//  Created by eleme on 16/4/26.
//  Copyright © 2016年 zachary. All rights reserved.
//

#import "VideoCell.h"
#import "ZacharyPlayManager.h"

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setData:(id)cellData
{
    if ([cellData isKindOfClass:[NSString class]]) {
        self.filePath=cellData;
        [self reloadStart];
        
        
    }

}

-(void)startVideo
{
    __weak typeof(self) weakSelf=self;
    
    [[ZacharyPlayManager sharedInstance]startWithLocalPath:_filePath WithVideoBlock:^(CGImageRef imageData, NSString *filePath) {
        // NSLog(@"%@",filePath);
        if ([filePath isEqualToString:_filePath]) {
            weakSelf.contentView.layer.contents=(__bridge id _Nullable)(imageData);
            
        }
        
        
        
    }];
    
    
    
}

//Repeat play
-(void)reloadStart
{
    __weak typeof(self) weakSelf=self;
    [[ZacharyPlayManager sharedInstance]startWithLocalPath:_filePath WithVideoBlock:^(CGImageRef imageData, NSString *filePath) {
        if ([filePath isEqualToString:weakSelf.filePath]) {
            weakSelf.contentView.layer.contents=(__bridge id _Nullable)(imageData);
            
        }
        
        
        
    }];
    
    [[ZacharyPlayManager sharedInstance]reloadVideo:^(NSString *filePath) {
        MAIN(^{
            if ([filePath isEqualToString:weakSelf.filePath]) {
                [weakSelf reloadStart];
                
                
                
                
                
            }
            
            
            
        });
        
        
    } withFile:_filePath];
    
    
}


-(void)dealloc
{
    
    
     //if viewController dellaoc   all Video  will cancel
    [[ZacharyPlayManager sharedInstance]cancelAllVideo];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
