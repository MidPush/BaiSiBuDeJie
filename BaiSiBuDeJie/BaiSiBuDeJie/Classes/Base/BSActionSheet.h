//
//  BSActionSheet.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/28.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSActionSheet;
@protocol BSActionSheetDelegate <NSObject>
- (void)bs_actionSheet:(BSActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
@interface BSActionSheet : UIView
- (instancetype)initWithTitles:(NSArray *)titles delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle;
- (void)show;
@property (nonatomic, weak) id <BSActionSheetDelegate> delegate;
@end
