import Flutter
import UIKit

public class SwiftFlutterRiskifiedPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_riskified", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterRiskifiedPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "startBeacon") {
            guard let args = call.arguments else {
                return
            }
            if let myArgs = args as? [String: Any],
                let shopName: String = myArgs["shopName"] as? String,
                let token: String = myArgs["token"] as? String,
                let debugInfo = myArgs["debugInfo"] as? Bool {
                RiskifiedBeacon.start(shopName, sessionToken: token,debugInfo: debugInfo)
                result(nil)
            } else {
                result(FlutterError(code: "invalidArgs", message: "Shop name and token cannot be null or empty", details: nil))
            }
        } else if (call.method == "updateSessionToken") {
            if let token = call.arguments as? String {
                RiskifiedBeacon.updateSessionToken(token)
                result(nil)
            } else {
                result(FlutterError(code: "invalidArgs", message: "Token cannot be null or empty", details: nil))
            }
        } else if (call.method == "logRequest") {
            if let url = call.arguments as? String {
                RiskifiedBeacon.logRequest(URL(string: url))
                result(nil)
            } else {
                result(FlutterError(code: "invalidArgs", message: "URL cannot be null or empty", details: nil))
            }
        } else if (call.method == "logSensitiveDeviceInfo") {
            RiskifiedBeacon.logSensitiveDeviceInfo()
            result(nil)
        } else if (call.method == "riskifiedDeviceId") {
            result(RiskifiedBeacon.rCookie())
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
