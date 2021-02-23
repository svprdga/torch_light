package com.svprdga.torchlight

import android.content.Context.CAMERA_SERVICE
import android.hardware.camera2.CameraAccessException
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

private const val CHANNEL = "com.svprdga.torchlight/main"

private const val NATIVE_EVENT_ENABLE_TORCH = "enable_torch"
private const val ERROR_ENABLE_TORCH_EXISTENT_USER = "enable_torch_error_existent_user"
private const val ERROR_ENABLE_TORCH = "enable_torch_error"
private const val ERROR_ENABLE_TORCH_NOT_AVAILABLE = "enable_torch_not_available"

private const val NATIVE_EVENT_DISABLE_TORCH = "disable_torch"
private const val ERROR_DISABLE_TORCH_EXISTENT_USER = "disable_torch_error_existent_user"
private const val ERROR_DISABLE_TORCH = "disable_torch_error"
private const val ERROR_DISABLE_TORCH_NOT_AVAILABLE = "disable_torch_not_available"

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

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            NATIVE_EVENT_ENABLE_TORCH -> enableTorch(result)
            NATIVE_EVENT_DISABLE_TORCH -> disableTorch(result)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // ************************************ PRIVATE METHODS ************************************ //

    private fun enableTorch(result: MethodChannel.Result) {
        if (cameraId != null) {
            try {
                cameraManager.setTorchMode(cameraId!!, true)
                result.success(null)
            } catch (e: CameraAccessException) {
                result.error(ERROR_ENABLE_TORCH_EXISTENT_USER,
                        "There is an existent camera user, cannot enable torch: $e", null)
            } catch (e: Exception) {
                result.error(ERROR_ENABLE_TORCH,
                        "Could not enable torch: $e", null)
            }
        } else {
            result.error(ERROR_ENABLE_TORCH_NOT_AVAILABLE,
                    "Torch is not available", null)
        }
    }

    private fun disableTorch(result: MethodChannel.Result) {
        if (cameraId != null) {
            try {
                cameraManager.setTorchMode(cameraId!!, false)
                result.success(null)
            } catch (e: CameraAccessException) {
                result.error(ERROR_DISABLE_TORCH_EXISTENT_USER,
                        "There is an existent camera user, cannot disable torch: $e", null)
            } catch (e: Exception) {
                result.error(ERROR_DISABLE_TORCH,
                        "Could not disable torch", null)
            }
        } else {
            result.error(ERROR_DISABLE_TORCH_NOT_AVAILABLE,
                    "Torch is not available", null)
        }
    }
}
