//
//  chatViewController.h
//  mesageTableView
//
//  Created by 李言 on 14-4-22.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ChatVoiceRecorderVC.h"
#import "VoiceConverter.h"
@interface chatViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VoiceRecorderBaseVCDelegate>
{

    NSMutableArray *contentarr;
    float tableViewHeight;
//    //录音器
//    AVAudioRecorder *recorder;
//    //播放器
//    AVAudioPlayer *player;
//    NSDictionary *recorderSettingsDict;
//    
//    //定时器
//    NSTimer *timer;
//    //图片组
//    NSMutableArray *volumImages;
//    double lowPassResults;
//    
//    //录音名字
//    NSString *playName;
    
}
@property (strong, nonatomic)  ChatVoiceRecorderVC      *recorderVC;
@property (strong, nonatomic)     NSString                *originWav;         //原wav文件名
@property (strong, nonatomic)     NSString                *convertAmr;        //转换后的amr文件名
@property (strong, nonatomic)     NSString                *convertWav;        //amr转wav的文件名
@property (strong, nonatomic)   AVAudioPlayer           *player;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *_textField;

@property (strong, nonatomic) IBOutlet UIView *toolView;

- (IBAction)addphoto_click:(id)sender;
- (IBAction)voiceBtnClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *_speakBtn;
- (IBAction)recordVoice:(id)sender;
- (IBAction)upStopRecordVoice:(id)sender;

@end
