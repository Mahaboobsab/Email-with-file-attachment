//
//  AttachmentTableViewController.m
//  EmailWithAttachment
//
//  Created by Mahaboob Nadaf on 28/10/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import "AttachmentTableViewController.h"

@interface AttachmentTableViewController ()

@end

@implementation AttachmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.files = [[NSArray alloc] init];
    _files = @[@"10 Great iPhone Tips.pdf", @"camera-photo-tips.html", @"foggy.jpg", @"Hello World.ppt", @"no more complaint.png", @"Why Appcoda.doc"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_files count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    AttachmentTableViewCell *cell = (AttachmentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.fileLabel.text = [_files objectAtIndex:indexPath.row];
    cell.thumbnail.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%d.png", (int)indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedFile = [_files objectAtIndex:indexPath.row];
    [self showEmail:selectedFile];
}


- (void)showEmail:(NSString*)file {
    
    NSString *emailTitle = @"Great Photo and Doc";
    NSString *messageBody = @"Hey, check this out!";
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    if ([MFMailComposeViewController canSendMail]){
        // Create and show composer
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Determine the file name and extension
        NSArray *filepart = [file componentsSeparatedByString:@"."];
        NSString *filename = [filepart objectAtIndex:0];
        NSString *extension = [filepart objectAtIndex:1];
        
        // Get the resource path and read the file using NSData
        NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        // Determine the MIME type
        NSString *mimeType;
        if ([extension isEqualToString:@"jpg"]) {
            mimeType = @"image/jpeg";
        } else if ([extension isEqualToString:@"png"]) {
            mimeType = @"image/png";
        } else if ([extension isEqualToString:@"doc"]) {
            mimeType = @"application/msword";
        } else if ([extension isEqualToString:@"ppt"]) {
            mimeType = @"application/vnd.ms-powerpoint";
        } else if ([extension isEqualToString:@"html"]) {
            mimeType = @"text/html";
        } else if ([extension isEqualToString:@"pdf"]) {
            mimeType = @"application/pdf";
        }
        
        // Add attachment
        [mc addAttachmentData:fileData mimeType:mimeType fileName:filename];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else{
        
        [self callAlert];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)attachPhoto:(id)sender {
     if ([MFMailComposeViewController canSendMail]){
         
        
     }
     else{
         [self callAlert];
     }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self sendMailWithImage:image];
    }
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void)sendMailWithImage:(UIImage *)image
{
    MFMailComposeViewController * mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    // make sure you can make NSData from the object
    [mailComposer addAttachmentData:UIImageJPEGRepresentation(image, 1.0) mimeType:@"image/jpg" fileName:@"My Image"];
    [self presentViewController:mailComposer animated:YES completion:nil];
}
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    // Dismiss PickerViewController
//    
//    [picker dismissModalViewControllerAnimated:NO];
//    
//    // Get Image Fro Attachment
//    
//    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    NSData* data = UIImageJPEGRepresentation(image, 1.0);
//    
//    // Setup Email Settings Like Subject, Message , Attachment
//    
//    
//    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
//    mailPicker.mailComposeDelegate = self;
//    
//    [mailPicker setSubject:@"Image Attachment Test"];
//    
//    
//    // Set recipients
//    
//    NSArray *toRecipients = [NSArray arrayWithObject:@"xyz.gmail.com"];
//    [mailPicker setToRecipients:toRecipients];
//    
//    // Set body message here
//    NSString *emailBody = @":)";
//    [picker setMessageBody:emailBody isHTML:NO];
//    
//    // Attach Image as Data
//    [mailPicker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"photo name"];
//    
//    [self presentModalViewController:mailPicker animated:YES];
//    
//    [mailPicker release];
//    
//    
//}//

-(void)callAlert{

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Device will not support"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

}
@end
