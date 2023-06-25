import 'package:flutter/material.dart';

class InputDialog {
  // From Harsh Pipaliya
  // https://stackoverflow.com/questions/49778217/how-to-create-a-dialog-that-is-able-to-accept-text-input-and-show-result-in-flut

  static Future<void> displayTextInputDialog(BuildContext context,
      {String title = '',
      required TextEditingController controller,
      required void Function(String) onTextEntered}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: title),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                onTextEntered(controller.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> displayIntInputDialog(BuildContext context,
      {String title = '',
      required TextEditingController controller,
      required void Function(int) onIntEntered}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: controller,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                int? val = int.tryParse(controller.text);
                if (val == null) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Invalid input"),
                          content: Text("Enter valid integer!"),
                        );
                      });
                } else {
                  onIntEntered(val);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> displayDoubleInputDialog(BuildContext context,
      {String title = '',
      required TextEditingController controller,
      required void Function(double) onIntEntered}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: controller,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                double? val = double.tryParse(controller.text);
                if (val == null) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Invalid input"),
                          content: Text("Enter valid integer!"),
                        );
                      });
                } else {
                  onIntEntered(val);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}