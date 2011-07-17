//
//  Composite.h
//  Filer
//
//  Created by ohashi tosikazu on 11/07/14.
//  Copyright (c) 2011 nagoya-bunri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Composite : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSManagedObject * parent;


@end
