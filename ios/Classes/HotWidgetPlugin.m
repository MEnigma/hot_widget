#import "HotWidgetPlugin.h"
#import <hot_widget/hot_widget-Swift.h>

@implementation HotWidgetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHotWidgetPlugin registerWithRegistrar:registrar];
}
@end
