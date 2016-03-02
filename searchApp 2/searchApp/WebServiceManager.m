//
//  WebServiceManager.m
//  searchApp
//
//  Created by Aman on 2/29/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import "WebServiceManager.h"

@implementation WebServiceManager
+(id)sharedManager {
    static WebServiceManager *sharedMyManager = nil;
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
-(NSDictionary *) searchApiForSearch:(NSString *)search
{
    NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=%@&key=AIzaSyBpXH4J1t-tq3AcyKaLltqnxL6YiR2Qt4M&rsz=8&start=0",search]];
    
    NSData *Data = [[NSData alloc] initWithContentsOfURL:url];
    
    NSError *error;
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:Data options:kNilOptions error:&error];
    return responseDic;
}
-(NSDictionary *) imageApiForSearch:(NSString *)search
{
    NSURL *urli= [NSURL URLWithString:[NSString stringWithFormat:@"https://pixabay.com/api/?key=2094402-90903fb1a6a8f638085d6e284&q=%@&image_type=photo",search]];
    
    NSData *Datai = [[NSData alloc] initWithContentsOfURL:urli];
    
    NSError *errori;
    NSDictionary *responseDici = [NSJSONSerialization JSONObjectWithData:Datai options:kNilOptions error:&errori];
    return responseDici;
}

@end
