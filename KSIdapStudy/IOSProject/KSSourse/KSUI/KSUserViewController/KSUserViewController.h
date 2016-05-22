//
//  KSUserTableViewController.h
//  KSIdapStudy
//
//  Created by KulikovS on 03.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSArrayModel;
@class KSArrayModelManager;

@interface KSUserViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) KSArrayModelManager *arrayModel;

- (IBAction)onEditTable:(id)sender;

@end
