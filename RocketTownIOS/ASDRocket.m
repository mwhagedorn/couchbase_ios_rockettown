//
//  Rocket.m
//  RocketTownOSX
//
//  Created by Mike Hagedorn on 3/8/16.
//  Copyright © 2016 Mike Hagedorn. All rights reserved.
//

#import "ASDRocket.h"

#define kRocketDocType @"rocket"


@implementation ASDRocket

@dynamic name, diameter,weight,coefficientFriction;

// Subclasses must override this to return the value of their documents' "type" property.
+ (NSString*) docType {
    return kRocketDocType;
}


- (void)awakeFromInitializer {
    self.type = [[self class] docType];
}


- (NSString*) description {
    return [NSString stringWithFormat: @"%@[%@ '%@']",
            self.class, self.document.abbreviatedID, self.name];
}

// Returns a query for all the lists in a database.
+ (CBLQuery*)   queryRocketsInDatabase: (CBLDatabase*)db {
    CBLView* view = [db viewNamed: @"rockets"];
    if (!view.mapBlock) {
        // Register the map function, the first time we access the view:
        [view setMapBlock: MAPBLOCK({
            if ([doc[@"type"] isEqualToString:kRocketDocType])
                emit(doc[@"name"], nil);
        }) reduceBlock: nil version: @"1"]; // bump version any time you change the MAPBLOCK body!
    }
    return [view createQuery];
}

+(CBLQuery*) findInDatabase:(CBLDatabase*)db byName:(NSString *)name{
    CBLQuery *query = [self queryRocketsInDatabase:db];
    NSString *searchVal = [name lowercaseString];
    query.startKey = searchVal;
    query.endKey = [searchVal stringByAppendingString:@"\uFFFE"];
    return query;
}



@end
