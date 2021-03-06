//
//  HNDAppUpdateManager.m
//  HNDAppUpdateManager
//
//  Created by Dustin Bachrach on 4/10/14.
//  Copyright (c) 2014 MediaHound. All rights reserved.
//

#import "HNDAppUpdateManager.h"

#import <AFNetworking/AFNetworking.h>
#import <Avenue/Avenue.h>

static NSString* const HNDLatestVersionKey = @"latestVersion";
static NSString* const HNDRequireUpdateBeforeKey = @"requireUpdateBefore";
static NSString* const HNDUpdateUrlKey = @"updateUrl";


@interface HNDAppUpdateManager ()

@property (strong, nonatomic, readonly) NSURL* versionURL;

@end


@implementation HNDAppUpdateManager

- (instancetype)initWithVersionURL:(NSURL*)versionURL
{
    if (self = [super init]) {
        _versionURL = versionURL;
    }
    return self;
}

- (void)checkForUpdate
{
    NSString* currentVersion = [self appVersion];
    
    AVEHTTPRequestOperationBuilder* builder = [[AVEHTTPRequestOperationBuilder alloc] init];
    builder.responseSerializer = [AFJSONResponseSerializer serializer];
    builder.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [[AVENetworkManager sharedManager] GET:self.versionURL.absoluteString
                                parameters:nil
                                  priority:[AVENetworkPriority priorityWithLevel:AVENetworkPriorityLevelHigh]
                              networkToken:nil
                                   builder:builder].then(^(NSDictionary* responseObject) {
        NSString* serverVersion = responseObject[HNDLatestVersionKey];
        if (serverVersion) {
            if ([self compareVersion:serverVersion toVersion:currentVersion] == NSOrderedDescending) {
                
                NSString* requireUpdateBefore = responseObject[HNDRequireUpdateBeforeKey];
                const BOOL requireUpdate = (requireUpdateBefore && [self compareVersion:requireUpdateBefore toVersion:currentVersion] == NSOrderedDescending);
                
                NSString* updateUrlString = responseObject[HNDUpdateUrlKey];
                if (updateUrlString) {
                    [self newerVersionFoundWithRequiredUpdate:requireUpdate
                                                    updateUrl:[NSURL URLWithString:updateUrlString]];
                }
            }
        }
    }).catch(^(NSError* error) {
        // Silently allow failures
    });
}

- (void)newerVersionFoundWithRequiredUpdate:(BOOL)requireUpdate 
                                  updateUrl:(NSURL*)updateUrl
{
    [self.delegate appUpdateManager:self promptForUpdateForcibly:requireUpdate updateBlock:^{
        [self updateWithUrl:updateUrl];
    }];
}

- (void)updateWithUrl:(NSURL*)updateUrl
{
    [[UIApplication sharedApplication] openURL:updateUrl];
}

- (NSString*)appVersion
{
    NSDictionary* info = [NSBundle mainBundle].infoDictionary;
    NSString* version = info[@"CFBundleShortVersionString"];
    NSString* build = info[@"CFBundleVersion"];
    if ([build isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@", version];
    }
    else {
        return [NSString stringWithFormat:@"%@.%@", version, build];
    }
}

- (NSComparisonResult)compareVersion:(NSString*)firstVersion
                           toVersion:(NSString*)secondVersion
{
    NSMutableArray* fvArray = [self splitVersionString:firstVersion].mutableCopy;
    NSMutableArray* svArray = [self splitVersionString:secondVersion].mutableCopy;
    
    while (fvArray.count < svArray.count) {
        [fvArray addObject:@0];
    }
    while ([svArray count] < [fvArray count]) {
        [svArray addObject:@0];
    }
    
    for (NSUInteger i = 0; i < fvArray.count; i++) {
        NSInteger a = [fvArray[i] integerValue];
        NSInteger b = [svArray[i] integerValue];
        
        if (a > b) {
            return NSOrderedDescending;
        }
        else if (b > a) {
            return NSOrderedAscending;
        }
    }
    return NSOrderedSame;
}

- (NSArray*)splitVersionString:(NSString*)version
{
    return [version componentsSeparatedByString:@"."];
}

@end
