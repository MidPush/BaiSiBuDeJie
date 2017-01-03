//
//  VisitorView.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/31.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VisitorViewDelegate <NSObject>
- (void)doLoginAction;
- (void)doRegisterAction;
@end

@interface VisitorView : UIView
@property (nonatomic, weak) id <VisitorViewDelegate> delegate;
@end
