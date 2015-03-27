//
//  SBAPIManager.m
//  LawOnDemand
//
//  Created by Joshua Cleetus on 07/11/14.
//  Copyright (c) 2014 JoshuaCleetus. All rights reserved.
//

#import "SBAPIManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation SBAPIManager

#pragma mark - Methods

- (void)setUsername:(NSString *)username andPassword:(NSString *)password
{
    [self.requestSerializer clearAuthorizationHeader];
    [self.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
}

#pragma mark - Initialization

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(!self)
        return nil;
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return self;
}

#pragma mark - Singleton Methods

+ (SBAPIManager *)sharedManager
{
    static dispatch_once_t pred;
    static SBAPIManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{ _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://dev.fuzzproductions.com"]]; }); // You should probably make this a constant somewhere
    return _sharedManager;
}

@end
