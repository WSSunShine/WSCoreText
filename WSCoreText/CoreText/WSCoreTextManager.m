//
//  WSCoreTextManager.m
//  WSCoreText
//
//  Created by Will on 2019/9/4.
//  Copyright © 2019 Will. All rights reserved.
//

#import "WSCoreTextManager.h"

@implementation WSCoreTextManager

- (instancetype)initWithAttributeString:(NSMutableAttributedString *)attribute frame:(CGRect)pathRect images:(NSArray<WSImageInfo *> *)attributeImages{
    if (self = [super init]) {
        self.attributeString = attribute;
        self.glphysRect = [NSMutableArray array];
        [self appendImageAttributeStringWithInfo:CGSizeMake(100, 100)];
        self.images = [NSMutableArray array];
        if (attributeImages.count > 0) {
             [self.images addObjectsFromArray:attributeImages];
        }
        self.pathRect = pathRect;
        [self initCoreTextFrame];
        
    }
    return self;
}
- (void)initCoreTextFrame {
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)self.attributeString);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.pathRect);
   
    self.frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, self.attributeString.length), path, NULL);
    
    CFRelease(path);
    CFRelease(frameSetter);
}
- (void)appendImageAttributeStringWithInfo:(CGSize)size {
    CTRunDelegateCallbacks callback;
    memset(&callback, 0, sizeof(CTRunDelegateCallbacks));
    callback.getAscent = getAscent;
    callback.getDescent = getDescent;
    callback.getWidth = getWidth;
    
    NSDictionary * sizeInfo = @{@"width": @(size.width), @"height": @(size.height) };
    CTRunDelegateRef ref = CTRunDelegateCreate(&callback, (__bridge_retained void * _Nullable)(sizeInfo));
    unichar imagePlaceHolder = 0xFFFC;
    NSMutableAttributedString * imageAttributeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithCharacters:&imagePlaceHolder length:1] attributes:nil];
    
    CFAttributedStringSetAttribute(( CFMutableAttributedStringRef)imageAttributeString, CFRangeMake(0, 1), kCTRunDelegateAttributeName, ref);
    [self.attributeString appendAttributedString:imageAttributeString];
    CFRelease(ref);
}

static CGFloat getAscent(void *ref) {
    float height = [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
    return height;
}

static CGFloat getDescent(void *ref) {
    return 0;
}

static CGFloat getWidth(void *ref) {
    float width = [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
    return width;
}

- (void)measureImagePosition {
    
    int imageIndex = 0;
    
    if (imageIndex > self.images.count) {
        return;
    }
    
    NSArray *lines = (NSArray *)CTFrameGetLines(self.frame);
    CGPoint lineorigins[lines.count];
    CTFrameGetLineOrigins(self.frame, CFRangeMake(0, 0), lineorigins);
    for (int i = 0; i < lines.count; i++) {
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray * runs = (NSArray *)CTLineGetGlyphRuns(line);
        for (int j = 0; j < runs.count; j++) {
            CTRunRef run = (__bridge CTRunRef)runs[j];
            NSDictionary * attribute = (NSDictionary *)CTRunGetAttributes(run);
            if (!attribute) {
                continue;
            }
            
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attribute valueForKey:(id)kCTRunDelegateAttributeName];
            
            if (!delegate) {
                continue;
            }
            
            NSDictionary * info = (NSDictionary *)CTRunDelegateGetRefCon(delegate);
            if (!info) {
                continue;
            }
            CGFloat ascent ;
            CGFloat desent;
            CGFloat width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &desent, NULL);
            
            CGFloat xOffset = lineorigins[i].x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            CGFloat yOffset = lineorigins[i].y;
            
            //后续可增加不同的模型类来处理不同的attribute可点击
            WSImageInfo * imageInfo = self.images[imageIndex];
            imageInfo.imageRect = CGRectMake(xOffset, yOffset, width, ascent + desent);
            [self.glphysRect addObject: imageInfo];
            
            imageIndex ++;
            if (imageIndex >= self.images.count) {
                return;
            }
        }
    }
}

- (void)dealloc {
    if (_frame != nil) {
        CFRelease(_frame);
    }
}
@end
