//
//  UVAudio.m
//  Form
//
//  Created by chenjiaxin on 14-5-19.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import "UVAudio.h"
@interface UVAudio() <AVAudioPlayerDelegate>


@end
static UVAudio *_uvaudioinstance = nil;

@implementation UVAudio

- (void)initData
{
    _isRecording = NO;
    _url = nil;
    _delegate = nil;
    _autoPlayback = NO;
}
+(UVAudio*)instance
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _uvaudioinstance = [[UVAudio alloc] init];
    });
    return _uvaudioinstance;
}
- (id)init
{
    if(self = [super init])
    {
        [self initData];
    }
    return self;
}

- (id)initWithDelegate:(id<UVAudioDelegate>)delegate_
{
    if(self = [super init])
    {
        [self initData];
        _delegate = delegate_;
    }
    return self;
}

- (NSError*)startRecord:(NSURL*)path_
{
    _url = path_;
    if(_isRecording)
    {
        NSLog(@"startRecord failed,curent is recording");
        return [NSError errorWithDomain:@"error" code:1 userInfo:@{NSLocalizedDescriptionKey:@"startRecord failed,curent is recording"}];
    }
    _isRecording = YES;
    
    NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:8000],AVSampleRateKey,
                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                            nil];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    NSError *error;
    _recorder=[[AVAudioRecorder alloc]initWithURL:path_ settings:settings error:&error];
    [_recorder prepareToRecord];
    [_recorder setMeteringEnabled:YES];
    [_recorder peakPowerForChannel:0];
    [_recorder record];
    return error;
}
- (void)stopRecord
{
    if(!_isRecording)
    {
        NSLog(@"stopRecord failed,record not start");
        return;
    }
    [_recorder stop];
    _isRecording = NO;
}
- (NSError*)startPlay:(NSURL*)path_
{
    _url = path_;
    if(_player != nil && _player.isPlaying)
    {
        [self stopPlay];
    }
    [self initPlayer];
    
    NSError *error;
    _player=[[AVAudioPlayer alloc]initWithContentsOfURL:path_ error:&error];
    [_player setVolume:1];
    [_player prepareToPlay];
    [_player setDelegate:self];
    [_player play];
    if(error == nil && _autoPlayback)
    {
        //开启红外感应
        [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
        //注册感应事件处理
        [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sensorStateChange:)
                                                 name:UIDeviceProximityStateDidChangeNotification
                                               object:nil];
    }
    return error;
}

- (void)stopPlay
{
    if(_player != nil && _player.isPlaying)
    {
        [_player stop];
        _player = nil;
        if(_autoPlayback)
        {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
        }
    }
    [self triggerPlayFinish];
    
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    [self stopPlay];
}
#pragma mark - private
- (void)initPlayer
{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    audioSession = nil;
}

#pragma mark - delegrate
//处理监听触发事件
- (void)sensorStateChange:(NSNotificationCenter *)notification;
{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if ([[UIDevice currentDevice] proximityState] == YES)
    {
        NSLog(@"Device is close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
    }
    else
    {
        NSLog(@"Device is not close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

#pragma mark - trigger
- (void)triggerPlayFinish
{
    if(_delegate != nil && [_delegate respondsToSelector:@selector(onAudioPlayFinished:)])
    {
        [_delegate onAudioPlayFinished:self];
    }
}

@end
