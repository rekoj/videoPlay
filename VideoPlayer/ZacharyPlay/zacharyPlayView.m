//
//  zacharyPlayView.m
//  VideoPlayer
//
//  Created by zachary on 2016/9/29.
//  Copyright © 2016年 zachary. All rights reserved.
//

#import "zacharyPlayView.h"
#import "ZacharyPlay.h"
@interface zacharyPlayView()

@property(nonatomic,assign)PlayType playType;
@property(nonatomic,strong)NSOperationQueue *playQueue;
@end




@implementation zacharyPlayView

-(instancetype)initWithPlayType:(PlayType)type
{
    self=[super initWithFrame:defaultFrame];
    if (self) {
        self.playType=type?:AtMostOnce;
        self.playQueue=[[NSOperationQueue alloc]init];
        self.playQueue.maxConcurrentOperationCount=1;
        self.backgroundColor=[UIColor blueColor];
        
    }
    return self;
}
-(instancetype)initWithVideoUrl:(NSURL *)url
{
    return [self initWithVideoUrl:url andFrame:defaultFrame];
    
}


-(instancetype)initWithVideoUrl:(NSURL *)url
                       andFrame:(CGRect)frame
{
    self=[self initWithPlayType:AtMostOnce];
    if (self=[self initWithPlayType:AtMostOnce]) {
        [self setFrame:frame];
        self.url=url;
    }
    return self;
    
}
-(instancetype)initWithVideoUrl:(NSURL *)url
                    andPlayType:(PlayType)type
{
    self=[self initWithVideoUrl:url andFrame:defaultFrame];
    self.playType=type;
    return self;
}

-(instancetype)initWithVideoUrl:(NSURL *)url
                       andFrame:(CGRect)frame
                   exraPlayType:(PlayType)type
{
    self=[self initWithVideoUrl:url andFrame:frame];
    self.playType=type;
    return self;
}

-(void)playWithUrl:(NSURL *)url
{
    self.url=url?:self.url;
    [self playing];
    
}



-(void)playing
{
    [self stop];
    __weak typeof(self) weakSelf=self;
   ZacharyPlayOperation *playOperation=[[ZacharyPlayOperation alloc]initWithUrl:self.url andPlayType:self.playType];
    
       [playOperation startVithBlock:^(CGImageRef imageData) {
    
           weakSelf.layer.contents=(__bridge id _Nullable)(imageData);
       }];
    [self.playQueue addOperation:playOperation];

}

-(void)stop
{

    [self.playQueue cancelAllOperations];

    
}

-(void)cancelVideoWithUrl:(NSURL *)url
{
    
}

-(void)dealloc
{
    [self.playQueue cancelAllOperations];
}


@end
