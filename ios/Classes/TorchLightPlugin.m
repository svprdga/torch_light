#import "TorchLightPlugin.h"
#if __has_include(<torch_light/torch_light-Swift.h>)
#import <torch_light/torch_light-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "torch_light-Swift.h"
#endif

@implementation TorchLightPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTorchLightPlugin registerWithRegistrar:registrar];
}
@end
