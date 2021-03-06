//
//  message.m
//  mesageTableView
//
//  Created by 李言 on 14-4-23.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize icon;
@synthesize time;
@synthesize content;
@synthesize image;
@synthesize soundData;
@synthesize totype;
@synthesize messagetype;
@synthesize WAVsoundDataS;
@synthesize AMRSoundDataS;
+(id)messageWithicon:(NSString *)icon andtime:(NSString *)time andcontent:(NSString *)content andimage:(UIImage *)image andsoundData:(NSString *)sounddata andtoType:(toType)type andmessgeType:(MessageType)messagetype andWAVsoundDataS:(NSData *)WAVsoundDataS andAMRSoundDataS:(NSData *)AMRSoundDataS{

    Message *n=[[Message alloc] init];
    n.icon=icon;
    n.time=time;
    n.content=content;
    n.image=image;
    n.soundData=sounddata;
    n.totype=type;
    n.messagetype=messagetype;
    n.WAVsoundDataS=WAVsoundDataS;
    n.AMRSoundDataS=AMRSoundDataS;
    return n;
}
@end
