//
//  HNDAppUpdateManager.h
//  HNDAppUpdateManager
//
//  Created by Dustin Bachrach on 4/10/14.
//  Copyright (c) 2014 MediaHound. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HNDAppUpdateManager;


/**
 * An App Update Manager Delegate will be notified when
 * a new version of the app is available.
 */
@protocol HNDAppUpdateManagerDelegate <NSObject>

@required

/**
 * Invoked when a newer version of the app is available.
 * @param manager The App Update Manager, which found the new update available.
 * @param forced Whether this should be forced or optional update.
 * @param updateBlock Should be invoked by the delegate to start the app update process.
 *                    If the update is optional, the user should be given an option to 
 *                    update. If they choose to update, this block should be invoked.
 *                    For required updates, this block should always be invoked.
 */
- (void)appUpdateManager:(HNDAppUpdateManager*)manager 
 promptForUpdateForcibly:(BOOL)forced
             updateBlock:(void(^)())updateBlock;

@end


/**
 * The App Update Manager checks for a newer version of the app
 * based on a version file hosted your server.
 * If a newer version is found, the delegate is notified and an
 * alert can be presented to the user.
 */
@interface HNDAppUpdateManager : NSObject

/**
 * Initializes an App Update Manager configured with a given URL to check for version updates.
 * @param versionURL URL to locate a latest version information.
 */
- (instancetype)initWithVersionURL:(NSURL*)versionURL;

/**
 * Check for potential app updates.
 * If a newer version is available, the delegate will be notified.
 */
- (void)checkForUpdate;

/**
 * The delegate will be informed when a new version is available.
 */
@property (weak, nonatomic) id<HNDAppUpdateManagerDelegate> delegate;

@end
