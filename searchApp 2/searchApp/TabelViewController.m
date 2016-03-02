//
//  TableViewController.m
//  searchApp
//
//  Created by Aman on 2/8/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "TableViewCell.h"
#import "WebViewController.h"
#import "CoreData/CoreData.h"
#import "UIImageView+webCache.h"
#import "sharedDB.h"
#import "sharedIMageParser.h"
#import "sharedJsonParser.h"
#import "searchResultManager.h"
@interface TableViewController ()
{
   int flag;
    int i;
}
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) sharedDB *sharedDBInstance;
@property (nonatomic, strong) sharedImageParser *sharedImageInstance;
@property (nonatomic, strong) sharedJsonParser *sharedJsonInstance;
@property (nonatomic, strong) searchResultManager *searchResultInstance;


@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
   

    self.sharedDBInstance =[sharedDB sharedManager];
    
        self.sharedJsonInstance =[sharedJsonParser sharedManager];
                self.sharedImageInstance =[sharedImageParser sharedManager];
    self.searchResultInstance=[searchResultManager sharedManager];
    self.searchResultInstance.managedObjectContext=self.managedObjectContext;
    flag= [self.searchResultInstance decideForSearch:self.search];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(flag==0)
    {NSLog(@"%lu",self.sharedJsonInstance.results.count);return self.sharedJsonInstance.results.count;}
    else
    {NSLog(@"%lu",self.sharedDBInstance.corearr.count); return self.sharedDBInstance.corearr.count;}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  //  NSLog(@"******");
    if(flag== 0)
    {
        
    cell.ltitle.text = [self.sharedJsonInstance.restitle objectAtIndex:indexPath.row];
    cell.lurl.text= [self.sharedJsonInstance.resurl objectAtIndex:indexPath.row];
    cell.lcontent.text=[self.sharedJsonInstance.rescontent objectAtIndex:indexPath.row];
   
    NSString *stringURL =[NSString stringWithFormat:@"%@",[self.sharedImageInstance.urlimg objectAtIndex:indexPath.row]];
        
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    UIImage *img=[[UIImage alloc] initWithData:urlData];
        cell.limage.image=img;
        
        
        
        NSString  *filePath = [self getPathToDiskForSearch:self.search forIndexPath:indexPath];
        [urlData writeToFile:filePath atomically:YES];
        
        [self.sharedDBInstance saveEntityForSearch:self.search forTitle:cell.ltitle.text url:cell.lurl.text content:cell.lcontent.text];
        NSError *error = nil;
        [self.managedObjectContext save:&error];
    }
    if(flag==1)
    {
        
        NSLog(@"****From Core Data");
        
        NSManagedObject *info=[self.sharedDBInstance.corearr objectAtIndex:indexPath.row];
        
            NSString *t=[info valueForKey:@"key"];
            if([self.search isEqualToString:t])
            {
                [cell.ltitle setText:[NSString stringWithFormat:@"%@", [info valueForKey:@"title"]]];
                [cell.lurl setText:[NSString stringWithFormat:@"%@", [info valueForKey:@"url"]]];
                [cell.lcontent setText:[NSString stringWithFormat:@"%@", [info valueForKey:@"content"]]];
                
                
            }
       
        
        NSString  *filePath = [self getPathToDiskForSearch:self.search forIndexPath:indexPath];
        UIImage *im=[UIImage imageWithContentsOfFile:filePath];
        cell.limage.image=im;
        

        
    }
  

    if (indexPath.row % 2==0) {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:0.9 green:0.85 blue:0.75 alpha:1];
    }
    
    
    return cell;
}


-(NSString *)getPathToDiskForSearch:(NSString *)search forIndexPath:(NSIndexPath *)indexPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString  *filePath = [NSString stringWithFormat:@"%@/%ld%@%@", documentsDirectory,indexPath.row,search,@".png"];
    return filePath;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showWeb"])
    {
        WebViewController *wv = segue.destinationViewController;
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        if(flag==0)
        wv.url=self.sharedJsonInstance.resurl[indexPath.row];
        else
        {
            NSManagedObject *info=[self.sharedDBInstance.corearr objectAtIndex:indexPath.row];
            wv.url=[info valueForKey:@"url"];

        }

    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
