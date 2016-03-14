//
//  AppDelegate.m
//  RocketTownIOS
//
//  Created by Mike Hagedorn on 3/12/16.
//  Copyright © 2016 Mike Hagedorn. All rights reserved.
//

#import "AppDelegate.h"

#import "ASDRocket.h"

@interface AppDelegate ()


@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSDictionary* defaults = @{kCBLPrefKeyUserID:@"Admin"};
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    [self setupCouchbase];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupCouchbase {
    [[NSUserDefaults standardUserDefaults] setObject:@"Admin" forKey:kCBLPrefKeyUserID];
    CBLManager *manager = [CBLManager sharedInstance];
    NSError *error;
    self.database = [manager databaseNamed:kDBName error: &error];
    
    if (error) {
        NSLog(@"error getting database %@",error);
        exit(-1);
    }
    
    [[self.database modelFactory] registerClass: [ASDRocket class] forDocumentType: [ASDRocket docType]];
    
    _cblSync = [[CBLSyncManager alloc] initSyncForDatabase:_database withURL:[NSURL URLWithString:kSyncUrl]];
    
    // Configure sync and trigger it if the user is already logged in.
    [self loginAndSync:^{
//        UIAlertController * alert=   [UIAlertController
//                                      alertControllerWithTitle:@"Sync Started"
//                                      message:@"Couchbase Sync Intiated"
//                                      preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction* ok = [UIAlertAction
//                             actionWithTitle:@"OK"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 [alert dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
//        
//        [alert addAction:ok];
        [_cblSync start];
    
    }];
}

- (void)loginAndSync: (void (^)())complete {
    if (_cblSync.userID) {
        complete();
    } else {
        [_cblSync beforeFirstSync:^(NSString *userID, NSDictionary *userData, NSError **outError) {
            complete();
        }];
        [_cblSync start];
    }
}

@end
