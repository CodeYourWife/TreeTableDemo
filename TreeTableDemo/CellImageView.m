//
//  CellImageView.m
//  TreeTableDemo
//
//  Created by jianghai on 15/8/27.
//  Copyright (c) 2015年 jianghai. All rights reserved.
//

#import "CellImageView.h"

@interface CellImageView()

@property (nonatomic,strong)NSURL* souceURL;
@property (nonatomic,strong)NSIndexPath* cellIndexPath;
@property (nonatomic,copy)downloadImageEndCallback callfunc;

@end

@implementation CellImageView


- (instancetype)initWithURL:(NSURL*)url indexPath:(NSIndexPath*)indexPath completion:(downloadImageEndCallback) callBlock
{
    if(self = [super init])
    {
        self.image = nil;
        _souceURL = url;
        _cellIndexPath = indexPath;
        _callfunc = callBlock;
        [self loadImage];
        
    }
    return self;
}
- (void) loadImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        id ii = [[AppDelegate shareApplication].cache objectForKey:_souceURL.absoluteString];
        UIImage* filterImage = nil;
        if(!ii)
        {
            
            NSURLResponse* response = nil;
            NSError* error = nil;
            NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:_souceURL] returningResponse:&response error:&error];
            CIImage *image = [CIImage imageWithData:data];
            CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                          keysAndValues:kCIInputImageKey,image,@"inputIntensity", @0.8, nil];
            CIImage *outputImage = [filter outputImage];
            filterImage = [UIImage imageWithCIImage:outputImage];
            
            [[AppDelegate shareApplication].cache setObject:filter forKey:_souceURL.absoluteString];
        }
        else
        {
            filterImage = (UIImage*)ii;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            _callfunc(self,filterImage,self.cellIndexPath);
        });
        
    });
}
@end
