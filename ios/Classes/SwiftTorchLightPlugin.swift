import Flutter
import UIKit
import AVFoundation

public class SwiftTorchLightPlugin: NSObject, FlutterPlugin {
    
    // Constants
    
    let nativeEventIsTorchAvailable = "torch_available"
    let errorIsTorchAvailable = "torch_available_error"
    
    let nativeEventEnableTorch = "enable_torch"
    let errorEnableTorchExistentUser = "enable_torch_error_existent_user"
    let errorEnableTorch = "enable_torch_error"
    let errorEnableTorchNotAvailable = "enable_torch_not_available"
    
    let nativeEventDisableTorch = "disable_torch"
    let errorDisableTorchExistentUser = "disable_torch_error_existent_user"
    let errorDisableTorch = "disable_torch_error"
    let errorDisableTorchNotAvailable = "disable_torch_not_available"
    
    let nativeEventStrengthMaximumLevel = "strength_maximum_level"
    let errorStrengthMaximumLevel = "error_strength_maximum_level"
    
    // Public methods
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.svprdga.torchlight/main", binaryMessenger: registrar.messenger())
        let instance = SwiftTorchLightPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch(call.method) {
        case self.nativeEventIsTorchAvailable:
            isTorchAvailable(result: result)
            return
        case self.nativeEventEnableTorch:
            enableTorch(result: result)
            return
        case self.nativeEventDisableTorch:
            disableTorch(result: result)
            return
        case self.nativeEventStrengthMaximumLevel:
            getStrengthMaximumLevel(result: result)
            return
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // Private methods
    
    private func isTorchAvailable(result: FlutterResult) {
        guard let device = AVCaptureDevice.default(for: .video) else {
            result(FlutterError(code: self.errorIsTorchAvailable, message: "Could not determine if the device has a torch, please make sure that you are doing this on a real device.", details: nil))
            return
        }
        
        result(device.hasTorch)
    }
    
    private func enableTorch(result: FlutterResult) {
        guard let device = AVCaptureDevice.default(for: .video) else {
            result(FlutterError(code: self.errorEnableTorch, message: "Could not enable torch, please make sure that you are doing this on a real device", details: nil))
            return
        }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                device.torchMode = .on
                device.unlockForConfiguration()
            } catch {
                result(FlutterError(code: self.errorEnableTorchExistentUser, message: "Could not enable torch: ", details: nil))
            }
            
            result(nil)
        } else {
            result(FlutterError(code: self.errorEnableTorchNotAvailable, message: "Torch is not available", details: nil))
        }
    }
    
    private func disableTorch(result: FlutterResult) {
        guard let device = AVCaptureDevice.default(for: .video) else {
            result(FlutterError(code: self.errorDisableTorch, message: "Could not disable torch, please make sure that you are doing this on a real device", details: nil))
            return
        }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                device.torchMode = .off
                device.unlockForConfiguration()
            } catch {
                result(FlutterError(code: self.errorDisableTorchExistentUser, message: "Could not disable torch", details: nil))
            }
            
            result(nil)
        } else {
            result(FlutterError(code: self.errorDisableTorchNotAvailable, message: "Torch is not available", details: nil))
        }
    }
    
    private func getStrengthMaximumLevel(result: FlutterResult) {
        guard let device = AVCaptureDevice.default(for: .video) else {
            result(FlutterError(code: self.errorStrengthMaximumLevel, message: "Could not determine the strength level of the torch, please make sure that you are doing this on a real device.", details: nil))
            return
        }
        
        if device.hasTorch {
            result(AVCaptureDevice.maxAvailableTorchLevel)
        } else {
            result(0.0)
        }
    }
}
