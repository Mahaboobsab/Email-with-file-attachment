//
//  AttachmentTableViewController.h
//  EmailWithAttachment
//
//  Created by Mahaboob Nadaf on 28/10/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AttachmentTableViewCell.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface AttachmentTableViewController : UITableViewController<MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) NSArray *files;
- (IBAction)attachPhoto:(id)sender;
@end
