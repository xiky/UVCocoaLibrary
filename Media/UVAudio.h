//
//  UVAudio.h
//  Form
//
//  Created by chenjiaxin on 14-5-19.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@protocol UVAudioDelegate;

/**
 *  声音播放和录音简单封装
 * 使用方法： UVAudio *audio = [UVAudio instance]; 录音：[audio startRecord:<path_>];  播放声音文件：[audio startPlay:<path_>]
 */
@interface UVAudio : NSObject
/**
 *  delegate
 */
@property(nonatomic,weak) id<UVAudioDelegate> delegate;
/**
 *  播放器对象，只有在播放时才有值 播放结束后自动设置为nil
 */
@property(nonatomic,strong,readonly) AVAudioPlayer *player;
/**
 *  录音器对象，只有在播放时才有值 播放结束后自动设置为nil
 */
@property(nonatomic,strong,readonly) AVAudioRecorder *recorder;
/**
 *  是否正在录音中
 */
@property(nonatomic,assign,readonly) BOOL isRecording;
/**
 *  当前操作的地址
 */
@property(nonatomic,assign,readonly) NSURL *url;

//红色感应是否自动在切换到背景
@property(nonatomic,assign) BOOL autoPlayback;
/** 实例化对象
 
 建议在使用前，均调用此静态方法
 
 @return UVAudio
 */
+(UVAudio*)instance;

/**
 *  使用delegate初始化对象
 *
 *  @param delegate_ delegate
 *
 *  @return 返回一个实例化对象
 */
- (id)initWithDelegate:(id<UVAudioDelegate>)delegate_;

/**
 *  开始录音
 *
 *  @param path_ 录音文件存在路径
 *
 *  @return 如果操作失败返回一个非nil NSError
 */
- (NSError*)startRecord:(NSURL*)path_;

/**
 *  停止录音
 */
- (void)stopRecord;

/**
 *  开始播放一个音乐文件
 *
 *  @param path_ 播放的文件路径
 *
 *  @return  如果操作失败返回一个非nil NSError
 */
- (NSError*)startPlay:(NSURL*)path_;

/**
 *  停止播放
 */
- (void)stopPlay;

@end

@protocol UVAudioDelegate <NSObject>
//- (void)onAudioError:(UVAudio*)sender_;
//播放结束时触发事件 异常中止同样也会触发
- (void)onAudioPlayFinished:(UVAudio*)sender_;
//- (void)onAudioPlayStop:(UVAudio*)sender_;
@end
