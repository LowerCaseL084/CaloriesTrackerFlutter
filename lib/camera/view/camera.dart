//import 'package:camera/camera.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calories_tracker/camera/controller/camera.dart';
// ignore: depend_on_referenced_packages
import 'package:cross_file/cross_file.dart';

class TakePictureScreen extends ConsumerStatefulWidget {
  const TakePictureScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TakePictureScreenState();
}

class TakePictureScreenState extends ConsumerState<TakePictureScreen>
{
  @override
  Widget build(BuildContext context) {
    var image = ref.watch(imageProvider);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: image.when(
        error: (err, stack) => Center(child: Text(err.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (cameraFile) {
          if (cameraFile != null) {
            return FutureBuilder(
              future: cameraFile.readAsBytes(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState)
                {
                  case ConnectionState.done:
                    if(snapshot.data != null)
                    {
                      return showImage(context, Image.memory(snapshot.data ?? Uint8List(0)), cameraFile);
                    }
                    else
                    {
                      return showNoImage(context);
                    }
  
                  case ConnectionState.none:
                    return showNoImage(context);

                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              }
            );
          } else {
            return showNoImage(context);
          } 
        }
      ),
    );
  }

  Widget showImage(BuildContext context, Image image, XFile file)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: image,
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
                Navigator.pushNamed(context, '/picture_taking/mask');
              },
            ),
          ],
        )
      ],
    );
  }

  Widget showNoImage(BuildContext context)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Take a picture!"),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  child: const Icon(Icons.camera_alt),
                  onPressed: () {
                    ref.read(imageProvider.notifier).selectImage(fromGallery: false);
                  },
                ),
                MaterialButton(
                  child: const Icon(Icons.photo_album),
                  onPressed: () {
                    ref.read(imageProvider.notifier).selectImage(fromGallery: true);
                  },
                ),
              ],
            ),
            MaterialButton(
              child: const Text("Proceed with manual entry.\n"),
              onPressed: () {
                Navigator.pushNamed(context, '/data/data_view');
              },
            ),
          ],
        )
      ],
    );
  }
}
