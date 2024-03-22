//
//  FUManager.h
//  MetaViewDemo
//
//  Created by teneocto on 06/03/2024.
//
#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>
#import <AgoraRtcKit/AgoraRtcKit.h>


@interface FUManager: NSObject
+ (instancetype)shared;

/// 初始化FURenderKit
+ (void)setupFUSDK;

+ (void)updateBeautyBlurEffect;

- (void)checkAITrackedResult;

@end

@interface FUManager (AgoraVideoEngine) <AgoraVideoFrameDelegate>

@end
