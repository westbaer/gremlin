/*
 * Created by Youssef Francis on October 3rd, 2012.
 */

#import <AVFoundation/AVFoundation.h>

@interface GRiTunesMP4Utilities

+ (BOOL)convertAsset:(AVAsset*)asset
                dest:(NSString*)dest
           timeRange:(CMTimeRange)timeRange
               error:(NSError**)error;

@end
