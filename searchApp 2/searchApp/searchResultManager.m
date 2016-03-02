//
//  searchResultManager.m
//  searchApp
//
//  Created by Aman on 2/29/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import "searchResultManager.h"
#import "CoreData/CoreData.h"
#import "sharedDB.h"
#import "sharedJsonParser.h"
#import "WebServiceManager.h"
#import "sharedImageParser.h"
@interface searchResultManager()
@property sharedDB *sharedDBInstance;
@property sharedJsonParser *sharedJsonInstance;
@property sharedImageParser *sharedImageInstance;
@property WebServiceManager *webServiceInstance;

@end
@implementation searchResultManager

+(id)sharedManager {
    static searchResultManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
       
    }
    return self;
}
-(int) decideForSearch:(NSString *)search
{
    int flag=0;
    
    self.sharedDBInstance =[sharedDB sharedManager];
    self.sharedDBInstance.managedObjectContext=self.managedObjectContext;
    flag=[[sharedDB sharedManager] setFlagForSearch:search];
    NSLog(@"*******%d",flag);
    
    
    if(flag== 0)
    {NSLog(@"API HIT");
        
        
        self.webServiceInstance =[WebServiceManager sharedManager];
        NSDictionary *responseDic=[self.webServiceInstance searchApiForSearch:search];
        
        self.sharedJsonInstance =[sharedJsonParser sharedManager];
        [self.sharedJsonInstance parseForSearch:responseDic];
        
        NSDictionary *responseDici=[self.webServiceInstance imageApiForSearch:search];
        self.sharedImageInstance =[sharedImageParser sharedManager];
        [self.sharedImageInstance parseForSearch:responseDici];
        return flag;
        // NSLog(@"%ld",self.urlimg.count);
    }
    else
    { NSLog(@"Core Data Fetch");
        return flag;
    }
}

@end
