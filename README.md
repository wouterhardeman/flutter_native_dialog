# flutter_native_dialog

This plugin allows to use native dialogs in Android and iOS. It was made specifically for Add2App use cases when just a part of your UI is made in Flutter. In this case, you can't use the built-in dialog system.

If you are needed integrating Flutter in your existing app, you are better off using the built-in dialog system from the [Flutter library](https://docs.flutter.io/flutter/material/AlertDialog-class.html)

## Usage

To use this plugin, add `flutter_native_dialog` as a [dependency in your pubspec.yaml file](https://flutter.io/docs/development/packages-and-plugins/using-packages).

## Example

```dart
import 'package:flutter_native_dialog/flutter_native_dialog.dart';

final result = await FlutterNativeDialog.showConfirmDialog(
      title: "This is a confirm dialog",
      message: "A message in the dialog",
      positiveButtonText: "OK",
      negativeButtonText: "Cancel",
    );

print(result); // true or false depending on user input
```
