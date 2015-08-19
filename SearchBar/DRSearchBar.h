//
//  DRSearchBar.h
//  JCFindHouse
//
//  Created by Jam on 13-9-3.
//  Copyright (c) 2013年 jiamiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DRSearchBtPosition) {
    DRSearchBtPosition_Left,
    DRSearchBtPosition_Right
};

@class DRSearchBar;
/**
 * 实现UISearchBar相同功能，且能自定义搜索区域和边缘颜色，能设置搜索按钮摆放位置
 */
@protocol DRSearchBarDelegate <NSObject>
- (void)searchBarSearchButtonClicked:(DRSearchBar *)searchBar;
- (void)searchBarCanceled:(DRSearchBar *)searchBar;
@end
@interface DRSearchBar : UIView
@property (weak,nonatomic) id<DRSearchBarDelegate> delegate;

#pragma mark -
#pragma mark -- 搜索文本
@property (strong,nonatomic) UIColor *textColor;
@property (strong,nonatomic) UIColor *textBackgroundColor;
@property (strong,nonatomic) UIFont *textFont;
@property (strong,nonatomic,readonly) NSString *text;
@property (strong,nonatomic) NSString *placeHolder;
@property (assign,nonatomic) UIEdgeInsets textFieldMargin;
@property (assign,nonatomic) UIEdgeInsets searchBtMargin;
#pragma mark -

#pragma mark -
#pragma mark -- 搜索按钮
@property (strong,nonatomic) UIImage            *searchBtImage;
@property (assign,nonatomic) DRSearchBtPosition searchBtPosition;
#pragma mark -

#pragma mark -
#pragma mark -- 第一响应连
- (BOOL)canBecomeFirstResponder;    // default is NO
- (BOOL)becomeFirstResponder;

- (BOOL)canResignFirstResponder;    // default is YES
- (BOOL)resignFirstResponder;

- (BOOL)isFirstResponder;
#pragma mark -
@end
