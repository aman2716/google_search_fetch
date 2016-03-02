//
//  searchResultManager.h
//  searchApp
//
//  Created by Aman on 2/29/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"

@interface searchResultManager : NSObject
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
+(id)sharedManager;
-(int) decideForSearch:(NSString *)search;
@end
