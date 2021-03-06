//
//  HistoryDetailViewController.m
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/6/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "HistoryDetailViewController.h"

@interface HistoryDetailViewController ()

@end

@implementation HistoryDetailViewController

#pragma mark - Managing the detail item

- (void)setRequestItem:(id)newDetailItem {
    if (_archiveItem != newDetailItem) {
        _archiveItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.archiveItem) {
        NSString *parseDateAndTime = [NSString stringWithFormat:@"%@", self.archiveItem.createdAt];
        NSArray *postDateSplit = [parseDateAndTime componentsSeparatedByString:@" "];
        self.dateLabel.text = [postDateSplit objectAtIndex:0];
        self.helpDuration.text = [postDateSplit objectAtIndex:1];
        self.studentNameLabel.text = self.archiveItem[@"name"];
        self.studentImage.image = [UIImage imageNamed:self.archiveItem[@"imageName"]];
        self.notesLabel.text = self.archiveItem[@"notes"];
        if ([self.archiveItem[@"issueResolved"] boolValue]==YES) {
            self.issueResolvedLabel.text = @"YES";
            self.issueResolvedLabel.textColor = [UIColor greenColor];
        }
        else if ([self.archiveItem[@"issueResolved"] boolValue] == NO) {
            self.issueResolvedLabel.text = @"NO";
            self.issueResolvedLabel.textColor = [UIColor orangeColor];
        }
    }
    else {
        NSLog(@"User doesn't exist");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

@end
