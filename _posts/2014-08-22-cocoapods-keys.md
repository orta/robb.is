---
layout:   post
title:    CocoaPods Keys
color:    C04546
link:     https://github.com/orta/cocoapods-keys
category: ❤ing
---

[Orta] released [a clever new CocoaPods plug-in][cocoapods-keys] to manage keys,
application secrets and the like. Pretty much everything you dont' want to check
into your repository.

> You can save keys on a per-project basis by running the command:

```bash
$ pod keys set KEY VALUE
```

> After the next pod install or pod update keys will add a new Objective-C class
> to your Pods xcworkspace.

```objc
#import "ORAppDelegate.h"
#import <CocoaPods-Keys/MyApplicationKeys.h>
#import <ARAnalytics/ARAnalytics.h>

@implementation ORAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    MyApplicationKeys *keys = [[MyApplicationKeys alloc] init];
    [ARAnalytics setupWithAnalytics:@{
        ARGoogleAnalyticsID : keys.analyticsToken;
    }];
}

@end
```

Note that it depends on the upcoming CocoaPods 0.34.

[orta]: https://twitter.com/orta
[cocoapods-keys]: https://github.com/orta/cocoapods-keys
