package com.svprdga.torchlight

import android.content.Context.CAMERA_SERVICE
import android.hardware.camera2.CameraManager
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

private const val TAG = "torch_light_plugin"

class TorchLightPlugin : FlutterPlugin, MethodCallHandler {

    // ****************************************** VARS ***************************************** //

    private lateinit var channel: MethodChannel
    private lateinit var cameraManager: CameraManager
    private var cameraId: String? = null

    // *************************************** LIFECYCLE *************************************** //

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        cameraManager = flutterPluginBinding.getApplicationContext()
                .getSystemService(CAMERA_SERVICE) as CameraManager

        try {
            cameraId = cameraManager.cameraIdList[0]
        } catch (e: Exception) {
            Log.d(TAG, "Could not fetch camera id, the plugin won't work.")
        }

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "torch_light")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "enable_torch" -> enableTorch(result)
            "disable_torch" -> disableTorch(result)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // ************************************ PRIVATE METHODS ************************************ //

    private fun enableTorch(result: MethodChannel.Result) {
        cameraId?.let {
            cameraManager.setTorchMode(it, true)
        }
        result.success(null)
    }

    private fun disableTorch(result: MethodChannel.Result) {
        cameraId?.let {
            cameraManager.setTorchMode(it, false)
        }
        result.success(null)
    }
}
