#import "PictifyPlugin.h"
#if __has_include(<pictify/pictify-Swift.h>)
#import <pictify/pictify-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pictify-Swift.h"
#endif

@implementation PictifyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPictifyPlugin registerWithRegistrar:registrar];
}
@end
