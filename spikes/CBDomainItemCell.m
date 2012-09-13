//
//  CBDomainItemCell.m
//  spikes
//
//  Created by eytan on 9/13/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import "CBDomainItemCell.h"

@implementation CBDomainItemCell
@synthesize domainName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
