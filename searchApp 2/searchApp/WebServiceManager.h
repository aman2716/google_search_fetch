//
//  WebServiceManager.h
//  searchApp
//
//  Created by Aman on 2/29/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"

@interface WebServiceManager : NSObject
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
+(id)sharedManager;
-(NSDictionary *) searchApiForSearch:(NSString *)search;
-(NSDictionary *) imageApiForSearch:(NSString *)search;
@end
