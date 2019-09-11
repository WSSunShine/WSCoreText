//
//  ViewController.m
//  WSCoreText
//
//  Created by Will on 2019/8/30.
//  Copyright © 2019 Will. All rights reserved.
//

#import "ViewController.h"
#import "WSView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WSImageInfo * imageInfo = [[WSImageInfo alloc] initWithImage:[UIImage imageNamed:@"share_copy"] position:CGRectZero callback:^{
         NSLog(@"1111111");
    }];
    NSArray <WSImageInfo *> *imageArr = @[imageInfo];
    WSCoreTextManager * manager = [[WSCoreTextManager alloc] initWithAttributeString:[[NSMutableAttributedString alloc] initWithString:@"傅立叶分析分为傅立叶级数和傅立叶变换。傅里叶级数的本质是将一个周期的信号分解成无限多分开的（离散的）正弦波。傅里叶变换，则是将一个时域非周期的连续信号" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor redColor]}] frame:CGRectMake(0, 0, self.view.bounds.size.width - 20 * 2,400) images:imageArr];

    [manager measureImagePosition];

//    CGRect rect = [model.attributeString boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 20 * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];

    WSView * view = [[WSView alloc] initWithFrame:CGRectMake(10, 88, self.view.bounds.size.width - 20 * 2,400)];
    view.backgroundColor = [UIColor whiteColor];
    view.coreTextManager = manager;
    
    [self.view addSubview:view];
   
}


@end
