//
//  sharedImageParser.h
//  searchApp
//
//  Created by Aman on 2/23/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sharedImageParser : NSObject
@property (nonatomic, strong) NSMutableArray *hits;
@property (nonatomic, strong) NSMutableArray *urlimg;
+(id)sharedManager;
-(void)parseForSearch:(NSDictionary *)responseDici;
@end
