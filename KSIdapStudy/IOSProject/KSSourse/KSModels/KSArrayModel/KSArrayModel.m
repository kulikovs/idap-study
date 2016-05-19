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

static NSString * const kKSArrayObjectsForCoderKey = @"arrayObjects";
static NSString * const kKSSaveArrayModelKey       = @"saveArrayModel.plist";

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

- (instancetype)init {
    self = [super init];
    if (self) {
        self.arrayObjects = [NSMutableArray array];
    }
    
    return self;
}

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
    
    NSUInteger index = self.arrayObjects.count - 1;
    KSStateModel *model = [KSStateModel stateModelWithState:kKSStateModelAddedState index:index];
    [self setState:kKSArrayModelStateChanged withObject:model];
}

- (void)removeObject:(id)object {
    [self removeObjectAtIndex:[self indexOfObject:object]];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.arrayObjects removeObjectAtIndex:index];
    
    KSStateModel *model = [KSStateModel stateModelWithState:kKSStateModelRemoveState index:index];
    [self setState:kKSArrayModelStateChanged withObject:model];
}

- (void)removeAllObject {
    [self.arrayObjects removeAllObjects];
}

- (void)load {
    KSArrayModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:
                           [NSFileManager pathToFileInDocumentsWithName:kKSSaveArrayModelKey]];

    model = model ? model : [KSArrayModel arrayModelWithObjects:[KSStringModel randomStringsModels]];
    self.arrayObjects = model.arrayObjects;
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self
                                toFile:[NSFileManager pathToFileInDocumentsWithName:kKSSaveArrayModelKey]];
}

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.arrayObjects = [decoder decodeObjectForKey:kKSArrayObjectsForCoderKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.arrayObjects forKey:kKSArrayObjectsForCoderKey];
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
