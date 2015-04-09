//
//  HistoryTableViewController.m
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/6/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "HistoryDetailViewController.h"
#import "HistoryTableViewCell.h"

@interface HistoryTableViewController ()

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property NSMutableArray *objects;
@property (strong, nonatomic) NSArray *requests;
@end

@implementation HistoryTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveRequests];
}

- (void)retrieveRequests {
    PFQuery *query = [PFQuery queryWithClassName:@"Requests"];
    PFObject *request = [PFObject objectWithClassName:@"Requests"];
    if ([request[@"isHandled"] boolValue]) {
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            } else {
                self.requests = objects;
                [self.tableView reloadData];
                NSLog(@"%@", objects);
            }
        }];
    }
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshTable {
    [self.refreshControl endRefreshing];
    [self retrieveRequests];
    [self.tableView reloadData];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.requests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    PFObject *object = self.requests[indexPath.row];
    cell.studentNameLabel.text = object[@"name"];
    cell.dateLabel.text = object[@"createdAt"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
