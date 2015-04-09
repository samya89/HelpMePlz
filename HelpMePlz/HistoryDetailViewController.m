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

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.helpDuration.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
