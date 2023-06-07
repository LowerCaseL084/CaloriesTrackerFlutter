import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

enum WriteStatus {
  read,
  appended,
  stable,
}

String fileName = "my_file.txt";
String fileContent = "";
String newContent = "";

final dataStateProvider =
    NotifierProvider.autoDispose<DataNotifier, WriteStatus>(() {
  return DataNotifier();
});

class DataNotifier extends AutoDisposeNotifier<WriteStatus> {
  DataNotifier() : super();

  @override
  WriteStatus build() {
    return WriteStatus.stable;
  }

  //File Read-Write
  Future<File> writeFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    File file = File(filePath);
    bool exists = await file.exists();
    if (exists) {
      return File(filePath).writeAsString(newContent, mode: FileMode.append);
    } else {
      return File(filePath).writeAsString(fileContent);
    }
  }

  Future<String> readFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    File file = File(filePath);
    bool exists = await file.exists();

    if (exists) {
      return file.readAsString();
    } else {
      File(filePath).writeAsString(fileContent);
      return "";
    }
  }

  Future<void> write(BuildContext context) async {
    writeFile().then((file) {
      // File was successfully written
      state = WriteStatus.appended;
      print("File written: ${file.path}");
    }).catchError((error) {
      // An error occurred while writing the file
      print("Error writing file: $error");
    });
  }

  Future<void> read(BuildContext context) async {
    readFile().then((content) {
      fileContent = content;
      state = WriteStatus.read;
      print("File content: $content");
    }).catchError((error) {
      print("Error reading file: $error");
    });
  }
}

Text getLabelText(String text, {TextAlign alignment = TextAlign.start}) =>
    Text(text, textScaleFactor: 1.1);

TextField getTextField(BuildContext context,
        {required TextEditingController controller,
        String hintText = "",
        bool obscureText = false}) =>
    TextField(
      controller: controller,
      obscureText: obscureText,
      //style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
