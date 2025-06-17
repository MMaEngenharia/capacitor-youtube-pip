#import <Capacitor/Capacitor.h>

CAP_PLUGIN(YouTubePiPPlugin, "YouTubePiP",
    CAP_PLUGIN_METHOD(play, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(close, CAPPluginReturnPromise);
)