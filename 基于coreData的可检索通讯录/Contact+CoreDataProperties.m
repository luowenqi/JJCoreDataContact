//
//  Contact+CoreDataProperties.m
//  基于coreData的可检索通讯录
//
//  Created by 罗文琦 on 2017/5/25.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "Contact+CoreDataProperties.h"

@implementation Contact (CoreDataProperties)

+ (NSFetchRequest<Contact *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
}

@dynamic name;
@dynamic telNum;
@dynamic namePinYin;
@dynamic sectionName;

@end
