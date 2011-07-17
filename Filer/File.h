//
//  File.h
//  Filer
//
//  Created by ohashi tosikazu on 11/07/14.
//  Copyright (c) 2011 nagoya-bunri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Composite.h"


@interface File : Composite {
@private
}
@property (nonatomic, retain) NSString * text;

@end
