//
//  ContactListVC.m
//  基于coreData的可检索通讯录
//
//  Created by 罗文琦 on 2017/5/25.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "ContactListVC.h"
#import <CoreData/CoreData.h>
#import "JJCoreDataManager.h"
#import "Contact+CoreDataClass.h"
#import "ContactEditVC.h"



@interface ContactListVC ()<NSFetchedResultsControllerDelegate,UISearchBarDelegate>

@property(nonatomic , strong) NSFetchedResultsController * fetchedResultsController;

@end

@implementation ContactListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 45;
    UISearchBar* searchBar = [[UISearchBar alloc]init];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    id<NSFetchedResultsSectionInfo>info = self.fetchedResultsController.sections[section];
    
    return info.numberOfObjects;
}


-(NSFetchedResultsController *)fetchedResultsController{

    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    //创建搜索谁
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Contact"];
    //根据被搜索对象的什么属性进行排序
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"namePinYin" ascending:YES]];
    //创建搜索结果控制器
    /*
     1.搜索谁
     2.上下文
     3.分组依据
     4.缓存名字
     */
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:kJJCoreDataManager.managedObjectContext sectionNameKeyPath:@"sectionName" cacheName:nil];
    
    //开始执行查询请求
    [_fetchedResultsController performFetch:nil];
    
    //代理主要是监听搜索变化的
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}





-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.fetchedResultsController.sectionIndexTitles[section];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ContactListVCCell" forIndexPath:indexPath];
    Contact* contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.telNum;
    return cell;
}




#pragma mark - 监听数据库内容变化
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath{
  [self.tableView reloadData];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[ContactEditVC class]]) {
        
         ContactEditVC *editVC = (ContactEditVC *)segue.destinationViewController;
        //创建控制器
        NSIndexPath* indexpath = [self.tableView indexPathForSelectedRow];
        //获取现在选中的数据
        Contact* selContact = [self.fetchedResultsController objectAtIndexPath:indexpath];
        editVC.watieEditContact = selContact; 
    }
}


//编辑相关三个代理

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取点击下标的对应的模型数据
    Contact *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //2.上下文删除数据
    [kJJCoreDataManager.managedObjectContext deleteObject:contact];
    //3.保存到数据库
    [kJJCoreDataManager save];
}

#pragma mark - 返回索引栏
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.fetchedResultsController.sectionIndexTitles;;
}

#pragma mark - seachBar里面的文字发生变化
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //1,将搜索的文本变为小写
    searchText = [searchText lowercaseString];
    NSPredicate *predicate;
    if (searchText.length > 0) {
        predicate = [NSPredicate predicateWithFormat:@"self.name CONTAINS %@ || self.namePinYin CONTAINS %@ || self.telNum CONTAINS %@",searchText,searchText,searchText];
    }
    else//搜索所有数据
    {
        predicate = nil;
    }
    //2.改变查询结果控制器查询请求的谓词即可
    self.fetchedResultsController.fetchRequest.predicate = predicate;
    //3.重新执行查询请求
    [self.fetchedResultsController performFetch:nil];
    //4.刷新tableView
    [self.tableView reloadData];

}


#pragma mark - scoll的时候
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.navigationController.view endEditing:YES];
}

@end





















