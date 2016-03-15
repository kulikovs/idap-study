//
//  KSObserver.m
//  KSIdapStudy
//
//  Created by KulikovS on 15.03.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSObserver.h"

@interface KSObserver ()
@property (nonatomic, assign) NSUInteger        stateObject;
@property (nonatomic, retain) NSMutableArray    *mutableObservers;

@end

@implementation KSObserver

@dynamic observers;
@dynamic state;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableObservers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObservers = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    return [[self.mutableObservers copy] autorelease];
}

- (NSUInteger)state {
    return self.stateObject;
}

#pragma mark -
#pragma mark Public Methods

- (void)addObserver:(id)observer {
    [self.mutableObservers addObject:observer];
}

- (void)removeObserver:(id)observer {
    [self.mutableObservers removeObject:observer];
}


@end
