//
//  sharedJsonParser.m
//  searchApp
//
//  Created by Aman on 2/23/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import "sharedJsonParser.h"

@implementation sharedJsonParser
+(id)sharedManager {
    static sharedJsonParser *sharedMyManager = nil;
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

- (void)parseForSearch:(NSDictionary *) responseDic
{
    
    
    NSDictionary *responseData=[responseDic objectForKey:@"responseData"];
    self.results =[responseData objectForKey:@"results"];
    self.restitle=[[NSMutableArray alloc]init];
    self.resurl=[[NSMutableArray alloc]init];
    self.rescontent=[[NSMutableArray alloc]init];
    
    for(int i=0;i<[self.results count];i++)
    {
        NSDictionary *resdic=[self.results objectAtIndex:i];
        [self.restitle addObject: [resdic objectForKey:@"titleNoFormatting"]];
        [self.resurl addObject: [resdic objectForKey:@"url"]];
        [self.rescontent addObject: [resdic objectForKey:@"content"]];
        
        
    }

}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
