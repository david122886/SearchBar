//
//  ViewController.m
//  SearchBar
//
//  Created by xxsy-ima001 on 15/8/18.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "ViewController.h"
#import "DRSearchBar.h"
@interface ViewController ()<DRSearchBarDelegate,UISearchBarDelegate>
@property (strong,nonatomic) DRSearchBar *searchBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.searchBar = [[DRSearchBar alloc] init];
    
    self.searchBar.textColor = [UIColor whiteColor];
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    
//    self.searchBar.searchBtPosition = JCSearchBtPosition_Right;
    self.searchBar.frame = (CGRect){10,100,300,50};
//    self.searchBar.searchBtMargin = (UIEdgeInsets){5,5,5,5};
//    self.searchBar.searchBtMargin = (UIEdgeInsets){15,15,15,15};
//    self.searchBar.textFieldMargin = UIEdgeInsetsZero;
//    self.searchBar.textFieldMargin = (UIEdgeInsets){5,5,5,5};
    self.searchBar.backgroundColor = [UIColor orangeColor];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickef:(id)sender {
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
    }else{
        [self.searchBar becomeFirstResponder];
    }
    
}


//-(void)searchBar:(DRSearchBar *)searchBar textDidChange:(NSString *)searchText{
//    NSLog(@"%@",searchText);
//}

-(void)searchBarCanceled:(DRSearchBar *)searchBar{
    NSLog(@"cancel$$$$$$$$$$$");
}

-(void)searchBarSearchButtonClicked:(DRSearchBar *)searchBar{
    NSLog(@"begin search:%@##########",searchBar.text);
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
}
@end
