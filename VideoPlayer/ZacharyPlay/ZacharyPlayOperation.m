//
//  zacharyPlayOperation.m
//  VideoPlayer
//
//  Created by zachary on 2016/9/29.
//  Copyright © 2016年 zachary. All rights reserved.
//

#import "ZacharyPlayOperation.h"
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


@implementation ZacharyPlayOperation
-(instancetype)initWithUrl:(NSURL *)url andPlayType:(PlayType)type
{
    self=[super init];
    if (self) {
        self.url=url;
        self.type=type;
    }
    return self;
    
}


-(void)startVithBlock:(VideoCode)video
{
    videoBlock=[video copy];
    __weak typeof(self) weakSelf=self;
    [self addExecutionBlock:^{
        [weakSelf videoPlayTask];
        
    }];

}

-(void)videoPlayTask
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.url options:nil];
    
    NSError *error;
    AVAssetReader* reader = [[AVAssetReader alloc] initWithAsset:asset error:&error];
    NSArray* videoTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    
    if (!videoTracks.count) {
        return ;
    }
    
    AVAssetTrack* videoTrack = [videoTracks objectAtIndex:0];
    
    UIImageOrientation orientation = [self orientationFromAVAssetTrack:videoTrack];
    
    int m_pixelFormatType = kCVPixelFormatType_32BGRA;
    NSDictionary* options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt: (int)m_pixelFormatType] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    AVAssetReaderTrackOutput* videoReaderOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:videoTrack outputSettings:options];
    [reader addOutput:videoReaderOutput];
    [reader startReading];
    while ([reader status] == AVAssetReaderStatusReading && videoTrack.nominalFrameRate > 0&&(!self.isCancelled)) {
        @autoreleasepool {
            CMSampleBufferRef sampleBuffer = [videoReaderOutput copyNextSampleBuffer];
            if (!sampleBuffer) {
                break;
                
            }
            CGImageRef zacharyImage=[ZacharyPlayOperation imageFromSampleBuffer:sampleBuffer rotation:orientation];
            
            MAIN(^{
                if (videoBlock) {
                    videoBlock(zacharyImage);
                }
                
                if (sampleBuffer) {
                    CFRelease(sampleBuffer);
                    
                    
                }
                if (zacharyImage) {
                    CGImageRelease(zacharyImage);
                }
                
            });
            [NSThread sleepForTimeInterval:CMTimeGetSeconds(videoTrack.minFrameDuration)];

            
        }
    }
    if (self.type==AtLeastOnce&&reader.status==AVAssetReaderStatusCompleted) {
        [self videoPlayTask];
        return;
        
    }
    [reader cancelReading];
    
    
}


- (UIImageOrientation)orientationFromAVAssetTrack:(AVAssetTrack *)videoTrack
{
    UIImageOrientation orientation;
    
    CGAffineTransform t = videoTrack.preferredTransform;
    if(t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0){
        // Portrait
        //        degress = 90;
        orientation = UIImageOrientationRight;
    }else if(t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0){
        // PortraitUpsideDown
        //        degress = 270;
        orientation = UIImageOrientationLeft;
    }else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0){
        // LandscapeRight
        //        degress = 0;
        orientation = UIImageOrientationUp;
    }else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
        // LandscapeLeft
        //        degress = 180;
        orientation = UIImageOrientationDown;
    }
    
    return orientation;
}



+ (CGImageRef) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer rotation:(UIImageOrientation)orientation{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    //Generate image to edit
    unsigned char* pixel = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(pixel, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little|kCGImageAlphaPremultipliedFirst);
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    UIGraphicsEndImageContext();
    
    if (orientation == UIImageOrientationUp) {
        return image;
    }
    
    CGImageRef imageRef = [self image:image rotation:orientation];
    
    return imageRef;
}


+ (CGImageRef)image:(CGImageRef)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    
    CGRect rect;
    
    float translateX = 0;
    
    float translateY = 0;
    
    float scaleX = 1.0;
    
    float scaleY = 1.0;
    
    CGSize size = CGSizeMake(CGImageGetWidth(image), CGImageGetHeight(image));
    
    switch (orientation) {
            
        case UIImageOrientationLeft:
            
            rotate = M_PI_2;
            
            rect = CGRectMake(0, 0, size.height, size.width);
            
            translateX = 0;
            
            translateY = -rect.size.width;
            
            scaleY = rect.size.width/rect.size.height;
            
            scaleX = rect.size.height/rect.size.width;
            
            break;
            
        case UIImageOrientationRight:
            
            rotate = 3 * M_PI_2;
            
            rect = CGRectMake(0, 0, size.height, size.width);
            
            translateX = -rect.size.height;
            
            translateY = 0;
            
            scaleY = rect.size.width/rect.size.height;
            
            scaleX = rect.size.height/rect.size.width;
            
            break;
            
        case UIImageOrientationDown:
            
            rotate = M_PI;
            
            rect = CGRectMake(0, 0, size.width, size.height);
            
            translateX = -rect.size.width;
            
            translateY = -rect.size.height;
            
            break;
            
        default:
            
            rotate = 0.0;
            
            rect = CGRectMake(0, 0, size.width, size.height);
            
            translateX = 0;
            
            translateY = 0;
            
            break;
            
    }
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextRotateCTM(context, rotate);
    
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    
    

    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image);
    
    CGImageRef imageRef=CGBitmapContextCreateImage(context);
    
    UIGraphicsEndImageContext();
    
    if (image) {
        CGImageRelease(image);
    }
    
    return imageRef;
}



@end
