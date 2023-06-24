//import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calories_tracker/camera/controller/camera.dart';
import 'package:calories_tracker/camera/model/mask.dart';
import 'package:flutter/material.dart';

class MaskedPictureScreen extends ConsumerStatefulWidget {
  const MaskedPictureScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MaskedPictureScreenState();
}

class MaskedPictureScreenState extends ConsumerState<MaskedPictureScreen> {
  @override
  Widget build(BuildContext context) {
    var asyncMasks = ref.watch(maskProvider);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: asyncMasks.when(
        error: (err, stack) => Center(child: Text(err.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (mask) {
          if (mask != null) {
            return showImages(context, mask);
          } else {
            return const Center(child: CircularProgressIndicator());
          } 
        }
      ),
    );
  }

  Widget showImages(BuildContext context, Mask mask)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    mask.baseImage,
                    for(var i in mask.masks)
                      i,
                  ]
                ),
                for(var i in mask.labels)
                  Text(i),
              ],
            ),
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
  }
}
