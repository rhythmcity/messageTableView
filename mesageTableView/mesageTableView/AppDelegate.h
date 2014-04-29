//
//  AppDelegate.h
//  mesageTableView
//
//  Created by 李言 on 14-4-22.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"
@protocol ChatDelegate;
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
        XMPPStream *xmppStream;
        XMPPRoster *xmppRoster;
        XMPPRosterCoreDataStorage *xmppRosterStorage;
        XMPPReconnect *xmppReconnect;
        XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;
        XMPPMessageArchiving *xmppMessageArchivingModule;
    

}


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) id<ChatDelegate> chatDelegate;
@property (nonatomic, strong) XMPPStream *xmppStream;
@property (nonatomic, strong) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong) XMPPRoster *xmppRoster;
@property (nonatomic, strong) XMPPReconnect *xmppReconnect;
@property (nonatomic, strong) XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;
@property (nonatomic, strong) XMPPMessageArchiving *xmppMessageArchivingModule;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;



@end
@protocol ChatDelegate <NSObject>

-(void)friendStatusChange:(AppDelegate *)appD Presence:(XMPPPresence *)presence;
-(void)getNewMessage:(AppDelegate *)appD Message:(XMPPMessage *)message;

@end
