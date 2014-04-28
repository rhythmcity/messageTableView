//
//  MessageTableViewCell.h
//  mesageTableView
//
//  Created by 李言 on 14-4-22.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol platVoice <NSObject>

-(void)playVoice:(NSData *)voiddata;
@end
@interface MessageTableViewCell : UITableViewCell
{
    NSString * convertWav;
    NSData *Voicedata;
    BOOL cellIsplaying;
}

@property (strong, nonatomic)   AVAudioPlayer           *player;
@property (strong, nonatomic) IBOutlet UIButton *_contentBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headimg;
//@property (strong, nonatomic) UIImageView *img_content;
@property (strong, nonatomic) IBOutlet UIImageView *img_content;
@property (assign, nonatomic) id<platVoice>playdelegate;

-(void)setcontextText:(NSString *)context andphoto:(UIImage *)photo andVoice:(NSString *)Voice andVoiceData:(NSData *)voicedata andType:(int )type andto:(int)to;
@end
