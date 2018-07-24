//
//  ExampleDataSource.m
//  Illusionist Cells Demo
//
//  Created by Red Valdez on 1/1/18.
//  Copyright © 2018 Red Valdez. All rights reserved.
//

#import "ExampleDataSource.h"

@interface ExampleDataSource()
@property (nonatomic, strong) NSMutableArray *mainDataThread;
@property (nonatomic, strong) NSMutableDictionary <NSString*,NSMutableArray*> *archive;
@end

@implementation ExampleDataSource

- (instancetype)init {
    self = [super init];
    
    if (self) {
        // Populate datasource with example data.
        NSMutableArray *nestedData = [NSMutableArray arrayWithArray:@[@"Nested Cell: 1", @"Nested Cell: 2", @"Nested Cell: 3"]];
        
        self.archive = [[NSMutableDictionary alloc] init];
        [self.archive setObject:nestedData forKey:@"PARENT CELL: 1"];
        [self.archive setObject:nestedData forKey:@"PARENT CELL: 2"];
        [self.archive setObject:nestedData forKey:@"PARENT CELL: 3"];
        
        self.mainDataThread = [NSMutableArray arrayWithArray:[self categories]];
    }
    
    return self;
}

- (NSArray *)dataToDisplay {
    return [self.mainDataThread copy];
}

- (void)fetchNestedDataForCellAtRow:(NSInteger)row withCategory:(NSString *)category {
    NSArray *data = [self dataForCategory:category];
    [self.mainDataThread insertObjects:data atIndexes:[self indexSetForData:data atIndex:row]];
    [self.delegate displayNestedDataForCellAtRow:row withDataLength:data.count andFlag:'+'];
}

- (void)removeNestedDataForCellAtRow:(NSInteger)row withCategory:(NSString *)category {
    NSArray *data = [self dataForCategory:category];
    [self.mainDataThread removeObjectsAtIndexes:[self indexSetForData:data atIndex:row]];
    [self.delegate displayNestedDataForCellAtRow:row withDataLength:data.count andFlag:'-'];
}

- (NSIndexSet *)indexSetForData:(NSArray *)data atIndex:(NSInteger)row {
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(row + 1, data.count)];
    return set;
}

- (NSArray *)categories {
    return [NSArray arrayWithArray:[self.archive.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
}

- (NSArray *)dataForCategory:(NSString *)category {
    return [self.archive objectForKey:category];
}

@end
