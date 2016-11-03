//
//  AttachmentTableViewCell.m
//  EmailWithAttachment
//
//  Created by Mahaboob Nadaf on 28/10/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import "AttachmentTableViewCell.h"

@implementation AttachmentTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
