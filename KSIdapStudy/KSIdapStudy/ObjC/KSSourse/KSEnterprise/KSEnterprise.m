//
//  KSEnterprise.m
//  KSIdapStudy
//
//  Created by KulikovS on 09.03.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSEnterprise.h"
#import "KSBoss.h"
#import "KSAccountant.h"
#import "KSCarsWasher.h"
#import "KSObserver.h"
#import "KSQueue.h"

@interface KSEnterprise ()
@property (nonatomic, retain) NSMutableArray    *staff;
@property (nonatomic, retain) KSQueue           *queueCars;

- (void)hireStaff;
- (void)dismissStaff;
- (void)dismissEmployee:(KSEmployee *)emlpoyee;
- (id)vacantEmployeeWithClass:(Class)class;

@end

@implementation KSEnterprise

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self dismissStaff];
    self.staff = nil;
    self.queueCars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.queueCars = [KSQueue object];
        [self hireStaff];
    }
    
    return self;
}

#pragma mark -
#pragma mark Private Methods

- (void)hireStaff {
    
    KSBoss *boss = [KSBoss object];
    KSAccountant *accountant = [KSAccountant object];
    
    [accountant addObserver:boss];
    
    self.staff = [NSMutableArray arrayWithObjects:accountant, boss, nil];
    
    NSArray *carWashers = [KSCarsWasher employeesWithCount:2 observers:@[accountant, self]];

   [self.staff addObjectsFromArray:carWashers];

}

- (void)dismissStaff {
    NSArray *staff = [[self.staff copy] autorelease];
    
    for (KSEmployee *employee in staff) {
        [self dismissEmployee:employee];
    }
}

- (void)dismissEmployee:(KSEmployee *)object {
    for (NSUInteger index = 0; index < self.staff.count; index++) {
        KSEmployee *employee = self.staff[index];
        if ([employee isObservedByObject:object]) {
            [employee removeObserver:object];
        }
    }
    
    [self.staff removeObject:object];
}

- (id)vacantEmployeeWithClass:(Class)class {
    for (KSEmployee *employee in self.staff) {
        if ([employee isMemberOfClass:class] && employee.state == kKSWorkerStateFree) {
            
            return employee;
        }
    }
    
    return nil;
}

#pragma mark -
#pragma mark Public Methods

- (void)washCar:(KSCar *)car {
    @synchronized(self) {
        KSCarsWasher *carsWasher =  [self vacantEmployeeWithClass:[KSCarsWasher class]];
        if (carsWasher) {
            [carsWasher performWorkWithObject:car];
        } else {
            [self.queueCars addObjectToQueue:car];
        }
    }
}

#pragma mark -
#pragma mark Worker Protocol

- (void)workerFinishedWork:(KSCarsWasher *)carsWasher {
    @synchronized(self) {
        KSCar *car = [self.queueCars sendTheWorkFirstObjectFromQueue];
        if (car) {
            [self washCar:car];
        }
    }
}

@end