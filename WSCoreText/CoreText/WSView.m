//
//  WSView.m
//  WSCoreText
//
//  Created by Will on 2019/8/30.
//  Copyright © 2019 Will. All rights reserved.
//

#import "WSView.h"

@implementation WSView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    // Core Text坐标系原点在左下角和UIKit坐标系原点在左上角
    //系统为了开发人员便捷开发，直接将UIKit坐标进行了矩阵变换变成了Core
    //Text坐标，达到了上下层分离的效果 已像素为单位 通过martix来进行坐标转换
    CGContextRef context = UIGraphicsGetCurrentContext();
    //初始化为core text坐标系
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);

    //因为coretext得到的坐标全部都是以左下角为原点的坐标，所以要把变换矩阵重置为单位矩阵
    CTFrameDraw(self.coreTextManager.frame, context);
    for (WSImageInfo * image in self.coreTextManager.images) {
        CGContextDrawImage(context, image.imageRect, image.image.CGImage);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = touches.anyObject;
    
    CGPoint point = [touch locationInView:touch.view];
    
    for (WSImageInfo * info in self.coreTextManager.glphysRect) {
        CGRect glphyRect = info.imageRect;
        CGFloat yOffset = glphyRect.origin.y;
        glphyRect.origin.y = self.coreTextManager.pathRect.size.height - yOffset - info.imageRect.size.height;
        if (CGRectContainsPoint(glphyRect, point)) {
            if (info.event != nil) {
                info.event();
            }
        }
    }
    
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
@end
