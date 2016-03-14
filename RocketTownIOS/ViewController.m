
//
//  ViewController.m
//  RocketTownIOS
//
//  Created by Mike Hagedorn on 3/12/16.
//  Copyright © 2016 Mike Hagedorn. All rights reserved.
//

#import "ViewController.h"
#import "ASDRocket.h"
#import "AppDelegate.h"
#import "RocketDetailViewController.h"


@interface ViewController ()
{
    
    CBLLiveQuery *rocketsQuery;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.toolbarHidden = NO;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    self.database = app.database;
    
    NSAssert(_dataSource, @"_dataSource not connected");
    _dataSource.query = [ASDRocket queryRocketsInDatabase:_database].asLiveQuery;
    _dataSource.labelProperty = @"name";

}

- (NSInteger) itemCount{
    return _dataSource.query.rows.count;
}

// Handles a command to create a new list, by displaying an alert to prompt for the title.
- (IBAction) insertNewObject: (id)sender {

    
    [self createRocketWithName:[NSString stringWithFormat:@"alpha%i",[self itemCount]]];
}


// Delegate method called when the live-query results change.
- (void)couchTableSource:(CBLUITableSource*)source
         updateFromQuery:(CBLLiveQuery*)query
            previousRows:(NSArray *)previousRows
{
   
    
    [[self tableView] reloadData];
    
    
}

// Delegate method to set up a new table cell
- (void)couchTableSource:(CBLUITableSource*)source
             willUseCell:(UITableViewCell*)cell
                  forRow:(CBLQueryRow*)row
{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        CBLQueryRow *row = [self.dataSource rowAtIndex:indexPath.row];
        ASDRocket* rocket = [ASDRocket modelForDocument: row.document];
           NSError* error;
           if (![rocket deleteDocument: &error]){
               NSLog(@"Unable to delete Rocket");
               return;
           }
        
           [self.tableView reloadData];
    }

}

//todo call this from the table view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    
    
    [self performSegueWithIdentifier:@"showRocketDetails" sender:self];
    
}


- (ASDRocket*) createRocketWithName: (NSString*)name {
    ASDRocket* rocket = [ASDRocket modelForNewDocumentInDatabase:self.database];
    rocket.name=name;
    rocket.weight = 23.0;
    rocket.diameter = 25.0;
    rocket.coefficientFriction = 0.75;
    NSError* error;
    
    if (![rocket save: &error]) {
        return nil;
    }
    NSLog(@"Rocket Created");
    return rocket;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addRocket:(id)sender {
    
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([[segue identifier] isEqualToString:@"showRocketDetails"]) {
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         CBLQueryRow *row = [self.dataSource rowAtIndex:indexPath.row];
         ASDRocket* rocket = [ASDRocket modelForDocument: row.document];
         [[segue destinationViewController] setRocket:rocket];
     }
 }


@end
