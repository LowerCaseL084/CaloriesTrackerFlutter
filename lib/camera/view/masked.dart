//import 'package:camera/camera.dart';
import 'package:calories_tracker/settings/controller/settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calories_tracker/camera/controller/camera.dart';
import 'package:calories_tracker/camera/model/mask.dart';
import 'package:calories_tracker/constants.dart';
import 'package:calories_tracker/data/calories/calories.dart';
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
            return showNoImage(context);
            //return const Center(child: CircularProgressIndicator());
          } 
        }
      ),
    );
  }

  Widget showNoImage(BuildContext context)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text("Could not connect to server."),
        MaterialButton(
          child: const Text("Proceed with manual entry.\n"),
          onPressed: () {
            Navigator.pushNamed(context, '/data/data_view');
          },
        )
      ],
    );
  }

  Widget showImages(BuildContext context, Mask mask)
  {
    var asyncSettings = ref.read(settingsNotifier);
    List<CaloriesAllergy> allergies = Calorie.getAllAllergies(mask);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      mask.baseImage,
                      for(var i in mask.masks)
                        i,
                    ]
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                ...
                asyncSettings.when(
                  data: (settings) => [
                      const Text("Allergies detected: ", textScaleFactor: 1.3),

                      for(var i in allergies)
                        if(settings.hasAllergy(i))
                          Text(i.text),
                    ],
                  loading: () => [
                      const Text("Allergies detected: ", textScaleFactor: 1.3),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  error: (err, stack) => [
                      const Text("Cannot load allergies ", textScaleFactor: 1.3),
                      Text(err.toString()),
                    ]
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                const Text("Food identified: ", textScaleFactor: 1.3),
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
