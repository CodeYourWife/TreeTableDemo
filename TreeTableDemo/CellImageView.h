//
//  CellImageView.h
//  TreeTableDemo
//
//  Created by jianghai on 15/8/27.
//  Copyright (c) 2015年 jianghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import "AppDelegate.h"

typedef void(^downloadImageEndCallback)(UIImageView* target ,UIImage* image , NSIndexPath* index);

@interface CellImageView : UIImageView
- (instancetype)initWithURL:(NSURL*)url indexPath:(NSIndexPath*)indexPath completion:(downloadImageEndCallback) callBlock;

@end
