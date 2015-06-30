//
//  ViewController.m
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "ViewController.h"
#import "ArticleTableViewCell.h"
@interface ViewController ()<ResetCellHeightDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth-20, ScreenHeight-20) style:UITableViewStylePlain];
//    self.tableview.rowHeight = 200;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.backgroundView = nil;
    [self.view addSubview:self.tableview];
    
    UIImageView * topv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30*(ScreenWidth-20)/732)];
    [topv setImage:[UIImage imageNamed:@"tvtop"]];
    self.tableview.tableHeaderView = topv;
    
    UIImageView * btv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30*(ScreenWidth-20)/732)];
    [btv setImage:[UIImage imageNamed:@"tvbottom"]];
    self.tableview.tableFooterView = btv;
    
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *otherCellIdentifier = @"articlecell";
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCellIdentifier ];
    if (cell == nil) {
        cell = [[ArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:otherCellIdentifier];
        cell.delegate = self;
    }

    return cell;
}
-(void)resetCellHeightWithContentSizeH:(CGFloat)height
{
    self.rowHeight = height;
    self.tableview.contentSize = CGSizeMake(ScreenWidth-20, height+40);
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
