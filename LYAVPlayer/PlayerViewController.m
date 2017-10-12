//
//  PlayerViewController.m
//  LYVideoPlayer
//
//  Created by luyang on 2017/10/11.
//  Copyright © 2017年 Myself. All rights reserved.
//

#import "PlayerViewController.h"
#import "LYAVPlayerView.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define VideoURL @"http://baobab.wdjcdn.com/1457521866561_5888_854x480.mp4"

@interface PlayerViewController ()<LYVideoPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;


@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic,strong)LYAVPlayerView *playerView;
@property (nonatomic,assign)BOOL isSlidering;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.playerView =[LYAVPlayerView sharedInstance];
    self.playerView.frame =CGRectMake(0, 64, ScreenWidth,200);
    self.playerView.delegate =self;
    [self.view addSubview:self.playerView];
    [self.playerView setURL:[NSURL URLWithString:VideoURL]];
    [self.playerView play];
    
    
    
    
}


- (IBAction)playAction:(id)sender {
    
    [self.playerView play];
}


- (IBAction)pauseAction:(id)sender {
    
    [self.playerView pause];
    
}

- (IBAction)valueChange:(id)sender {
    
    CGFloat seconds =_slider.value;
    
    CGFloat totalTime =[self.playerView getTotalPlayTime];
    
    CGFloat time =seconds*totalTime;
    
    [self.playerView seekToTime:time];
    
    
    
}

- (IBAction)valueEnd:(id)sender {
    
    _isSlidering =YES;
    
}
- (IBAction)valueBegin:(id)sender {
    
    _isSlidering =NO;
    
    
}

#pragma mark-----LYVideoPlayerDelegate-------
// 可播放／播放中
- (void)videoPlayerIsReadyToPlayVideo:(LYAVPlayerView *)playerView{
    
    
    NSLog(@"可播放");
    
}

//播放完毕
- (void)videoPlayerDidReachEnd:(LYAVPlayerView *)playerView{
    
     NSLog(@"播放完毕");
    
}
//当前播放时间
- (void)videoPlayer:(LYAVPlayerView *)playerView timeDidChange:(CGFloat )time{
    
    NSLog(@"当前播放时间:%f",time);
    
    if(!_isSlidering){
        
        _slider.value =[self.playerView getCurrentPlayTime]/[self.playerView getTotalPlayTime];
        
    }
    
    
}


//duration 当前缓冲的长度
- (void)videoPlayer:(LYAVPlayerView *)playerView loadedTimeRangeDidChange:(CGFloat )duration{
    
    NSLog(@"当前缓冲的长度%f",duration);
    
    
}

//进行跳转后没数据 即播放卡顿
- (void)videoPlayerPlaybackBufferEmpty:(LYAVPlayerView *)playerView{
    
     NSLog(@"卡顿了");
    
}

// 进行跳转后有数据 能够继续播放
- (void)videoPlayerPlaybackLikelyToKeepUp:(LYAVPlayerView *)playerView{
    
     NSLog(@"能够继续播放");
    
}

//加载失败
- (void)videoPlayer:(LYAVPlayerView *)playerView didFailWithError:(NSError *)error{
    
     NSLog(@"加载失败");
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
