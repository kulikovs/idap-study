//
//  KSObserverObject.m
//  KSIdapStudy
//
//  Created by KulikovS on 13.04.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSObserverObject.h"

@implementation KSObserverObject

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.object = nil;
    
    [super dealloc];
}

- (instancetype)init {
    return [self initWithObject:nil handler:nil];
}

- (instancetype)initWithObject:(id)object handler:(KSHandlerObject)handler {  
    self = [super init];
    if (self) {
        self.object = object;
        self.handler = [[handler copy] autorelease];
    }
    
    return self;
}



@end
