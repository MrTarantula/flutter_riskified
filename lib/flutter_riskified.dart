import 'dart:async';

import 'package:flutter/services.dart';

///
/// Riskified Plugin
///
class Riskified {
  static const MethodChannel _channel =
      const MethodChannel('flutter_riskified');

  ///
  /// Entry point, should be called in main() method.
  ///
  static Future<void> startBeacon(String shopName, String token,
          {bool debugInfo = false}) async =>
      await _channel.invokeMethod("startBeacon",
          {'shopName': shopName, 'token': token, 'debugInfo': debugInfo});

  ///
  /// Updates that the user has begun a new browsing session.
  ///
  static Future<void> updateSessionToken(String token) async =>
      await _channel.invokeMethod("updateSessionToken", token);

  ///
  /// Manually log a request to a specific URL.
  ///
  static Future<void> logRequest(String url) async =>
      await _channel.invokeMethod("logRequest", url);

  ///
  /// Manually log sensitive Personally Identifiable Information (social account data).
  ///
  static Future<void> logSensitiveDeviceInfo() async =>
      await _channel.invokeMethod("logSensitiveDeviceInfo");

  ///
  /// Get the unique Riskified Identifier.
  ///
  static Future<String> get riskifiedDeviceId async {
    final String deviceId = await _channel.invokeMethod('riskifiedDeviceId');
    return deviceId;
  }
}
