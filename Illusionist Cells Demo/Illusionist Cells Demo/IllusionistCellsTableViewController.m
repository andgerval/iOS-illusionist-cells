//
//  IllusionistCellsTableViewController.m
//  Illusionist Cells Demo
//
//  Created by Red Valdez on 1/1/18.
//  Copyright © 2018 Red Valdez. All rights reserved.
//

#import "IllusionistCellsTableViewController.h"
#import "ExampleDataSource.h"
#import "ParentTableViewCell.h"
#import "ChildTableViewCell.h"

@interface IllusionistCellsTableViewController () <ExampleDataSourceDelegate>
@property (nonatomic, strong) ExampleDataSource *exampleDataSource;
@property (nonatomic) NSInteger cellInsertionType;
typedef NS_ENUM(NSInteger, CellInsertionType) {
    CellInsertionTypeParent,
    CellInsertionTypeChild
};
@end

@implementation IllusionistCellsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellInsertionType = CellInsertionTypeParent;
    
    [self configureNavigationBarAppearance];
    [self configureTableViewAppearance];
    
    [self registerCellClasses];
    
    // Populate the table view with example data from our ExampleDataSource object.
    self.exampleDataSource = [[ExampleDataSource alloc] init];
    self.exampleDataSource.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI/DATA SOURCE SYNCING
- (void)displayNestedDataForCellAtRow:(NSInteger)row withDataLength:(NSInteger)length andFlag:(char)flag {
    NSArray *indexPathsForUIUpdate = [self prepareIndexPathsForNestedCellsAtRow:row withDataLength:length];
    [self syncTableUIAtIndexPaths:indexPathsForUIUpdate withFlag:flag];
}

- (NSArray<NSIndexPath *> *)prepareIndexPathsForNestedCellsAtRow:(NSInteger)row withDataLength:(NSInteger)length {
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    for (int i = 1; i <= length; i++) {
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:row + i inSection:0];
        [indexPaths addObject:newPath];
    }
    return [indexPaths copy];
}

- (void)syncTableUIAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withFlag:(char)flag {
    [self.tableView beginUpdates];
    if (flag == '+') {
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
    } else if (flag == '-'){
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        NSLog(@"Flag not recognized. Use '+' to insert rows or '-' to delete rows.");
    }
    [self.tableView endUpdates];
}

#pragma mark - Appearance

- (void)configureTableViewAppearance {
    // Configure your table views' appearance.
    self.tableView.tableFooterView = [UIView new]; // OPTIONAL. Stop the displaying of empty table cells.
    self.tableView.allowsMultipleSelection = YES; // REQUIRED.
    
    // In this example I add the seperator line to the children cells manually.
    // Parent cells will not have a line seperator, in this example they are seperated by color.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)configureNavigationBarAppearance {
    self.navigationItem.title = @"Demo Project";
}

#pragma mark - Helper Methods

// Register the classes for your TableViewCells.
- (void)registerCellClasses {
    [self.tableView registerClass:[ParentTableViewCell class] forCellReuseIdentifier:@"parentCell"];
    [self.tableView registerClass:[ChildTableViewCell class] forCellReuseIdentifier:@"childCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (BOOL)isCellParentType:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell class] == [ParentTableViewCell class]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Table View Data Source

// This method of displaying nested table view cells only supports using one section.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.exampleDataSource dataToDisplay].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellInsertionType == CellInsertionTypeChild) {
        ChildTableViewCell *childCell = [tableView dequeueReusableCellWithIdentifier:@"childCell" forIndexPath:indexPath];
        childCell.textLabel.text = [self.exampleDataSource dataToDisplay][indexPath.row];
        return childCell;
    } else if (self.cellInsertionType == CellInsertionTypeParent) {
        ParentTableViewCell *parentCell = [tableView dequeueReusableCellWithIdentifier:@"parentCell" forIndexPath:indexPath];
        parentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        parentCell.textLabel.text = [self.exampleDataSource dataToDisplay][indexPath.row];
        return parentCell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = [self.exampleDataSource dataToDisplay][indexPath.row];
        return cell;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([self isCellParentType:indexPath]) {
        id returnValue = indexPath;
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.selected) {
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            returnValue = nil;
        }
        return returnValue;
    }  else {
        return indexPath;
    }
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isCellParentType:indexPath]) {
        self.cellInsertionType = CellInsertionTypeChild;
        [self.exampleDataSource fetchNestedDataForCellAtRow:indexPath.row withCategory:[self.tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    } else {
        
        // Insert logic for non-parent cell selection.
        [self exampleMethodForNonParentCellSelection:indexPath]; // Example Method.
        
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isCellParentType:indexPath]) {
        [self.exampleDataSource removeNestedDataForCellAtRow:indexPath.row withCategory:[self.tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    }
}

// Example method. This is called when a non-parent cell is selected.
- (void)exampleMethodForNonParentCellSelection:(NSIndexPath *)indexPath {
    UIViewController *detailVC = [[UIViewController alloc] init];
    detailVC.view.backgroundColor = [UIColor whiteColor];
    detailVC.navigationItem.title = [self.exampleDataSource dataToDisplay][indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    // NOTE: Always call this method after your logic has been performed.
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
