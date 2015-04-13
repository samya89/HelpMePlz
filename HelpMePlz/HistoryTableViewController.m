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

@property NSMutableArray *objects;
@property (strong, nonatomic) NSArray *archives;
@end

@implementation HistoryTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveArchives];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

//- (void)retrieveArchives {
//    PFQuery *query = [PFQuery queryWithClassName:@"Archives"];
//    PFObject *archive = [PFObject objectWithClassName:@"Archives"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        } else {
//            self.archives = objects;
//            [self.tableView reloadData];
//            NSLog(@"%@", objects);
//        }
//    }];
//}

- (void)retrieveArchives {
    PFQuery *query = [PFQuery queryWithClassName:@"Requests"];
    [query whereKey:@"isHandled" equalTo:[NSNumber numberWithBool:YES]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            self.archives = [objects mutableCopy];
            [self.tableView reloadData];
            NSLog(@"%@", objects);
        }
    }];
}

- (void)refreshTable {
    [self.refreshControl endRefreshing];
    [self retrieveArchives];
    [self.tableView reloadData];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(PFObject *)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *archive = [PFObject objectWithClassName:@"Requests"];
        archive = self.archives[indexPath.row];
        [[segue destinationViewController] setArchiveItem:archive];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.archives count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    PFObject *archive = self.archives[indexPath.row];
    cell.studentNameLabel.text = archive[@"name"];
    NSString *parseDateAndTime = [NSString stringWithFormat:@"%@", archive.createdAt];
    NSLog(@"%@", parseDateAndTime);
    
    NSString *dateFormat = @"yyyy-MM-dd hh:mm:ss +mmss";
    NSTimeZone *inputTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    [inputDateFormatter setTimeZone:inputTimeZone];
    [inputDateFormatter setDateFormat:dateFormat];
    NSString *inputString = [NSString stringWithFormat:@"%@", archive.createdAt];
    NSDate *date = [inputDateFormatter dateFromString:inputString];
    NSTimeZone *outputTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"PST"];
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
    [outputDateFormatter setTimeZone:outputTimeZone];
    [outputDateFormatter setDateFormat:dateFormat];
    NSString *outputString = [outputDateFormatter stringFromDate:date];
    NSLog(@"%@", date);
    
    NSArray *postDateSplit = [outputString componentsSeparatedByString:@" "];
    cell.dateLabel.text = [postDateSplit objectAtIndex:0];
    cell.timeLabel.text = [postDateSplit objectAtIndex:1];
    cell.archiveUserImageview.image = [UIImage imageNamed:archive[@"imageName"]];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
