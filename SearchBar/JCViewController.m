//
//  JCViewController.m
//  SearchBar
//
//  Created by xxsy-ima001 on 15/8/19.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "JCViewController.h"
#import "JCSearchBar.h"
@interface JCViewController ()<UISearchBarDelegate>
@property (strong,nonatomic) JCSearchBar *searchBar;
@end

@implementation JCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[JCSearchBar alloc] initWithFrame:(CGRect){10,100,300,50}];
    [self.view addSubview:self.searchBar];
    self.searchBar.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
}
@end
