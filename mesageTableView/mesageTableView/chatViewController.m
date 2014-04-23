//
//  chatViewController.m
//  mesageTableView
//
//  Created by 李言 on 14-4-22.
//  Copyright (c) 2014年 李言. All rights reserved.
//

#import "chatViewController.h"
#import "MessageTableViewCell.h"
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
    contentarr=[[NSMutableArray alloc] initWithObjects:[NSDictionary dictionaryWithObject:@"1111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"pic"],[NSDictionary dictionaryWithObject:@"111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"pic"],[NSDictionary dictionaryWithObject:@"11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1" forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1" forKey:@"sound"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1" forKey:@"sound"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"pic"],[NSDictionary dictionaryWithObject:@"1" forKey:@"sound"],[NSDictionary dictionaryWithObject:@"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" forKey:@"text"],[NSDictionary dictionaryWithObject:@"1" forKey:@"sound"],[NSDictionary dictionaryWithObject:@"1" forKey:@"sound"],nil];
   // NSLog(@"%@",contentarr);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //设置textField输入起始位置
    __textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    __textField.leftViewMode = UITextFieldViewModeAlways;
    
    __textField.delegate = self;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[contentarr objectAtIndex:indexPath.row] objectForKey:@"text"]) {
        UIFont *font = [UIFont systemFontOfSize:16];
        CGSize size=[[[contentarr objectAtIndex:indexPath.row] objectForKey:@"text"] sizeWithFont:font constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height+40;
    }
    if ([[contentarr objectAtIndex:indexPath.row] objectForKey:@"pic"]) {
        return 170;
    }
    if ([[contentarr objectAtIndex:indexPath.row] objectForKey:@"sound"]) {
        return 60;
    }

    return 0;

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
    if ([[contentarr objectAtIndex:indexPath.row] objectForKey:@"pic"]) {
     [cell setcontextText:nil andType:@"2" andto:indexPath.row%2];
    }
    if ([[contentarr objectAtIndex:indexPath.row] objectForKey:@"sound"]) {
        [cell setcontextText:nil andType:@"3" andto:indexPath.row%2];
    }
    if ([[contentarr objectAtIndex:indexPath.row] objectForKey:@"text"]) {
        [cell setcontextText:[[contentarr objectAtIndex:indexPath.row] objectForKey:@"text"] andType:@"1" andto:indexPath.row%2];

    }

   
   
    return cell;


}
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
