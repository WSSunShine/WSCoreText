//
//  WSImageInfo.m
//  WSCoreText
//
//  Created by Will on 2019/9/4.
//  Copyright © 2019 Will. All rights reserved.
//

#import "WSImageInfo.h"

@implementation WSImageInfo
- (instancetype)initWithImage:( UIImage * _Nullable )image  position:(CGRect)frame callback:(callbackEvent)event {
    if (self = [super init]) {
        self.image = image;
        self.imageRect = frame;
        self.event = event;
    }
    return self;
}
@end
