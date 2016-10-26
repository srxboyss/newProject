//
//  ViewController.m
//  SetImageSize
//
//  Created by srx on 2016/10/26.
//  Copyright © 2016年 https://github.com/srxboyss. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"pic" ofType:@"jpg"];
    UIImage * image = [self thumbnailWithWithScale:[UIImage imageNamed:path] size:CGSizeMake(120, 120)];
    
    NSLog(@"image=%@", image);
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 120, 120)];
    imgView.backgroundColor = [UIColor redColor];
    imgView.image = image;
    [self.view addSubview:imgView];
    
    NSLog(@"imgView.image=%@", imgView.image);
    
}


- (UIImage *)thumbnailWithWithScale:(UIImage *)image size:(CGSize)asize {
    UIImage * newImage = nil;
    if(image) {
        CGSize oldSize = image.size;
        NSLog(@"oldSize=%@", NSStringFromCGSize(oldSize));
        CGRect rect = CGRectZero;
        
        if(asize.width/asize.height > oldSize.width/oldSize.height) {
            rect.size.width = asize.height * oldSize.width / oldSize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }else {
            rect.size.height = asize.width * oldSize.height / oldSize.width;
            rect.size.width = asize.width;
            rect.origin.y = (asize.height - rect.size.height)/2;
            rect.origin.x = 0;
        }
        
        NSLog(@"rect=%@", NSStringFromCGRect(rect));
        
        UIGraphicsBeginImageContext(asize);
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(contextRef, [UIColor clearColor].CGColor);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));
        [image drawInRect:rect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    return newImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
