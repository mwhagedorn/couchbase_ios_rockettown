//
//  AppDelegate.h
//  RocketTownIOS
//
//  Created by Mike Hagedorn on 3/12/16.
//  Copyright © 2016 Mike Hagedorn. All rights reserved.
//


#import <UIKit/UIKit.h>

#import <CouchBaseLite/CouchBaseLite.h>
#import "CBLSyncManager.h"

#define kSyncUrl  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"ASDRocketCouchbaseURL"]

#define kDBName @"rocket_data"
#define kCBLPrefKeyUserID @"kCBLPrefKeyUserID"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CBLDatabase *database;
@property (strong, nonatomic) CBLSyncManager *cblSync;



@end

