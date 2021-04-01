#import "FlutterRiskifiedPlugin.h"

@implementation FlutterRiskifiedPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_riskified"
            binaryMessenger:[registrar messenger]];
  FlutterRiskifiedPlugin* instance = [[FlutterRiskifiedPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"startBeacon" isEqualToString:call.method]) {
      NSString *shopName = call.arguments[@"shopName"];
      NSString *token = call.arguments[@"token"];
      
      bool debugInfo = [call.arguments[@"debugInfo"] boolValue];
      
      [RiskifiedBeacon startBeacon:shopName sessionToken:token debugInfo:debugInfo];
      result(nil);
  } else if ([@"updateSessionToken" isEqualToString:call.method]) {
      NSString *token = call.arguments;
      
      [RiskifiedBeacon updateSessionToken:token];
      result(nil);
  } else if ([@"logRequest" isEqualToString:call.method]) {
      NSString *requestUrl = call.arguments;
      NSString *encodedUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];

      NSURL *url = [NSURL URLWithString:encodedUrl];
      
      [RiskifiedBeacon logRequest:url];
      result(nil);
  } else if ([@"logSensitiveDeviceInfo" isEqualToString:call.method]) {
      [RiskifiedBeacon logSensitiveDeviceInfo];
      result(nil);
  } else if ([@"riskifiedDeviceId" isEqualToString:call.method]) {
      NSString *riskifiedDeviceId = [RiskifiedBeacon rCookie];
      result(riskifiedDeviceId);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
