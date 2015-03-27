//
//  DetailViewController.h
//  FuzzTestApp
//
//  Created by Joshua on 3/27/15.
//  Copyright (c) 2015 Joshuasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSString *typeString;
@property (nonatomic, strong) NSMutableDictionary *dataDict;

@property (nonatomic, strong) UIImageView *imageView;

@end
