//
//  ChildTableViewCell.m
//  Illusionist Cells Demo
//
//  Created by Red Valdez on 1/1/18.
//  Copyright © 2018 Red Valdez. All rights reserved.
//

#import "ChildTableViewCell.h"

@implementation ChildTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    [self matchSuperViewWidth];
    
    // Manually create line seperator for child cells.
    UIView *seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height - 0.5, self.contentView.bounds.size.width, 0.5)];
    seperatorLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:seperatorLine];
}

// Set the cells contentView width to the width of the table view(superview).
- (void)matchSuperViewWidth {
    CGRect frame = CGRectMake(0, 0, self.superview.bounds.size.width, self.contentView.bounds.size.height);
    self.contentView.frame = frame;
}

@end
