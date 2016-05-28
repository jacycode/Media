//
//  VideoPlayerVC.m
//  Media
//
//  Created by 刘清 on 16/5/27.
//  Copyright © 2016年 LQ. All rights reserved.
//

#import "VideoPlayerVC.h"

//导入视频框架
#import <MediaPlayer/MediaPlayer.h>

#import <AVKit/AVKit.h>

@interface VideoPlayerVC ()

@property (weak, nonatomic) IBOutlet UIView *videoView;

@end

@implementation VideoPlayerVC
{
    //定义视频播放对象
    MPMoviePlayerController *_moviePlayer;//（9.0开始废弃）
    //AVPlayerViewController *_avPlayer;//（8.0开始引入）
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载视频资源
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:path];
    
    //初始化播放对象
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    
    
    //将视频播放对象的View添加到self.view
    [_videoView addSubview:_moviePlayer.view];
    
    [_moviePlayer prepareToPlay];
//    [_moviePlayer play];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    _moviePlayer.view.frame = CGRectMake(0, 0, _videoView.frame.size.width, _videoView.frame.size.height);
}

- (void)viewWillDisappear:(BOOL)animated
{
    //界面消失时，关闭播放
    //[_moviePlayer stop];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
