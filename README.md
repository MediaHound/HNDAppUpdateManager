# HNDAppUpdateManager

[![CI Status](http://img.shields.io/travis/Dustin Bachrach/HNDAppUpdateManager.svg?style=flat)](https://travis-ci.org/Dustin Bachrach/HNDAppUpdateManager)
[![Version](https://img.shields.io/cocoapods/v/HNDAppUpdateManager.svg?style=flat)](http://cocoapods.org/pods/HNDAppUpdateManager)
[![License](https://img.shields.io/cocoapods/l/HNDAppUpdateManager.svg?style=flat)](http://cocoapods.org/pods/HNDAppUpdateManager)
[![Platform](https://img.shields.io/cocoapods/p/HNDAppUpdateManager.svg?style=flat)](http://cocoapods.org/pods/HNDAppUpdateManager)

## What is HNDAppUpdateManager

HNDAppUpdateManager lets you easily add app update checking to your iOS apps. It supports App Store or Enterprise distribution. 

## Installation

HNDAppUpdateManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HNDAppUpdateManager"
```

## version.json

The App Update Manager requests a version JSON file, which you host on your server. The JSON file contains 3 fields:

Field         | Description                                   | Example
------------- | --------------------------------------------- | ------------
latestVersion | A full version string including build number. | `"1.2.0.50"`
updateUrl     | A URL which will initiate update. Can be an enterprise `itms-services` URL or an app store link | `"itms-services://?action=download-manifest&url=https://myapp.com/app.plist"`
requireUpdateBefore | (Optional) A full version string that indicates when an update is required. Any version before this version will be required. | `"1.1.5.0" `

Here is an example JSON file:

```json
{ 
    "latestVersion": "1.2.0.50",
    "updateUrl": "itms-services://?action=download-manifest&url=https://myapp.com/app.plist",
    "requireUpdateBefore": "1.1.5.0"
}
```

### Fastlane integration

If you use [Fastlane](https://github.com/KrauseFx/fastlane) for s3 Enterprise distrubution, you already get a `version.json` [generated for you automatically](https://github.com/KrauseFx/fastlane/blob/master/docs/Actions.md#aws-s3-distribution).

## Checking for updates

You can then easily check for updates from inside your AppDelegate or wherever you choose:

```objc
NSURL* versionURL = [NSURL URLWithString:@"http://myapp.com/version.json"];
HNDAppUpdateManager* updateManager = [[HNDAppUpdateManager alloc] initWithVersionURL:versionURL];
updateManager.delegate = self;
[updateManager checkForUpdate];
```

```objc
- (void)appUpdateManager:(HNDAppUpdateManager*)manager
 promptForUpdateForcibly:(BOOL)forced 
             updateBlock:(void(^)())updateBlock {
    if (forced) {
        // Show an alert and then call updateBlock()
    }
    else {
        // Ask the user if they want to update.
        // If they do, call updateBlock()
    }
}
```

## Author

Dustin Bachrach, dustin@mediahound.com

## License

HNDAppUpdateManager is available under the Apache License 2.0. See the LICENSE file for more info.
