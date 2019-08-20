// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_native_dialog/flutter_native_dialog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Verify Alert Dialog', (WidgetTester tester) async {
    const alertDialogParameters = {
      "title": "An alert appeared",
      "message": "An alert message"
    };

    FlutterNativeDialog.setMockCallHandler((call) {
      return call.method == "dialog.alert" && call.arguments["title"] == alertDialogParameters["title"]
        ? Future.value(true)
        : Future.value(false);
    });

    var result = await FlutterNativeDialog.showAlertDialog(
      title: alertDialogParameters["title"],
      message: alertDialogParameters["message"],
    );
    expect(true, result);
  });

  testWidgets("Verify Confirm Dialog", (WidgetTester tester) async {
    const confirmDialogParametersReturnTrue = {
      "title": "A confirm dialog appeared",
      "message": "A confirm dialog message"
    };

    const confirmDialogParametersReturnFalse = {
      "title": "A confirm dialog that will return false appeared",
      "message": "An confirm dialog that will return false"
    };

    FlutterNativeDialog.setMockCallHandler((call) {
      if (call.method == "dialog.confirm") {
        if (call.arguments["title"] ==
            confirmDialogParametersReturnTrue["title"]) {
          return Future.value(true);
        }
        if (call.arguments["title"] ==
            confirmDialogParametersReturnFalse["title"]) {
          return Future.value(false);
        }
      }
      return Future.value(false);
    });

    var result = await FlutterNativeDialog.showConfirmDialog(
      title: confirmDialogParametersReturnTrue["title"],
      message: confirmDialogParametersReturnTrue["message"],
    );
    expect(true, result);

    result = await FlutterNativeDialog.showConfirmDialog(
      title: confirmDialogParametersReturnFalse["title"],
      message: confirmDialogParametersReturnFalse["message"],
    );
    expect(false, result);
  });

  testWidgets("Verify Text Input Dialog", (WidgetTester tester) async {
    const title = "A text input dialog";
    const output = "Some text inserted";

    FlutterNativeDialog.setMockCallHandler((call) {
      print(call);
      if (call.method == "dialog.text-input" && call.arguments["title"] == title) {
        print("CORRECT");
        return Future.value(output);
      }
      return Future.value(null);
    });

    var result = await FlutterNativeDialog.showTextInputDialog(title: title);
    expect(output, result);

    result = await FlutterNativeDialog.showTextInputDialog(title: "Some random text");
    expect(null, result);

  });
}
