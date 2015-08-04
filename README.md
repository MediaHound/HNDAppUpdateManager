# HNDAppUpdateManager

[![CI Status](http://img.shields.io/travis/Dustin Bachrach/HNDAppUpdateManager.svg?style=flat)](https://travis-ci.org/Dustin Bachrach/HNDAppUpdateManager)
[![Version](https://img.shields.io/cocoapods/v/HNDAppUpdateManager.svg?style=flat)](http://cocoapods.org/pods/HNDAppUpdateManager)
[![License](https://img.shields.io/cocoapods/l/HNDAppUpdateManager.svg?style=flat)](http://cocoapods.org/pods/HNDAppUpdateManager)
[![Platform](https://img.shields.io/cocoapods/p/HNDAppUpdateManager.svg?style=flat)](http://cocoapods.org/pods/HNDAppUpdateManager)

## What is HNDAppUpdateManager

**TBD**

## version.json

The App Update Manager requests a version JSON file, which you host on your server. The JSON file contains 2 fields:

Field         | Description                                   | Example
------------- | --------------------------------------------- | ------------
latestVersion | A full version string including build number. | `"1.2.0.50"`
updateUrl     | A URL which will initiate update. Can be an enterprise `itms-services` URL or an app store link | `"itms-services://?action=download-manifest&url=https://myapp.com/app.plist"`

Here is an example JSON file:

```json
{ 
    "latestVersion": "1.2.0.50",
    "updateUrl": "itms-services://?action=download-manifest&url=https://myapp.com/app.plist"
}
```

## Installation

HNDAppUpdateManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HNDAppUpdateManager"
```

## Author

Dustin Bachrach, dustin@mediahound.com

## License

HNDAppUpdateManager is available under the Apache License 2.0. See the LICENSE file for more info.
