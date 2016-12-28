//
//  XZPagesControllerTopBar.h
//  XZPagesController
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZPagesControllerTopBar;
@protocol XZPagesControllerTopBarDelegate <NSObject>
- (void)itemAtIndex:(NSUInteger)index didSelectInPagesContainerTopBar:(XZPagesControllerTopBar *)bar;
@end

@interface XZPagesControllerTopBar : UIView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) NSArray *itemTitles;
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIColor *selectedItemTitleColor;
@property (nonatomic, strong) UIFont *itemTileFont;
@property (nonatomic, strong) UIFont *selectedItemTileFont;
@property (nonatomic, weak) id <XZPagesControllerTopBarDelegate> delegate;

- (void)updateLineViewPosition;
@end
