//
//  AttachmentTableViewCell.h
//  EmailWithAttachment
//
//  Created by Mahaboob Nadaf on 28/10/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttachmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

@end
