//
//  Folder.h
//  Filer
//
//  Created by ohashi tosikazu on 11/07/14.
//  Copyright (c) 2011 nagoya-bunri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Composite.h"

@class Composite;

@interface Folder : Composite {
@private
}
@property (nonatomic, retain) NSSet* children;

- (void)addChildrenObject:(Composite *)value;

- (void)removeChildrenObject:(Composite *)value;

- (void)addChildren:(NSSet *)value;

- (void)removeChildren:(NSSet *)value;
@end
