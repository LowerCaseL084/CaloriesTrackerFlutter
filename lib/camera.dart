import 'dart:async';
import 'dart:io';

//import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late File cameraFile;
  late Future<void> _gotPicture;

  @override
  void initState() {
    super.initState();
    _gotPicture = selectFromCamera();
  }

  Future<void> selectFromCamera() async {
    final picker = ImagePicker();
    try {
      final cameraFile = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      this.cameraFile = File(cameraFile!.path);
    } on PlatformException {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: FutureBuilder<void>(
          future: _gotPicture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              try {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 500,
                      child: SingleChildScrollView(
                        child: Image.file(cameraFile),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MaterialButton(
                          child: const Text("Back"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        MaterialButton(
                          child: const Text("Proceed"),
                          onPressed: () {
                            Navigator.pushNamed(context, '/data/data_view');
                          },
                        ),
                      ],
                    )
                  ],
                );
              } catch (e) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Picture not taken. Proceed with manual entry?"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MaterialButton(
                          child: const Text("Back"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        MaterialButton(
                          child: const Text("Proceed"),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
