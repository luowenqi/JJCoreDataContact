//
//  Contact+CoreDataProperties.h
//  基于coreData的可检索通讯录
//
//  Created by 罗文琦 on 2017/5/25.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "Contact+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contact (CoreDataProperties)

+ (NSFetchRequest<Contact *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *telNum;
@property (nullable, nonatomic, copy) NSString *namePinYin;
@property (nullable, nonatomic, copy) NSString *sectionName;

@end

NS_ASSUME_NONNULL_END
