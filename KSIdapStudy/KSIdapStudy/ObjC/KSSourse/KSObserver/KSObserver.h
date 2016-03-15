//
//  KSObserver.h
//  KSIdapStudy
//
//  Created by KulikovS on 15.03.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSObserver : NSObject
@property (nonatomic, readonly) NSUInteger  state;
@property (nonatomic, readonly) NSArray     *observers;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

@end
