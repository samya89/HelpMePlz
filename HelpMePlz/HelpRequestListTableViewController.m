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

@property (strong, nonatomic) UIRefreshControl *refreshControl;
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
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

- (void)retrieveRequests {
    PFQuery *query = [PFQuery queryWithClassName:@"Requests"];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
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
//    PFObject *request = [PFObject objectWithClassName:@"Requests"];
//    PFObject *request = [self.requests objectAtIndex:self.indexPath.row];
//    [request deleteInBackground];
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
    PFObject *request = [self.requests objectAtIndex:self.indexPath.row];
    [self.requests removeObject:request];
//    [self deleteRequest];
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
    cell.studentImageView.image = [UIImage imageNamed:@"year_of_monkey-75.png"];
    return cell;
}

@end