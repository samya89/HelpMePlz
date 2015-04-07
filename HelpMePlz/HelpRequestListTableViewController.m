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

@property NSMutableArray *users;
@end

@implementation HelpRequestListTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query whereKey:@"TA" equalTo:[NSNumber numberWithBool:NO]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            self.allUsers = objects;
            [self.tableView reloadData];
        }
    }];
    
    
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//    return self.users.count;
    return [self.allUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HelpStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
        cell.studentNameLabel.text = user[@"Name"];
        cell.studentImageView.image = [UIImage imageNamed:@"year_of_monkey-75.png"];
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.users removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}



@end