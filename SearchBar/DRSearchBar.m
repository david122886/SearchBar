//
//  DRSearchBar.m
//  JCFindHouse
//
//  Created by Jam on 13-9-3.
//  Copyright (c) 2013年 jiamiao. All rights reserved.
//

#import "DRSearchBar.h"
@interface DRSearchBar()<UITextFieldDelegate>
@property (strong,nonatomic) UITextField *textField;
@property (strong,nonatomic) UIImageView *searchBtImageView;
@property (strong,nonatomic) UIButton *cancelBt;
@property (strong,nonatomic) UIView *textFieldBackView;


@property (strong,nonatomic) NSArray *textFieldConstraints;
@end

@implementation DRSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultValue];
        self.textFieldBackView = [[UIView alloc] init];
        self.textField = [[UITextField alloc] init];
        self.searchBtImageView  = [[UIImageView alloc] initWithImage:self.searchBtImage];
        self.cancelBt  = [[UIButton alloc] init];
        
        self.textFieldBackView.translatesAutoresizingMaskIntoConstraints = NO;
        self.textField.translatesAutoresizingMaskIntoConstraints = NO;
        self.searchBtImageView.translatesAutoresizingMaskIntoConstraints  = NO;
        self.cancelBt.translatesAutoresizingMaskIntoConstraints  = NO;
        
        [self addSubview:self.textFieldBackView];
        [self addSubview:self.cancelBt];
        
        [self.textFieldBackView addSubview:self.textField];
        [self.textFieldBackView addSubview:self.searchBtImageView];
        
        [self.textFieldBackView addConstraints:self.textFieldConstraints = [self textFieldBackViewConstraints]];
        [self addConstraints:[self selfViewConstraints]];
        
        
        self.textFieldBackView.layer.cornerRadius = 5;
        self.textFieldBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.textFieldBackView.layer.borderWidth = 1.0;
        self.textFieldBackView.backgroundColor = self.textBackgroundColor;
        
        self.textField.font = self.textFont;
        self.textField.textColor = self.textColor;
        self.textField.backgroundColor = [UIColor clearColor];
        self.textField.placeholder = self.placeHolder;
        self.textField.returnKeyType = UIReturnKeySearch;
        self.textField.delegate = self;
        self.textField.borderStyle = UITextBorderStyleNone;
        self.textField.enablesReturnKeyAutomatically = YES;
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        self.searchBtImageView.backgroundColor = [UIColor clearColor];
        
        [self.cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        self.cancelBt.backgroundColor = [UIColor clearColor];
        self.cancelBt.titleLabel.font = self.textFont;
        [self.cancelBt addTarget:self action:@selector(cancelBtClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.layer.cornerRadius = 5;
        
        
    }
    return self;
}


-(void)setupDefaultValue{
    _textColor        = [UIColor blackColor];
    _textBackgroundColor = [UIColor lightGrayColor];
    _textFont         = [UIFont systemFontOfSize:15];
    _placeHolder      = @"搜索";
    _textFieldMargin  = (UIEdgeInsets){5,5,5,5};
    
    _searchBtImage    = [UIImage imageNamed:@"tabbar_search.png"];
    _searchBtPosition = DRSearchBtPosition_Left;
    _searchBtMargin = (UIEdgeInsets){5,5,5,5};
}

#pragma mark -
#pragma mark -- 约束设置

-(NSArray*)textFieldBackViewConstraints{
    NSMutableArray *constraints = @[].mutableCopy;
    //textField
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textField]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textField)]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_textField]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textField)]];
    
    //searchimageView
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view]-(<=1)-[superView]"
                                                                             options:NSLayoutFormatAlignAllCenterY
                                                                             metrics:nil
                                                                               views:@{@"view":self.searchBtImageView,@"superView":self.textFieldBackView}]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-(<=1)-[superView]"
                                                                             options:NSLayoutFormatAlignAllCenterX
                                                                             metrics:nil
                                                                               views:@{@"view":self.searchBtImageView,@"superView":self.textFieldBackView}]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.searchBtImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.searchBtImageView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.searchBtImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.textFieldBackView attribute:NSLayoutAttributeHeight multiplier:1 constant:-(self.searchBtMargin.top+self.searchBtMargin.bottom)]];
    return constraints;
}

