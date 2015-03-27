//
//  SBAPIManager.h
//  LawOnDemand
//
//  Created by Joshua Cleetus on 07/11/14.
//  Copyright (c) 2014 JoshuaCleetus. All rights reserved.
//

#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"

@interface SBAPIManager : AFHTTPRequestOperationManager

- (void)setUsername:(NSString *)username andPassword:(NSString *)password;

+ (SBAPIManager *)sharedManager;

@end
