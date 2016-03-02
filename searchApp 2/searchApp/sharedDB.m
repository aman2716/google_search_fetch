//
//  sharedDB.m
//  searchApp
//
//  Created by Aman on 2/23/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import "sharedDB.h"
#import "CoreData/CoreData.h"
#import "sharedJsonParser.h"
@interface sharedDB ()
{
    int flag;
   
}

@property (nonatomic, strong) sharedJsonParser *sharedJsonManager;
@end

@implementation sharedDB
+(id)sharedManager {
    static sharedDB *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        flag=0;
    }
    return self;
}

-(int)setFlagForSearch:(NSString *)search
{
    flag=0;
    self.corearr=[[NSMutableArray alloc] init];
    //NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Entity"];
    [request setReturnsDistinctResults:YES];
    NSArray *fetch = [[self.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    
    self.r=[[NSMutableArray alloc]init];
    
    for (id obj in fetch) {
        if (![self.r containsObject:obj]) {
            [self.r addObject:obj];
        }
    }
    NSLog(@"****%lu",self.r.count);
    for (int i=0;i<self.r.count;i++)
    {
        // NSLog(@"%@",[info valueForKey:@"key"]);
        NSManagedObject *info =[self.r objectAtIndex:i];
        if([search isEqualToString:[NSString stringWithFormat:@"%@",[info valueForKey:@"key"]]])
        {
            flag=1;
            [self.corearr addObject:info];
        }
    }
    NSLog(@"####%lu",self.corearr.count);

    return flag;
    
}
-(void)saveEntityForSearch:(NSString *)search forTitle:(NSString *)title url:(NSString *)url content:(NSString *)content
{
    self.sharedJsonManager =[sharedJsonParser sharedManager];
    
    NSManagedObject *ent = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:self.managedObjectContext];
    
    [ent setValue:title forKey:@"title"];
    [ent setValue:url forKey:@"url"];
    [ent setValue:content forKey:@"content"];
    [ent setValue:search forKey:@"key"];
    NSError *error = nil;
    [self.managedObjectContext save:&error];
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
