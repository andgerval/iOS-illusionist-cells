//
//  ParentTableViewCell.m
//  Illusionist Cells Demo
//
//  Created by Red Valdez on 1/1/18.
//  Copyright © 2018 Red Valdez. All rights reserved.
//

#import "ParentTableViewCell.h"

@implementation ParentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didMoveToSuperview {
    self.contentView.backgroundColor = [self randomColor];
}

- (UIColor *)randomColor {
    float red = (arc4random()  % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
