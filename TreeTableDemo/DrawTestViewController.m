//
//  DrawTestViewController.m
//  TreeTableDemo
//
//  Created by jianghai on 15/8/27.
//  Copyright (c) 2015年 jianghai. All rights reserved.
//

#import "DrawTestViewController.h"
#import "CellImageView.h"


@interface DrawTestViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray* tableData;
@end


@implementation DrawTestViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableData = [NSMutableArray arrayWithCapacity:0];
    
//    dispatch_queue_t queue = dispatch_queue_create("com.imageget.queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
    
        NSURLResponse* response = nil;
        NSError* error = nil;
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.huaban.com/favorite/fitness/"]] returningResponse:&response error:&error];
        if(nil == error)
        {
            
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSArray* ar = dic[@"pins"];
            for (NSDictionary *dics in ar) {
                NSString *imageNamdi = [dics valueForKeyPath:@"file.key"];
                [_tableData addObject:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.hb.aicdn.com/%@",imageNamdi]]];
            }
        }
        
//    });

    
    UITableView* table = [[UITableView alloc] initWithFrame:self.view.bounds];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
}

#pragma mark-UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *NODE_CELL_ID = @"node_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    if (!cell) {
        NSLog(@"--------------------");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NODE_CELL_ID];
    }
    
    CellImageView* aView = [[CellImageView alloc] initWithURL:[_tableData objectAtIndex:[indexPath row]] indexPath:indexPath completion:^(UIImageView *target, UIImage *image, NSIndexPath *index) {
        if ([indexPath row] == [index row]) {
            target.image = image;
        }
    }];
    aView.frame = CGRectMake(0, 0, 300, 300);
    [cell addSubview:aView];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

@end
