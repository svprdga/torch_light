import Flutter
import UIKit
import AVFoundation

public class SwiftTorchLightPlugin: NSObject, FlutterPlugin {
    
    // Constants
    
    let nativeEventEnableTorch = "enable_torch"
    let errorEnableTorchExistentUser = "enable_torch_error_existent_user"
    let errorEnableTorch = "enable_torch_error"
    let errorEnableTorchNotAvailable = "enable_torch_not_available"
    
    let nativeEventDisableTorch = "disable_torch"
    let errorDisableTorchExistentUser = "disable_torch_error_existent_user"
    let errorDisableTorch = "disable_torch_error"
    let errorDisableTorchNotAvailable = "disable_torch_not_available"
    
    // Public methods
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.svprdga.torchlight/main", binaryMessenger: registrar.messenger())
        let instance = SwiftTorchLightPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch(call.method) {
        case self.nativeEventEnableTorch:
            enableTorch(result: result)
            return
        case self.nativeEventDisableTorch:
            disableTorch(result: result)
            return
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // Private methods
    
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
}
