//
//  TextViewController.h
//  FuzzTestApp
//
//  Created by Joshua on 3/26/15.
//  Copyright (c) 2015 Joshuasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *resultsArray;
@property (nonatomic, strong) NSMutableDictionary *resultsDict;
@property (nonatomic, assign) NSUInteger selectedCellIndex;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSMutableDictionary *resultsDict2;

@end
