//
//  MessageTableViewCell.m
//  mesageTableView
//
//  Created by 李言 on 14-4-22.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setcontextText:(NSString *)context andType:(NSString *)type andto:(int)to{
   
    switch ([type intValue]) {
        case 1:
        {
            [self.img_content removeFromSuperview];
            [self._contentBtn setTitle:context forState:UIControlStateNormal];
            self._contentBtn.titleLabel.numberOfLines = 0;
            self._contentBtn.contentEdgeInsets = UIEdgeInsetsMake(10 , 25, 15, 15);
            self._contentBtn.titleLabel.font=[UIFont systemFontOfSize:16];
            //UIFont *font = [UIFont systemFontOfSize:16];
            CGSize size=[context sizeWithFont:__contentBtn.titleLabel.font constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            UIImage *normal;
            if (to==0) {
                
                self.headimg.frame=CGRectMake(10, 10, 40, 40);
                self._contentBtn.frame=CGRectMake(60, 10, size.width+15+25, size.height+15+15);
                
                normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
                normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
                
            }else{
                self._contentBtn.contentEdgeInsets = UIEdgeInsetsMake(10 , 15, 15, 25);
                
                self._contentBtn.frame=CGRectMake(320-60-size.width-15-25, 10, size.width+15+25, size.height+15+15);
                normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
                normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
                self.headimg.frame=CGRectMake(320-60, 10, 40, 40);
            }
            [self._contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
        

          [self  addSubview:self._contentBtn];
        }
            break;
        case 2:
        {
            //self.img_content=[[UIImageView alloc] init];
            self.img_content.contentMode=UIViewContentModeScaleAspectFit;
            [self._contentBtn removeFromSuperview];
            if (to==0) {
                self.headimg.frame=CGRectMake(10, 10, 40, 40);
                self.img_content.frame=CGRectMake(80, 10, 150, 150);
                
                

            }else{
                self.headimg.frame=CGRectMake(320-60, 10, 40, 40);
                self.img_content.frame=CGRectMake(320-80-150, 10, 150, 150);
            
            }
        
            self.img_content.image=[UIImage imageNamed:@"man.jpg"];
            [self addSubview:self.img_content];
        }
    
            break;
        case 3:{
            UIImage *normal;
            if (to==0) {
                self.headimg.frame=CGRectMake(10, 10, 40, 40);
                self._contentBtn.frame=CGRectMake(60, 10, 100, 40);
                normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
                normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
            }else{
                self._contentBtn.contentEdgeInsets = UIEdgeInsetsMake(10 , 15, 15, 25);
                self._contentBtn.frame=CGRectMake(320-60-100, 10, 100, 40);
                normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
                normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
                self.headimg.frame=CGRectMake(320-60, 10, 40, 40);
            }
            [self._contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
            [self  addSubview:self._contentBtn];
        }
            break;
            
        default:
            break;
    }
}
- (void)dealloc
{
    self.img_content=nil;

    NSLog(@"delloc");
}
@end
