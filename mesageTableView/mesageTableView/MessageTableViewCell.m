//
//  MessageTableViewCell.m
//  mesageTableView
//
//  Created by 李言 on 14-4-22.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
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
-(void)setcontextText:(NSString *)context andphoto:(UIImage *)photo andVoice:(NSString *)Voice andType:(int )type andto:(int)to{
   [self.img_content removeFromSuperview];
   [self._contentBtn removeFromSuperview];
    switch (type ) {
        case 1:
        {
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
         
            if (to==0) {
                self.headimg.frame=CGRectMake(10, 10, 40, 40);
                self.img_content.frame=CGRectMake(80, 10, 150, 150);
                
                

            }else{
                self.headimg.frame=CGRectMake(320-60, 10, 40, 40);
                self.img_content.frame=CGRectMake(320-80-150, 10, 150, 150);
            
            }
            self.img_content.image=photo;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showbigPhoto:)];
            self.img_content.tag=1;
            [self.img_content addGestureRecognizer:tap];
            [self addSubview:self.img_content];
        }
    
            break;
        case 3:{
            UIImage *normal;
            if (to==0) {
                self.headimg.frame=CGRectMake(10, 10, 40, 40);
                self._contentBtn.frame=CGRectMake(60, 10, 150, 40);
                normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
                normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
            }else{
                self._contentBtn.contentEdgeInsets = UIEdgeInsetsMake(10 , 15, 15, 25);
                self._contentBtn.frame=CGRectMake(320-60-150, 10, 150, 40);
                normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
                normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
                self.headimg.frame=CGRectMake(320-60, 10, 40, 40);
                
            }
            convertWav=Voice;
            [self._contentBtn setTitle:@"这是一条语音" forState:UIControlStateNormal];
            [self._contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
            [self._contentBtn addTarget:self action:@selector(playVoice:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self._contentBtn];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 播放转换后wav
//- (void)playConvertWavBtnPressed:(id)sender {
//  
//}
-(void)playVoice:(id)sender{

    if (convertWav.length > 0){
        //初始化播放器
        _player = [[AVAudioPlayer alloc]init];
        _player = [_player initWithContentsOfURL:[NSURL URLWithString:convertWav] error:nil];
    
        [_player play];
    }

}
-(void)showbigPhoto:(UITapGestureRecognizer *)tap{
    
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i<1; i++) {
        // 替换为中等尺寸图片
//        NSString *url=[NSString stringWithFormat:@"%@%@",image_base_url,[self.photoarray objectAtIndex:i]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        UIImageView *imageview= (UIImageView*)tap.view;
        photo.image=imageview.image;
            photo.srcImageView = imageview; // 来源于哪个UIImageView
            [photos addObject:photo];
        
    }
    NSLog(@"%@",photos);
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag-1; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];




}
- (void)dealloc
{
   // self.img_content=nil;

 //   NSLog(@"delloc");
}
@end