-(NSArray*)selfViewConstraints{
    NSMutableArray *constraints = @[].mutableCopy;
    //_textFieldBackView
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[_textFieldBackView]-right-[_cancelBt]|" options:0 metrics:@{@"left":@(self.textFieldMargin.left),@"right":@(self.textFieldMargin.right)} views:NSDictionaryOfVariableBindings(_textFieldBackView,_cancelBt)]];

    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_textFieldBackView]-bo-|" options:0 metrics:@{@"top":@(self.textFieldMargin.top
                                                                                                                                          ),@"bo":@(self.textFieldMargin.bottom)} views:NSDictionaryOfVariableBindings(_textFieldBackView)]];

    //cancelBt
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cancelBt]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cancelBt)]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.cancelBt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.cancelBt attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    return constraints;
}


-(void)searchBtChangeLeftConstraints{
    __block NSLayoutConstraint *searchImageCenterXCon = nil;
    __block NSLayoutConstraint *textFieldLeadingCon = nil;
    [self.textFieldConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if (constraint.firstItem == self.searchBtImageView && constraint.secondItem == self.textFieldBackView && constraint.firstAttribute == NSLayoutAttributeCenterX) {
            searchImageCenterXCon = constraint;
        }
        if (constraint.firstItem == self.textField && constraint.secondItem == self.textFieldBackView && constraint.firstAttribute == NSLayoutAttributeLeading) {
            textFieldLeadingCon = constraint;
        }
    }];
    searchImageCenterXCon.constant      = -1*(CGRectGetWidth(self.textFieldBackView.frame)/2 - CGRectGetWidth(self.searchBtImageView.frame)/2- self.searchBtMargin.left);
    textFieldLeadingCon.constant = CGRectGetWidth(self.searchBtImageView.frame) + self.searchBtMargin.left + self.searchBtMargin.right;
    
}

-(void)searchBtChangeRightConstraints{
    __block NSLayoutConstraint *searchImageCenterXCon = nil;
    __block NSLayoutConstraint *textFieldTailCon = nil;
    [self.textFieldConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if (constraint.firstItem == self.searchBtImageView && constraint.secondItem == self.textFieldBackView && constraint.firstAttribute == NSLayoutAttributeCenterX) {
            searchImageCenterXCon = constraint;
        }
        if (constraint.firstItem == self.textField && constraint.secondItem == self.textFieldBackView && constraint.firstAttribute == NSLayoutAttributeTrailing) {
            textFieldTailCon = constraint;
        }
    }];
    searchImageCenterXCon.constant   = (CGRectGetWidth(self.textFieldBackView.frame)/2 - CGRectGetWidth(self.searchBtImageView.frame)/2- self.searchBtMargin.left);
    textFieldTailCon.constant = CGRectGetWidth(self.searchBtImageView.frame) + self.searchBtMargin.left + self.searchBtMargin.right;
    
}

-(void)searchBtChangeCenterConstraints{
    __block NSLayoutConstraint *searchImageCenterXCon = nil;
    __block NSLayoutConstraint *textFieldLeadingCon = nil;
    __block NSLayoutConstraint *textFieldTailCon = nil;
    [self.textFieldConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if (constraint.firstItem == self.searchBtImageView && constraint.secondItem == self.textFieldBackView && constraint.firstAttribute == NSLayoutAttributeCenterX) {
            searchImageCenterXCon = constraint;
        }
        if (constraint.firstItem == self.textField && constraint.secondItem == self.textFieldBackView && constraint.firstAttribute == NSLayoutAttributeLeading) {
            textFieldLeadingCon = constraint;
        }
        if (constraint.firstItem == self.textField && constraint.secondItem == self.textFieldBackView && constraint.firstAttribute == NSLayoutAttributeTrailing) {
            textFieldTailCon = constraint;
        }
    }];
    searchImageCenterXCon.constant = 0;
    textFieldLeadingCon.constant = 0;
    textFieldLeadingCon.constant = 0;
}

