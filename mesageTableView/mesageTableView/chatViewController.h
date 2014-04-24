//
//  chatViewController.h
//  mesageTableView
//
//  Created by 李言 on 14-4-22.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chatViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

    NSMutableArray *contentarr;
    float tableViewHeight;
    float toolViewX;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *_textField;

@property (strong, nonatomic) IBOutlet UIView *toolView;

- (IBAction)addphoto_click:(id)sender;

@end
