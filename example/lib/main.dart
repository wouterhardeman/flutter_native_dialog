import 'package:flutter/material.dart';
import 'package:flutter_native_dialog/flutter_native_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool confirmDialogResult;
  bool destructiveConfirmDialogResult;

  void _showAlertDialog() {
    FlutterNativeDialog.showAlertDialog(
      title: "This is an alert dialog",
      message: "A message in the dialog",
    );
  }

  void _showConfirmDialog() async {
    final result = await FlutterNativeDialog.showConfirmDialog(
      title: "This is a confirm dialog",
      message: "A message in the dialog",
      positiveButtonText: "OK",
      negativeButtonText: "Cancel",
    );
    setState(() {
      confirmDialogResult = result;
    });
  }

  void _showDestructiveConfirmDialog() async {
    final result = await FlutterNativeDialog.showConfirmDialog(
      title: "This is a descructive confirm dialog",
      message: "A message in the dialog",
      positiveButtonText: "Delete",
      negativeButtonText: "Cancel",
      destructive: true,
    );
    setState(() {
      destructiveConfirmDialogResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Dialog Example'),
        ),
        body: Center(
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  child: Text("Show alert dialog"),
                  onPressed: _showAlertDialog,
                ),
                RaisedButton(
                  child: Text("Show confirm dialog"),
                  onPressed: _showConfirmDialog,
                ),
                Text(
                  "Confirm dialog returned: " + confirmDialogResult.toString(),
                  textAlign: TextAlign.center,
                ),
                RaisedButton(
                  child: Text("Show destructive confirm dialog (iOS)"),
                  onPressed: _showDestructiveConfirmDialog,
                ),
                Text(
                  "Destructive confirm dialog returned: " +
                      destructiveConfirmDialogResult.toString(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
