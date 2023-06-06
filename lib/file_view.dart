import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:calories_tracker/temp_constands';
import 'dart:io';

class DataPage extends ConsumerStatefulWidget {
  DataPage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<DataPage> createState() => _DataPageState();
}


class _DataPageState extends ConsumerState<DataPage> {
  //File Read-Write
  String fileName = "my_file.txt";
  String fileContent = "";
  String newContent = "to be read";

  Future<File> writeFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    return File(filePath).writeAsString(fileContent);
  }

  Future<String> readFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    File file = File(filePath);
    bool exists = await file.exists();

    if (exists) {
      return file.readAsString();
    } else {
      return "File not found!";
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
            borderRadius: BorderRadius.all(Radius.circular(TaskAppConstants.globalRadius))),
      ),
    );
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getLabelText(TempStrings.foodItemPrompt),
            getTextField(context, hintText: TempStrings.foodItemPrompt, controller: userEmailController),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  fileContent = fileContent + newContent;
                });
                writeFile().then((file) {
                  // File was successfully written
                  print("File written: ${file.path}");
                }).catchError((error) {
                  // An error occurred while writing the file
                  print("Error writing file: $error");
                });
              },
              child: Text('Write File'),
            ),
             //Readfunction implementation
            // ElevatedButton(                  
            //   onPressed: () {
            //     readFile().then((content) {
            //       setState(() {
            //         fileContent = content;
            //       });
            //       print("File content: $content");
            //     }).catchError((error) {
            //       print("Error reading file: $error");
            //     });
            //   },
            //   child: Text('Read File'),
            // ),
            const SizedBox(height: 20),
            const Text(
              'File Content:',
            ),
            Text(fileContent),
          ],
        ),
      ),
    );
  }
}