//
//  HelpRequestListTableViewController.m
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/7/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "HelpRequestListTableViewController.h"
#import "HelpStudentTableViewCell.h"
#import "DetailHelpStudentViewController.h"

@interface HelpRequestListTableViewController ()

@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end

@implementation HelpRequestListTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveRequests];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self refreshTable];
}

- (void)retrieveRequests {
    PFQuery *query = [PFQuery queryWithClassName:@"Requests"];
    [query whereKey:@"isHandled" equalTo:[NSNumber numberWithBool:NO]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            self.requests = [objects mutableCopy];
            [self.tableView reloadData];
            NSLog(@"%@", objects);
        }
    }];
}

- (void)refreshTable {
    [self.refreshControl endRefreshing];
    [self retrieveRequests];
    [self.tableView reloadData];
}

- (void)deleteRequest {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    PFObject *request = [PFObject objectWithClassName:@"Requests"];
    request = self.requests[indexPath.row];
    [request deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded && !error) {
            NSLog(@"request deleted from Requests table on Parse");
            [self.tableView reloadData];
        } else {
            NSLog(@"error: %@", error);
        }
    }];
}

- (void)udateRequest {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    PFObject *request = [PFObject objectWithClassName:@"Requests"];
    request = self.requests[indexPath.row];
    [request setObject:[NSNumber numberWithBool:YES] forKey:@"isHandled"];
    [request setObject:[NSNumber numberWithBool:YES] forKey:@"isResolved"];
    [request saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded && !error) {
            NSLog(@"request updated in Requests table on Parse");
            [self.tableView reloadData];
        } else {
            NSLog(@"error: %@", error);
        }
    }];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"assistDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *request = [PFObject objectWithClassName:@"Requests"];
        request = self.requests[indexPath.row];
        [[segue destinationViewController] setRequestItem:request];
    }
}

- (IBAction)unwindToUpdate:(UIStoryboardSegue *)segue
{
    [self udateRequest];
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.requests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HelpStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *request = [self.requests objectAtIndex:indexPath.row];
    cell.studentNameLabel.text = request[@"name"];
    NSLog(@"request name %@", request[@"name"]);
    cell.studentImageView.image = [UIImage imageNamed:request[@"imageName"]];
    return cell;
}

@end