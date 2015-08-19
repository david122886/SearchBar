//
//  JCSearchBar.m
//  JCFindHouse
//
//  Created by Jam on 13-9-3.
//  Copyright (c) 2013年 jiamiao. All rights reserved.
//

#import "JCSearchBar.h"

@interface UIView(findSubView)
-(NSString*)getClassName;
-(UIView*)subViewWithClassName:(NSString*)className;

@end

@implementation UIView(findSubView)

-(UIView*)subViewWithClassName:(NSString*)className{
    return [self subViewWithClassName:className withCurrView:self];
}

-(UIView*)subViewWithClassName:(NSString*)className withCurrView:(UIView*)currentView{
    __block UIView *subView = nil;
//    const char *object_getClassName(id obj)
    [currentView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ([className isEqualToString:[view getClassName]]) {
            subView = view;
            *stop = YES;
        }else{
            subView = [self subViewWithClassName:className withCurrView:view];
        }
        NSLog(@"%@",view);
    }];
    return subView;
}

-(NSString*)getClassName{
    return NSStringFromClass([self class]);
}
@end
@implementation JCSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *needView = [self subViewWithClassName:@"UISearchBarBackground"];
        [needView removeFromSuperview];
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


@end
