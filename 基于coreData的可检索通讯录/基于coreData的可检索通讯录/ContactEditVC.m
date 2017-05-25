//
//  contactEditVC.m
//  基于coreData的可检索通讯录
//
//  Created by 罗文琦 on 2017/5/25.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "ContactEditVC.h"
#import "CommonTool.h"
#import "JJCoreDataManager.h"
#import "Contact+CoreDataClass.h"


@interface ContactEditVC ()

/**
 姓名文本
 */
@property (weak, nonatomic) IBOutlet UITextField *nameTxf;

/**
 电话文本
 */
@property (weak, nonatomic) IBOutlet UITextField *telNumTxf;

@end

@implementation ContactEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTxf.text = self.watieEditContact.name;
    self.telNumTxf.text = self.watieEditContact.telNum;
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rightSaveButtonClick:(id)sender {
    
    //对结果进行编辑,并且最后赋值
    
    self.watieEditContact.name = self.nameTxf.text;
    self.watieEditContact.telNum = self.telNumTxf.text;
    self.watieEditContact.namePinYin = [CommonTool getPinYinFromString:self.nameTxf.text];
    self.watieEditContact.sectionName = [[self.watieEditContact.namePinYin substringToIndex:1] uppercaseString];
    
    [kJJCoreDataManager save];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
