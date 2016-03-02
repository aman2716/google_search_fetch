//
//  sharedJsonParser.h
//  searchApp
//
//  Created by Aman on 2/23/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sharedJsonParser : NSObject
@property (nonatomic, strong) NSMutableArray *restitle;
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) NSMutableArray *resurl;
@property (nonatomic, strong) NSMutableArray *rescontent;
+(id)sharedManager;
-(void)parseForSearch:(NSDictionary *)responseDic;
@end
