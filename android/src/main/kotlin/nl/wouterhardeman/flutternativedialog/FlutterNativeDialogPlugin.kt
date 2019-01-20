package nl.wouterhardeman.flutternativedialog

import android.app.Activity
import android.app.AlertDialog
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


class FlutterNativeDialogPlugin(val activity: Activity) : MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      if (registrar.activity() != null) {
        val channel = MethodChannel(registrar.messenger(), "flutter_native_dialog")
        channel.setMethodCallHandler(FlutterNativeDialogPlugin(registrar.activity()))
      }
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (!call.method.startsWith("dialog.")) {
      result.notImplemented()
      return
    }

    val builder = AlertDialog.Builder(activity)
    builder
      .setTitle(call.argument<String>("title"))
      .setMessage(call.argument<String>("message"))
      .setCancelable(false)

    if (call.method == "dialog.alert") {
      builder.setPositiveButton(call.argument<String>("positiveButtonText")) { _, _ -> result.success(true) }
    }

    if (call.method == "dialog.confirm") {
      builder
        .setPositiveButton(call.argument<String>("positiveButtonText")) { _, _ -> result.success(true) }
        .setNegativeButton(call.argument<String>("negativeButtonText")) { _, _ -> result.success(false) }
        .setCancelable(false)
    }

    builder.create().show()
  }
}
