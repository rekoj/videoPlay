//
//  ViewController.m
//  VideoPlayer
//
//  Created by eleme on 16/4/26.
//  Copyright © 2016年 zachary. All rights reserved.
//

#import "ViewController.h"
#import "VideoCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@end

NSString  *const cellName=@"VideoCell";


@implementation ViewController

@synthesize videoArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.videoTable registerClass:[VideoCell class] forCellReuseIdentifier:cellName];

    videoArray=[[NSMutableArray alloc]init];
    
    for (int i=0; i<5; i++) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d",i+1] ofType:@"mp4"];
        [videoArray addObject:filePath];

    }
    [videoArray addObjectsFromArray:videoArray];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return videoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath * )indexPath;
{
    return baseVideoHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath * )indexPath;
{
  VideoCell   *cell =[tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    [cell setData:[self.videoArray objectAtIndex:indexPath.row]];
    return cell;
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
