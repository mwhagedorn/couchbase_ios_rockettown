//
//  Rocket.h
//  RocketTownOSX
//
//  Created by Mike Hagedorn on 3/8/16.
//  Copyright © 2016 Mike Hagedorn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CouchBaseLite/CouchBaseLite.h>

@interface ASDRocket : CBLModel

+ (NSString*) docType;


@property (strong) NSString *name;
@property (assign) double diameter;
@property (assign) double weight;
@property (assign) double coefficientFriction;


/** Returns a query for all the rockets in a database. */
+ (CBLQuery*) queryRocketsInDatabase: (CBLDatabase*)db;

/** Returns a query for all the rockets with name in a database */
+ (CBLQuery*) findInDatabase:(CBLDatabase*)db  byName:(NSString *)name;



@end
