//
//  TableViewCell.h
//  searchApp
//
//  Created by Aman on 2/8/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *ltitle;
@property (weak, nonatomic) IBOutlet UILabel *lurl;
@property (weak, nonatomic) IBOutlet UILabel *lcontent;
@property (weak, nonatomic) IBOutlet UIImageView *limage;


@end
