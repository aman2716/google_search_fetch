//
//  sharedImageParser.m
//  searchApp
//
//  Created by Aman on 2/23/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import "sharedImageParser.h"

@implementation sharedImageParser
+(id)sharedManager {
    static sharedImageParser *sharedMyManager = nil;
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

- (void)parseForSearch:(NSDictionary *) responseDici
{
    
    
    self.hits =[responseDici objectForKey:@"hits"];
    self.urlimg=[[NSMutableArray alloc] init];
    
    for(int i=0;i<[self.hits count];i++)
    {
        NSDictionary *resdici=[self.hits objectAtIndex:i];
        NSString *str =[[NSString alloc]init];
        str=[resdici objectForKey:@"userImageURL"];
        if(![str isEqual:@""])
        {[self.urlimg addObject: [resdici objectForKey:@"userImageURL"]];}
    }
    
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
