//
//  Chat.h
//  mesageTableView
//
//  Created by 李言 on 14-4-25.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Chat : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * contentTent;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSNumber * toType;
@property (nonatomic, retain) NSNumber * messageType;
@property (nonatomic, retain) NSString * soundData;
@property (nonatomic, retain) NSData * iconimage;

@end
