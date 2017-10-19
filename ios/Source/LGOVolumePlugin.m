//
//  LGOVolumePlugin.m
//  plugin

#import "LGOVolumePlugin.h"
#import <LEGO-SDK/LGOCore.h>
#import <MediaPlayer/MediaPlayer.h>
@interface LGOVolumeRequest: LGORequest

@property (nonatomic, assign) float volume;

@end

@implementation LGOVolumeRequest

@end

@interface LGOVolumeResponse: LGOResponse



@end

@implementation LGOVolumeResponse

- (NSDictionary *)resData {
    return @{
             
             };
}

@end

@interface LGOVolumeperation: LGORequestable

@property (nonatomic, strong) LGOVolumeRequest *request;

@end

@implementation LGOVolumeperation

- (LGOResponse *)requestSynchronize {
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(-9999, -9999, 0, 0)];
    volumeView.showsVolumeSlider = NO;
    volumeView.showsVolumeSlider = NO;
    for (UIView *view in volumeView.subviews) {
        if ([view isKindOfClass:[UISlider class]]) {
            UISlider *volumeSlider = (UISlider *)view;
            if (self.request.volume <= 1.0 && self.request.volume >= 0.0) {
                volumeSlider.value = self.request.volume;
            }
        }
    }
    return [[LGOVolumeResponse new] accept:nil];
}

- (void)requestAsynchronize:(LGORequestableAsynchronizeBlock)callbackBlock {
    callbackBlock([self requestSynchronize]);
}

@end

@implementation LGOVolumePlugin

- (LGORequestable *)buildWithDictionary:(NSDictionary *)dictionary context:(LGORequestContext *)context {
    LGOVolumeperation *operation = [LGOVolumeperation new];
    operation.request = [LGOVolumeRequest new];
    operation.request.context = context;
    operation.request.volume = [dictionary[@"volume"] isKindOfClass:[NSNumber class]] ? [dictionary[@"volume"] floatValue] : 0;
    return operation;
}

- (LGORequestable *)buildWithRequest:(LGORequest *)request {
    if ([request isKindOfClass:[LGOVolumeRequest class]]) {
        LGOVolumeperation *operation = [LGOVolumeperation new];
        operation.request = (LGOVolumeRequest *)request;
        return operation;
    }
    return nil;
}

+ (void)load {
    [[LGOCore modules] addModuleWithName:@"Plugin.Volume" instance:[self new]];
}

@end
