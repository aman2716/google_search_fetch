//
//  sharedDB.h
//  searchApp
//
//  Created by Aman on 2/23/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"
@interface sharedDB : NSObject
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSMutableArray *r;
@property (nonatomic, strong) NSMutableArray *corearr;
+(id)sharedManager;
-(int)setFlagForSearch:(NSString *)search;
-(void)saveEntityForSearch:(NSString *)search forTitle:(NSString *)title url:(NSString *)url content:(NSString *)content;
@end
