//
//  AppDelegate.h
//  TreeTableDemo
//
//  Created by jianghai on 15/8/27.
//  Copyright (c) 2015年 jianghai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic)NSCache* cache;

+ (AppDelegate*)shareApplication;


@end

