//
//  ViewController.m
//  searchApp
//
//  Created by Aman on 2/4/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
@interface ViewController ()
@property (nonatomic, strong) NSString *searchText;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
  //  NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[self.webView loadRequest:request];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)searchBar:(UISearchBar *) searchBar textDidChange:(NSString *) mySearch
{
    self.searchText=mySearch;
   // NSLog(@"%@",self.searchText);
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showResult"])
    {
        TableViewController *tv=segue.destinationViewController;
        //tv.sa=[[NSMutableArray alloc] init];
        tv.search=self.searchText;
        
    }
}

@end
