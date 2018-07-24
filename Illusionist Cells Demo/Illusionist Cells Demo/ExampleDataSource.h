//
//  ExampleDataSource.h
//  Illusionist Cells Demo
//
//  Created by Red Valdez on 1/1/18.
//  Copyright © 2018 Red Valdez. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ExampleDataSourceDelegate
- (void)displayNestedDataForCellAtRow:(NSInteger)row withDataLength:(NSInteger)length andFlag:(char)flag;
@end

@interface ExampleDataSource : NSObject
@property (nonatomic, weak) id <ExampleDataSourceDelegate> delegate;
- (NSArray *)dataToDisplay;
- (void)fetchNestedDataForCellAtRow:(NSInteger)row withCategory:(NSString *)category;
- (void)removeNestedDataForCellAtRow:(NSInteger)row withCategory:(NSString *)category;
@end
