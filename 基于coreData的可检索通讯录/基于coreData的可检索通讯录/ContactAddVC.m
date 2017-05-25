//
//  ContactAddVC.m
//  基于coreData的可检索通讯录
//
//  Created by 罗文琦 on 2017/5/25.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "ContactAddVC.h"
#import "Contact+CoreDataClass.h"
#import "CommonTool.h"
#import "JJCoreDataManager.h"

@interface ContactAddVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTxf;
@property (weak, nonatomic) IBOutlet UITextField *telNumTxf;

@end

@implementation ContactAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)rightSaveButtonClick:(id)sender {
    
    
    
    //创建对象,并且对对象的属性进行赋值',在保存之前应该还做一个非空判断,但是这里没时间就不做了
    //1.创建对象并且对对象的属性进行赋值
    Contact* newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:kJJCoreDataManager.managedObjectContext];
    newContact.name = self.nameTxf.text;
    newContact.telNum = self.telNumTxf.text;
    newContact.namePinYin = [CommonTool getPinYinFromString:self.nameTxf.text];
    newContact.sectionName = [[newContact.namePinYin substringToIndex:1] uppercaseString];
    
    //保存到数据库
    [kJJCoreDataManager save];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}


- (IBAction)leftCancelButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
