//
//  WSImageInfo.h
//  WSCoreText
//
//  Created by Will on 2019/9/4.
//  Copyright © 2019 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^callbackEvent)(void);
@interface WSImageInfo : NSObject
@property (nonatomic, strong) UIImage * image;

@property (nonatomic, assign) CGRect imageRect;

@property (nonatomic, copy) callbackEvent event;

- (instancetype)initWithImage:( UIImage * _Nullable )image  position:(CGRect)frame callback:(callbackEvent)event;
@end

NS_ASSUME_NONNULL_END
