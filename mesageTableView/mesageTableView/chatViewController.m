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
@interface chatViewController ()

@end

@implementation chatViewController

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
//    contentarr=[[NSMutableArray alloc] initWithObjects:[NSDictionary dictionaryWithObject:@"1111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:image forKey:@"pic"],[NSDictionary dictionaryWithObject:@"111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:image forKey:@"pic"],[NSDictionary dictionaryWithObject:@"11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"forKey:@"text"],[NSDictionary dictionaryWithObject:image forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:image forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:image forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:image forKey:@"pic"],[NSDictionary dictionaryWithObject:image forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:image forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1" forKey:@"sound"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:image forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1" forKey:@"sound"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:image forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1" forKey:@"sound"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"sound"],[NSDictionary dictionaryWithObject:@"1" forKey:@"sound"],nil];
   // NSLog(@"%@",contentarr);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //设置textField输入起始位置
    __textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    __textField.leftViewMode = UITextFieldViewModeAlways;
    
    __textField.delegate = self;


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
    
    // 1、增加数据源
    NSString *content = textField.text;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    Message *n=[Message messageWithicon:nil andtime:time andcontent:textField.text andimage:nil andsoundData:nil andtoType:MessageTypeMe andmessgeType:text];
    NSLog(@"%@",n );
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
    MessageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"message"];
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
    
    switch (n.messagetype) {
        case text:
            [cell setcontextText:n.content  andphoto:nil andType:n.messagetype andto:n.totype];

            break;
            case pic:
               [cell setcontextText:nil andphoto:n.image andType:n.messagetype andto:n.totype];
            break;
            case sound:
            [cell setcontextText:nil andphoto:nil andType:n.messagetype andto:n.totype];
            break;
            
        default:
            break;
    }
//    if ([[contentarr objectAtIndex:indexPath.row] objectForKey:@"pic"]) {
//          }
//    if ([[contentarr objectAtIndex:indexPath.row] objectForKey:@"sound"]) {
//        
//    }
//    if ([[contentarr objectAtIndex:indexPath.row] objectForKey:@"text"]) {
//     
//
//    }

   
   
    return cell;


}
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
  

    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.tableView.frame=CGRectMake(0, 0, 320, 525+ty);
        self.toolView.frame=CGRectMake(0, 525+ty, self.toolView.frame.size.width, self.toolView.frame.size.height);
        [self scrolltocurrentSection];
         //  self.toolView.transform = CGAffineTransformMakeTranslation(0, ty);
          //  self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.tableView.frame=CGRectMake(0, 0, 320, 525);
        self.toolView.frame=CGRectMake(0, 525, self.toolView.frame.size.width, self.toolView.frame.size.height);
      //  self.toolView.transform = CGAffineTransformIdentity;
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
//            isCamera=YES;
            UIImagePickerController *imgPicker = [UIImagePickerController new];
            imgPicker.delegate = self;
            imgPicker.allowsEditing=YES;
            imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentModalViewController:imgPicker animated:YES];
            [self presentViewController:imgPicker animated:YES completion:Nil];
        }
        
    }
    else if([buttonTitle isEqualToString:@"图库"])
    {
//        isCamera=NO;
        UIImagePickerController *imgPicker = [UIImagePickerController new];
        imgPicker.delegate = self;
        imgPicker.allowsEditing=YES;
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        //        [self presentModalViewController:imgPicker animated:YES];
        [self presentViewController:imgPicker animated:YES completion:Nil];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:Nil];
    UIImage * photo = [info objectForKey:UIImagePickerControllerEditedImage];
    Message *n=[Message messageWithicon:nil andtime:nil andcontent:nil andimage:photo andsoundData:nil andtoType:MessageTypeMe andmessgeType:pic];
  //  [contentarr addObject:n];

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

@end
