//
//  ViewController.h
//  RocketTownIOS
//
//  Created by Mike Hagedorn on 3/12/16.
//  Copyright © 2016 Mike Hagedorn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CouchBaseLite/CouchBaseLite.h>

@interface ViewController : UITableViewController <CBLUITableDelegate>
    @property (strong, nonatomic) CBLDatabase *database;
    @property (nonatomic) IBOutlet CBLUITableSource* dataSource;

@end

