//
//  MessageTableViewCell.h
//  mesageTableView
//
//  Created by 李言 on 14-4-22.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *_contentBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headimg;
//@property (strong, nonatomic) UIImageView *img_content;
@property (weak, nonatomic) IBOutlet UIImageView *img_content;

-(void)setcontextText:(NSString *)context andphoto:(UIImage *)photo andType:(int )type andto:(int)to;
@end
