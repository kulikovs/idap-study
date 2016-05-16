//
//  KSArrayModel.m
//  KSIdapStudy
//
//  Created by KulikovS on 08.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSArrayModel.h"
#import "KSStringModel.h"
#import "KSStateModel.h"

static const NSString * kKSArrayObjectsForCoder = @"arrayObjects";

@interface KSArrayModel ()
@property (nonatomic, strong) NSMutableArray *arrayObjects;

@end

@implementation KSArrayModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)arrayModelWithObject:(id)object {
    return [[[self class] alloc] initWithObject:object];
}

+ (instancetype)arrayModelWithObjects:(NSArray *)objects {
    return [[[self class] alloc] initModelWithArray:objects];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initModelWithObject:(id)object {
    self = [super init];
    if (self) {
        self.arrayObjects = [NSMutableArray arrayWithObject:object];
    }
    
    return self;
}

- (instancetype)initModelWithArray:(NSArray *)objects {
    self = [super init];
    if (self) {
        self.arrayObjects = [NSMutableArray arrayWithArray:objects];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.arrayObjects = [decoder decodeObjectForKey:[kKSArrayObjectsForCoder copy]];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
  return self.arrayObjects.count;
}

#pragma mark -
#pragma mark Public Methods

- (id)objectAtIndex:(NSUInteger)index {
  return [self.arrayObjects objectAtIndex:index];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (NSUInteger)indexOfObject:(id)object {
    return [self.arrayObjects indexOfObject:object];
}

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex {
    [self.arrayObjects exchangeObjectAtIndex:index withObjectAtIndex:toIndex];
}

- (void)addObject:(id)object {
    [self.arrayObjects addObject:object];
    
    KSStateModel *stateModel = [KSStateModel new];
    stateModel.state = kKSAddedState;
    stateModel.index = self.arrayObjects.count - 1;
    [self setState:kKSChangedState withObject:stateModel];
}

- (void)removeObject:(id)object {
    [self removeObjectAtIndex:[self indexOfObject:object]];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.arrayObjects removeObjectAtIndex:index];
    
    KSStateModel *stateModel = [KSStateModel new];
    stateModel.state = kKSRemoveState;
    stateModel.index = index;
    [self setState:kKSChangedState withObject:stateModel];
}

- (void)removeAllObject {
    [self.arrayObjects removeAllObjects];
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.arrayObjects forKey:[kKSArrayObjectsForCoder copy]];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(__unsafe_unretained id [])buffer
                                    count:(NSUInteger)len
{
    return [self.arrayObjects countByEnumeratingWithState:state objects:buffer count:len];
}

@end
