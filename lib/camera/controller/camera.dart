import 'dart:async';
import 'dart:io';
//import 'dart:io';

//import 'package:image/image.dart' as image_package;
import 'package:calories_tracker/constants.dart';
import 'package:calories_tracker/camera/model/mask.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageProvider = AsyncNotifierProvider.autoDispose<ImageNotifier, XFile?>(() => ImageNotifier());
final maskProvider = AsyncNotifierProvider.autoDispose<MasksNotifier, Mask?>(() => MasksNotifier());

class ImageNotifier extends AutoDisposeAsyncNotifier<XFile?>
{
  @override
  Future<XFile?> build() async
  {
    return null;
  }

  void selectImage({bool fromGallery = false}) async {
    final picker = ImagePicker();
    try {
      final cameraFile = await picker.pickImage(source: fromGallery? ImageSource.gallery: ImageSource.camera);
      if(cameraFile != null)
      {
        state = AsyncValue.data(XFile(cameraFile.path));
      }
      else
      {
        state = const AsyncValue.data(null);
      }
    } on PlatformException {
      state = const AsyncValue.data(null);
    }
  }
}

class MasksNotifier extends AutoDisposeAsyncNotifier<Mask?>
{
  @override
  Future<Mask?> build() async
  {
    getMasks();
    return future;
  }

  Future<void> getMasks() async
  {
    state = const AsyncLoading();
    ref.watch(imageProvider).whenData(
      (file) async {
        if(file != null)
        {
          try
          {
            var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
            print(file.name);
            var bytes = await file.readAsBytes();
            request.files.add(http.MultipartFile.fromBytes('file', bytes, filename: file.name));

            var response = await http.Response.fromStream(await request.send());
            print(utf8.decode(response.bodyBytes));
            List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
            List<Image> images = [];
            List<String> labels = [];
            for(var i in body)
            {
              List<int> intList = i['mask'].cast<int>().toList();
              Uint8List data = Uint8List.fromList(intList);
              images.add(Image.memory(data));
              labels.add(i['class']);
            }
            state = AsyncData(Mask(baseImage: Image.memory(bytes), masks: images, labels: labels));
            return;
          }
          catch(e)
          {
            developer.log('API exception', name: "picture_sending", error: e.toString());
          }
        }
      }
    );
    state = const AsyncData(null);
  }

  Image? boolListToImage(Uint8List? bytes, int width, int height)
  {
    if(bytes != null)
    {
      return Image.memory(bytes, height: height as double, width: width as double);
    }
    else
    {
      return null;
    }
  }
}