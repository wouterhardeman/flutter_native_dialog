import Flutter
import UIKit

public class SwiftFlutterNativeDialogPlugin: NSObject, FlutterPlugin {
    
    static let DEFAULT_POSITIVE_BUTTON_TEST: String = "OK"
    static let DEFAULT_NEGATIVE_BUTTON_TEST: String = "Cancel"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        // Need to make registrar an optional to supress Swift compiler warning
        let pluginRegistrar: FlutterPluginRegistrar? = registrar
        if (pluginRegistrar != nil) {
            let channel = FlutterMethodChannel(name: "flutter_native_dialog", binaryMessenger: registrar.messenger())
            let instance = SwiftFlutterNativeDialogPlugin()
            registrar.addMethodCallDelegate(instance, channel: channel)
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let arguments = call.arguments as? Dictionary<String, Any> {
            if (call.method.starts(with: "dialog.")) {
                let alertController = buildAlertController(title: arguments["title"] as? String, message: arguments["message"] as? String)
                
                if (call.method == "dialog.alert") {
                    alertController.addAction(UIAlertAction(title: arguments["positiveButtonText"] as? String ?? SwiftFlutterNativeDialogPlugin.DEFAULT_POSITIVE_BUTTON_TEST, style: .default, handler: { _ in
                        result(true)
                    }))
                    if let topController = getTopViewController() {
                        topController.present(alertController, animated: true)
                    }
                }
                
                if (call.method == "dialog.confirm") {
                    alertController.addAction(UIAlertAction(title: arguments["positiveButtonText"] as? String ?? SwiftFlutterNativeDialogPlugin.DEFAULT_POSITIVE_BUTTON_TEST, style: arguments["destructive"] as? Bool ?? false ? .destructive : .default, handler: { _ in
                        result(true)
                    }))
                    alertController.addAction(UIAlertAction(title: arguments["negativeButtonText"] as? String ?? SwiftFlutterNativeDialogPlugin.DEFAULT_NEGATIVE_BUTTON_TEST, style: .cancel, handler: { _ in
                        result(false)
                    }))
                }
                
                if let topController = getTopViewController() {
                    topController.present(alertController, animated: true)
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func buildAlertController(title: String?, message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    }
    
    private func getDefaultPositiveAction(title: String? = SwiftFlutterNativeDialogPlugin.DEFAULT_POSITIVE_BUTTON_TEST, result: @escaping FlutterResult) -> UIAlertAction {
        return UIAlertAction(title: title ?? SwiftFlutterNativeDialogPlugin.DEFAULT_POSITIVE_BUTTON_TEST, style: .default, handler: { _ in
            result(true)
        })
    }
    
    private func getTopViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        
        return nil
    }
}
