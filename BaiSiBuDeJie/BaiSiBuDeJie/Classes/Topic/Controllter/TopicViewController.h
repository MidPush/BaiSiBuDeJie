//
//  TopicViewController.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "BaseRefreshViewController.h"

typedef NS_ENUM(NSUInteger, ViewControllerType) {
    ViewControllerTypeEssence = 1000,
    ViewControllerTypeNew = 1001
};
@interface TopicViewController : BaseRefreshViewController
@property (nonatomic, assign) EssenceTopicType essencetopicType;
@property (nonatomic, assign) NewTopicType newTopicType;
@property (nonatomic, assign) ViewControllerType viewControllerType;
@end
