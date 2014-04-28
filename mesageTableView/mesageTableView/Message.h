//
//  message.h
//  mesageTableView
//
//  Created by 李言 on 14-4-23.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    
   
    MessageTypeOther = 0, //别人发得
     MessageTypeMe = 1 // 自己发的
    
} toType;
typedef enum {
    
    text = 1, // 文字
    pic = 2 ,//图片
    sound //语音
} MessageType;

@interface Message : NSObject

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *soundData;
@property (nonatomic, assign) toType totype;
@property (nonatomic, assign) MessageType messagetype;
@property (nonatomic, strong) NSData *WAVsoundDataS;
@property (nonatomic, strong) NSData *AMRSoundDataS;
+(id)messageWithicon:(NSString *)icon andtime:(NSString *)time andcontent:(NSString *)content andimage:(UIImage *)image andsoundData:(NSString *)sounddata andtoType:(toType)type andmessgeType:(MessageType)messagetype andWAVsoundDataS:(NSData *)WAVsoundDataS andAMRSoundDataS:(NSData *)AMRSoundDataS;
@end
