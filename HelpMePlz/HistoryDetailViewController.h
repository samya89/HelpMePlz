//
//  HistoryDetailViewController.h
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/6/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *studentImage;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *helpDuration;
@property (weak, nonatomic) IBOutlet UILabel *issueResolvedLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

@end

