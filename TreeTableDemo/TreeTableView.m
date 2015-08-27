//
//  TreeTableView.m
//  TreeTableDemo
//
//  Created by jianghai on 15/8/27.
//  Copyright (c) 2015年 jianghai. All rights reserved.
//

#import "TreeTableView.h"
#import "Node.h"

@interface TreeTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray* tableData;
@property (nonatomic,strong)NSArray* allData;
@end

@implementation TreeTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style data:(NSArray *)dataArray
{
    if(self = [super initWithFrame:frame style:style])
    {
        
        self.delegate = self;
        self.dataSource = self;
        _allData = [NSArray arrayWithArray:dataArray];
        _tableData = [NSMutableArray arrayWithCapacity:0];
        
        for (Node* node in _allData) {
            if(node.depth == 0)
            {
                [_tableData addObject:node];
            }
        }
        
    }
    return self;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NODE_CELL_ID];
    }
    
    Node *node = [_tableData objectAtIndex:indexPath.row];
    cell.indentationLevel = node.depth; // 缩进级别
    cell.indentationWidth = 30.f; // 每个缩进级别的距离
    cell.textLabel.text = node.name;
    
    return cell;
}
#pragma mark -UITableViewDelegate-
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Node* selectNode = [_tableData objectAtIndex:[indexPath row]];
    if(selectNode.expand)
    {
        
        NSMutableArray* child = [NSMutableArray arrayWithCapacity:0];
        for (Node* node in _allData){
            if(node.parentId == selectNode.nodeId){
                [child addObject:node];
            }
        }
        
        NSRange range;
        range.location = [indexPath row] + 1;
        range.length = child.count;
        [_tableData insertObjects:child atIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
        [self reloadData];
    }
    else
    {
        for (Node* node in _allData){
            if(node.parentId == selectNode.nodeId){
//                [_tableData removeObject:node];
            }
        }
        [self reloadData];
    }
    selectNode.expand = ! selectNode.expand;
    //    [self insertRowsAtIndexPaths:[indexPath row] + 1 + child.count withRowAnimation:UITableViewRowAnimationTop];
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
}
@end
