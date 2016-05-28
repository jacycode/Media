//
//  ViewController.m
//  Media
//
//  Created by 刘清 on 16/5/27.
//  Copyright © 2016年 LQ. All rights reserved.
//

#import "ViewController.h"

//导入头文件
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;


@end

@implementation ViewController
{
    //定义播放类
    AVAudioPlayer *_player;
    //定时器控制进度
    NSTimer *_timer;
    
    
    AVAudioRecorder *_recorder; //录音对象
    NSURL *_recorderURL;        //录音文件存储位置
    AVAudioPlayer *_recorderPlayer;//播放录音对象
    
    AVAudioSession *session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //加载音乐资源
    NSString *mPath = [[NSBundle mainBundle] pathForResource:@"song1" ofType:@"mp3"];
    
    //初始化_player
    NSError *error = nil;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:mPath] error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    //准备播放
    [_player prepareToPlay];
    
}

- (IBAction)play:(id)sender {
    
    if (_player.isPlaying) {
        //暂停（stop 停止）
        [_player pause];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        [_timer invalidate];
        _timer = nil;
    }else{
        //播放
        [_player play];
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(musicGo) userInfo:nil repeats:YES];
    }
    
}

- (void)musicGo
{
    _slider.value = (float)_player.currentTime / _player.duration;
}

- (IBAction)slideValueChange:(id)sender {
    
    [_player pause];
    
    //_slider.value 0~1  *  _player.duration总时间   =  _player.currentTime 当前时间
    _player.currentTime = _slider.value * _player.duration;
    
    [_player play];
}

//音频录制相关
- (IBAction)startRecorder:(id)sender {
    
    //增加Session对话即可实现真机录音
    session = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&setCategoryError];
    
    if(setCategoryError){
        NSLog(@"%@", [setCategoryError description]);
    }
    
    //录音文件存储的位置
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    _recorderURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/recorder.m4a", path[0]]];
    
    //音频参数  m4a  -->  kAudioFormatMPEG4AAC
    NSDictionary *dict = @{AVFormatIDKey:[NSNumber numberWithInt:kAudioFormatMPEG4AAC]};
    
    //初始化Record
    NSError *error = nil;
    _recorder = [[AVAudioRecorder alloc] initWithURL:_recorderURL settings:dict error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    //准备录音
    [_recorder prepareToRecord];
    
    //开始录制
    [_recorder record];
    
}
- (IBAction)stopRecorder:(id)sender {
    
    //停止录制
    [_recorder stop];
    
}
- (IBAction)playRecorder:(id)sender {
    
    NSError *error = nil;
    _recorderPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_recorderURL error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    [_recorderPlayer prepareToPlay];
    
    [_recorderPlayer play];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
