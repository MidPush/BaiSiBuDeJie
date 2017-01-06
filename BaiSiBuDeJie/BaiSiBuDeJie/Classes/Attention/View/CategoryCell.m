//
//  CategoryCell.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/31.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "CategoryCell.h"
#import "RecommandCategory.h"

@implementation CategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = kThemeColor;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)setCategory:(RecommandCategory *)category {
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.selectedBackgroundView.width = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.backgroundColor = selected ? [UIColor whiteColor] : [UIColor clearColor];
    self.textLabel.textColor = selected ?  kThemeColor : [UIColor blackColor];
}

@end
