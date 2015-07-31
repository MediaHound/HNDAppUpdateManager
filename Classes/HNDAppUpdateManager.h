//
//  HNDAppUpdateManager.h
//  HNDAppUpdateManager
//
//  Created by Dustin Bachrach on 4/10/14.
//  Copyright (c) 2014 MediaHound. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HNDAppUpdateManager;


@protocol HNDAppUpdateManagerDelegate <NSObject>

@required

- (void)appUpdateManager:(HNDAppUpdateManager*)manager 
 promptForUpdateForcibly:(BOOL)forced
             updateBlock:(void(^)())updateBlock;

@end


@interface HNDAppUpdateManager : NSObject

- (instancetype)initWithVersionURL:(NSURL*)versionURL;

- (void)checkForUpdate;

@property (strong, nonatomic, readonly) NSURL* versionURL;

@property (weak, nonatomic) id<HNDAppUpdateManagerDelegate> delegate;

@end
