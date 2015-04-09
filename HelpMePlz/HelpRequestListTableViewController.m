//
//  HelpRequestListTableViewController.m
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/7/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "HelpRequestListTableViewController.h"
#import "HelpStudentTableViewCell.h"

@interface HelpRequestListTableViewController ()

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property NSMutableArray *users;
@end

@implementation HelpRequestListTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveRequests];
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
            self.requests = objects;
            [self.tableView reloadData];
            NSLog(@"%@", objects);
        }
    }];
}

- (void)refreshTable {
    //TODO: refresh your data
    [self.refreshControl endRefreshing];
    [self retrieveRequests];
    [self.tableView reloadData];
}

- (void)insertNewObject:(id)sender {
    if (!self.users) {
        self.users = [[NSMutableArray alloc] init];
    }
    [self.users insertObject:[PFUser user] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
////        [[segue destinationViewController] setDetailItem:object];
//    }
//}

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