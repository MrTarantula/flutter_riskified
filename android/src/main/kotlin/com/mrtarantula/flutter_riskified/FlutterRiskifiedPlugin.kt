package com.mrtarantula.flutter_riskified

import androidx.annotation.NonNull
import android.content.Context
import android.util.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

import com.riskified.android_sdk.RiskifiedBeaconMainInterface
import com.riskified.android_sdk.RiskifiedBeaconMain
import com.riskified.android_sdk.RxBeacon

/** FlutterRiskifiedPlugin */
class FlutterRiskifiedPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context
    private lateinit var beacon: RiskifiedBeaconMainInterface

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_riskified")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
        beacon = RiskifiedBeaconMain()
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "startBeacon" -> {
                val shopName = call.argument<String>("shopName")
                val token = call.argument<String>("token")
                val debugInfo = call.argument<Boolean>("debugInfo") ?: false

                if (shopName.isNullOrBlank() || token.isNullOrBlank()) {
                    result.error("invalidArgs", "Shop name and token cannot be null or empty", "Expected non-empty values")
                } else {
                        beacon.startBeacon(shopName, token, debugInfo, applicationContext)
                        result.success(null)
                }
            }
            "updateSessionToken" -> {
                val token = call.arguments as String

                if (token.isNullOrBlank()) {
                    result.error("invalidArgs", "Token cannot be null or empty", "Expected non-empty value")
                } else {
                    beacon.updateSessionToken(token)
                    result.success(null)
                }
            }
            "logRequest" -> {
                val url = call.arguments as String
                if (url.isNullOrBlank()) {
                    result.error("invalidArgs", "URL cannot be null or empty", "Expected non-empty value")
                } else {
                    beacon.logRequest(url)
                    result.success(null)
                }
            }
            "logSensitiveDeviceInfo" -> {
                beacon.logSensitiveDeviceInfo()
                result.success(null)
            }
            "removeLocationUpdates" -> {
                beacon.removeLocationUpdates()
                result.success(null)
            }
            "riskifiedDeviceId" -> {
                val rCookie = beacon.rCookie()
                result.success(rCookie)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        beacon.removeLocationUpdates()
    }
}
