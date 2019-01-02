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
    const alertDialogParametersReturnTrue = {
      "title": "An alert appeared",
      "message": "An alert message"
    };

    const alertDialogParametersReturnFalse = {
      "title": "An alert that will return false appeared",
      "message": "An alert message that will return false"
    };

    FlutterNativeDialog.setMockCallHandler((call) {
      if (call.method == "dialog.alert") {
        if (call.arguments["title"] ==
            alertDialogParametersReturnTrue["title"]) {
          return Future.value(true);
        }
        if (call.arguments["title"] ==
            alertDialogParametersReturnFalse["title"]) {
          return Future.value(false);
        }
      }
    });

    var result = await FlutterNativeDialog.showAlertDialog(
      title: alertDialogParametersReturnTrue["title"],
      message: alertDialogParametersReturnTrue["message"],
    );
    expect(true, result);

    result = await FlutterNativeDialog.showAlertDialog(
      title: alertDialogParametersReturnFalse["title"],
      message: alertDialogParametersReturnFalse["message"],
    );
    expect(false, result);
  });
}
