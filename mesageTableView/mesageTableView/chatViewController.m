//
//  chatViewController.m
//  mesageTableView
//
//  Created by 李言 on 14-4-22.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import "chatViewController.h"
#import "MessageTableViewCell.h"
#import "Message.h"
#import "AppDelegate.h"
@interface chatViewController ()

@end

@implementation chatViewController
@synthesize recorderVC,originWav,convertAmr,convertWav;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    contentarr=[[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //设置textField输入起始位置
    __textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    __textField.leftViewMode = UITextFieldViewModeAlways;
    
    __textField.delegate = self;
 
    tableViewHeight=[[UIScreen mainScreen] currentMode].size.height/2-self.toolView.frame.size.height;
 //   NSLog(@"%f",tableViewHeight);
    
    recorderVC = [[ChatVoiceRecorderVC alloc]init];
    recorderVC.vrbDelegate = self;
    
  
    


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     Message *n=[contentarr objectAtIndex:indexPath.row];
    if (n.messagetype==text) {
        UIFont *font = [UIFont systemFontOfSize:16];
        CGSize size=[n.content sizeWithFont:font constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height+40;
    }
    if (n.messagetype==pic) {
        return 170;
    }
    if (n.messagetype==sound) {
        return 60;
    }

    return 0;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (/*[textField.text hasPrefix:@" "]||*/textField.text==nil||[textField.text isEqualToString:@""]) {
        return  NO;
    }
    // 1、增加数据源
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    Message *n=[Message messageWithicon:nil andtime:time andcontent:textField.text andimage:nil andsoundData:nil andtoType:MessageTypeMe andmessgeType:text];
    [contentarr addObject:n];
    // 2、刷新表格
    [self.tableView reloadData];
   [self scrolltocurrentSection];
    // 4、清空文本框内容
    __textField.text = nil;
    return YES;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [contentarr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"messageTableViewIndetifier"];
    if (!cell) {
        
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[MessageTableViewCell class]]) {
                cell = (MessageTableViewCell *)o;
                break;
            }
        }
    }
    Message *n=[contentarr objectAtIndex:indexPath.row];
    [cell setcontextText:n.content  andphoto:n.image andVoice:n.soundData andType:n.messagetype andto:n.totype];

    return cell;


}
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.tableView.frame=CGRectMake(0, 0, 320, tableViewHeight+ty);
        self.toolView.frame=CGRectMake(0, tableViewHeight+ty, self.toolView.frame.size.width, self.toolView.frame.size.height);
        [self scrolltocurrentSection];
    }];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.tableView.frame=CGRectMake(0, 0, 320, tableViewHeight);
        self.toolView.frame=CGRectMake(0, tableViewHeight, self.toolView.frame.size.width, self.toolView.frame.size.height);
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addphoto_click:(id)sender {
    [__textField resignFirstResponder];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"返回" otherButtonTitles:@"图库",@"拍照", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];

}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //获取点击按钮的标题
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"拍照"])
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.delegate = self;
            imgPicker.allowsEditing=YES;
            imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imgPicker animated:YES completion:Nil];
        }
        
    }
    else if([buttonTitle isEqualToString:@"图库"])
    {
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate = self;
        imgPicker.allowsEditing=YES;
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imgPicker animated:YES completion:Nil];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

   [picker dismissViewControllerAnimated:YES completion:Nil];
    UIImage * photo = [info objectForKey:UIImagePickerControllerEditedImage];
    Message *n=[Message messageWithicon:nil andtime:nil andcontent:nil andimage:photo andsoundData:nil andtoType:MessageTypeMe andmessgeType:pic];
    [contentarr addObject:n];
    [self.tableView reloadData];
    [self scrolltocurrentSection];
}

-(void)scrolltocurrentSection{
    // 3、滚动至当前行
    if (contentarr.count!=0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:contentarr.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
   

}
#pragma mark - 语音按钮点击
- (IBAction)voiceBtnClick:(id)sender {
    if (__textField.hidden) { //输入框隐藏，按住说话按钮显示
        __textField.hidden = NO;
        self._speakBtn.hidden = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_nor.png"] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_press.png"] forState:UIControlStateHighlighted];
        [__textField becomeFirstResponder];
    }else{ //输入框处于显示状态，按住说话按钮处于隐藏状态
        __textField.hidden = YES;
        self._speakBtn.hidden = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor.png"] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_keyboard_press.png"] forState:UIControlStateHighlighted];
        [__textField resignFirstResponder];
    }
}
- (IBAction)recordVoice:(id)sender {
    //设置文件名
    self.originWav = [VoiceRecorderBaseVC getCurrentTimeString];
    //开始录音
    [recorderVC beginRecordByFileName:self.originWav];
    [VoiceConverter changeStu];
    //启动计时器
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self                                                                           selector:@selector(wavToAmrBtnPressed) object:nil];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (IBAction)upStopRecordVoice:(id)sender {
    [VoiceConverter changeStu];
    [recorderVC endRecord];
}
- (void)VoiceRecorderBaseVCRecordFinish:(NSString *)_filePath fileName:(NSString*)_fileName{
    NSLog(@"录音完成，文件路径:%@",_filePath);
    [self wavToAmrBtnPressed];
}
- (void)wavToAmrBtnPressed{
    if (originWav.length > 0){
        self.convertAmr = [originWav stringByAppendingString:@"wavToAmr"];
        
        //转格式
        [VoiceConverter wavToAmr:[VoiceRecorderBaseVC getPathByFileName:originWav ofType:@"wav"] amrSavePath:[VoiceRecorderBaseVC getPathByFileName:convertAmr ofType:@"amr"]];
        [self amrToWavBtnPressed];
    }
}
-(void)reloadmessage{
    [self.tableView reloadData];
    [self scrolltocurrentSection];
}

- (void)amrToWavBtnPressed{
    if (convertAmr.length > 0){
        self.convertWav = [originWav stringByAppendingString:@"amrToWav"];
       // NSLog(@"%@",convertWav);
     //   NSLog(@"%@",recorderVC.recordFilePath);
        Message *n=[Message messageWithicon:nil andtime:nil andcontent:nil andimage:nil andsoundData:recorderVC.recordFilePath andtoType:MessageTypeMe andmessgeType:sound];
        [contentarr addObject:n];
        [self performSelectorOnMainThread:@selector(reloadmessage) withObject:nil waitUntilDone:YES];
       

//        //转格式
//        [VoiceConverter amrToWav:[VoiceRecorderBaseVC getPathByFileName:convertAmr ofType:@"amr"] wavSavePath:[VoiceRecorderBaseVC getPathByFileName:convertWav ofType:@"wav"]];
//        
    }
}
@end