#pragma mark -


#pragma mark -
#pragma mark -- 事件处理
-(void)cancelBtClicked:(UIButton*)bt{
    if (!self.textField.text || [self.textField.text isEqualToString:@""]) {
        [self searchBtChangeCenterConstraints];
        [UIView animateWithDuration:0.5 animations:^{
            [self layoutIfNeeded];
            [self.textField resignFirstResponder];
        }];
    }else{
        [self.textField resignFirstResponder];
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarCanceled:)]) {
        [self.delegate searchBarCanceled:self];
    }
}
#pragma mark -

#pragma mark -
#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    _text = textField.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        [self.delegate searchBarSearchButtonClicked:self];
    }
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.searchBtPosition == DRSearchBtPosition_Left) {
        [self searchBtChangeLeftConstraints];
    }else{
        [self searchBtChangeRightConstraints];
    }
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"txt:%@,,,string:%@,,range:%@",textField.text,string,NSStringFromRange(range));
    return YES;
}
#pragma mark -


#pragma mark -
#pragma mark -- 判断第一响应连
- (BOOL)canBecomeFirstResponder{
    return [self.textField canBecomeFirstResponder];
}
- (BOOL)becomeFirstResponder{
    return [self.textField becomeFirstResponder];
}

- (BOOL)canResignFirstResponder{
    return [self.textField canResignFirstResponder];
}
- (BOOL)resignFirstResponder{
    if (!self.textField.text || [self.textField.text isEqualToString:@""]) {
        [self searchBtChangeCenterConstraints];
        [UIView animateWithDuration:0.5 animations:^{
            [self layoutIfNeeded];
            [self.textField resignFirstResponder];
        }];
    }
    
    return  [self.textField resignFirstResponder];
}

- (BOOL)isFirstResponder{
    return self.textField.isFirstResponder;
}
#pragma mark -

#pragma mark -
#pragma mark -- 搜索文本
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.textField.textColor = textColor;
}

-(void)setTextBackgroundColor:(UIColor *)textBackgroundColor{
    _textBackgroundColor = textBackgroundColor;
    self.textFieldBackView.backgroundColor = textBackgroundColor;
}

-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    self.textField.font = textFont;
}

-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.textField.placeholder = placeHolder;
}

-(void)setTextFieldMargin:(UIEdgeInsets)textFieldMargin{
    _textFieldMargin = textFieldMargin;
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if (constraint.firstItem == self.textFieldBackView || constraint.secondItem == self.textFieldBackView) {
            switch (constraint.firstAttribute) {
                case NSLayoutAttributeTop:
                    constraint.constant = textFieldMargin.top;
                    break;
                case NSLayoutAttributeBottom:
                    constraint.constant = textFieldMargin.bottom;
                    break;
                case NSLayoutAttributeLeading:
                    constraint.constant = textFieldMargin.left;
                    break;
                case NSLayoutAttributeTrailing:
                    constraint.constant = textFieldMargin.right;
                    break;
                default:
                    break;
            }
        }
    }];
    [self layoutIfNeeded];
}

-(void)setSearchBtMargin:(UIEdgeInsets)searchBtMargin{
    _searchBtMargin = searchBtMargin;
    
    
    __block NSLayoutConstraint *textFieldCon = nil;
    [self.textFieldConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if (constraint.firstItem == self.searchBtImageView && constraint.secondItem == self.textFieldBackView && constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondAttribute == NSLayoutAttributeHeight) {
            textFieldCon = constraint;
            *stop = YES;
        }
    }];
    textFieldCon.constant = -(searchBtMargin.top+searchBtMargin.bottom);
    [self layoutIfNeeded];
}
#pragma mark -

#pragma mark -
#pragma mark -- 搜索按钮
-(void)setSearchBtImage:(UIImage *)searchBtImage{
    _searchBtImage = searchBtImage;
    
}

-(void)setSearchBtPosition:(DRSearchBtPosition)searchBtPosition{
    _searchBtPosition = searchBtPosition;
    
}
#pragma mark -

@end
