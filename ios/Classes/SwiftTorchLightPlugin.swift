import Flutter
import UIKit
import AVFoundation

public class SwiftTorchLightPlugin: NSObject, FlutterPlugin {
    
    // Public methods
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "torch_light", binaryMessenger: registrar.messenger())
        let instance = SwiftTorchLightPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch(call.method) {
        case "enable_torch":
            enableTorch(result: result)
            break
        case "disable_torch":
            disableTorch(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // Private methods
    
    private func enableTorch(result: FlutterResult) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                device.torchMode = .on
                
                device.unlockForConfiguration()
            } catch {
                print("Cannot enable torch")
            }
        } else {
            print("Torch is not available")
        }
        result(nil)
    }
    
    private func disableTorch(result: FlutterResult) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                device.torchMode = .off
                
                device.unlockForConfiguration()
            } catch {
                print("Cannot disable torch")
            }
        } else {
            print("Torch is not available")
        }
        result(nil)
    }
}
