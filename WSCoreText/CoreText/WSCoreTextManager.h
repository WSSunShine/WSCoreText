//
//  WSCoreTextModel.h
//  WSCoreText
//
//  Created by Will on 2019/9/4.
//  Copyright © 2019 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import "WSImageInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface WSCoreTextManager : NSObject

@property (nonatomic, assign) CTFrameRef frame;
@property (nonatomic, strong) NSMutableArray * images;
@property (nonatomic, strong) NSMutableAttributedString * attributeString;
@property (nonatomic, assign) CGRect pathRect;
@property (nonatomic, strong) NSMutableArray * glphysRect;

- (instancetype)initWithAttributeString:(NSMutableAttributedString *)attribute frame:(CGRect)pathRect images:(NSArray<WSImageInfo *> *)attributeImages;
- (void)measureImagePosition ;
- (void)appendImageAttributeStringWithInfo:(CGSize)size ;
@end

NS_ASSUME_NONNULL_END
