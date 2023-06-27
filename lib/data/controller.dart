//import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:calories_tracker/data/model.dart';
import 'package:calories_tracker/camera/controller/camera.dart';
import 'package:calories_tracker/data/calories/calories.dart';
import 'dart:io';
import 'dart:developer' as developer;

String fileName = "my_file.txt";

final dataStateProvider =
    AsyncNotifierProvider.autoDispose<DataNotifier, String>(() {
  return DataNotifier();
});

final foodEntriesProvider = AsyncNotifierProvider.autoDispose<FoodEntriesNotifier, List<FoodEntry>>(() => FoodEntriesNotifier());

class DataNotifier extends AutoDisposeAsyncNotifier<String> {
  @override
  Future<String> build() async
  {
    return await _readFile();
  }

  //File Read-Write
  Future<String> _writeFile(List<FoodEntry> entries) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    File file = File(filePath);
    String newContent = "";
    for(var i in entries)
    {
      newContent += "${DateTime.now().toIso8601String()}\t${i.nameController.text}\t${i.caloriesController.text}\n";
    }
    return (await file.writeAsString(newContent, mode: FileMode.writeOnlyAppend)).readAsString();
  }

  Future<String> _readFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    File file = File(filePath);
    bool exists = await file.exists();

    if (exists) {
      return file.readAsString();
    } else {
      File(filePath).writeAsString("", mode: FileMode.writeOnly);
      return "";
    }
  }

  Future<void> _clearFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    File file = File(filePath);
    bool exists = await file.exists();
    if (exists) {
      file.writeAsString("", mode: FileMode.writeOnly);
    } else {
      
    }
  }

  Future<bool> write(List<FoodEntry> entries) async {
    for(var i in entries)
    {
      var x = double.tryParse(i.caloriesController.text);
      if(x == null)
      {
        return false;
      }
    }

    developer.log("Writing file.", name: "data_write");
    _writeFile(entries).then((contents) {
      // File was successfully written
      state = AsyncData(contents);
      developer.log("File written.", name: "data_write");
    }).catchError((error) {
      developer.log("Error writing file.", name: "data_write", error: error.toString());
    });
    return true;
  }

  Future<void> clear() async {
    developer.log("Clearing file.", name: "data_clear");
    return _clearFile().then((_) {
      state = const AsyncData("");
      developer.log("File cleared.", name: "data_clear");
    }).catchError(
      (error) {
        developer.log("Error clearing", name: "data_clear", error: error.toString());
      }
    );
  }
}

class FoodEntriesNotifier extends AutoDisposeAsyncNotifier<List<FoodEntry>>
{
  @override
  Future<List<FoodEntry>> build() async
  {
    _getEntries();
    return future;
  }

  Future<void> _getEntries() async {
    ref.watch(maskProvider).whenData(
      (mask) {
        if(mask == null)
        {
          state = AsyncData(List.empty());
        }
        else
        {
          List<FoodEntry> list = List.empty(growable: true);
          for(int i = 0; i < mask.labels.length; i++)
          {
            list.add(FoodEntry(name: mask.labels[i], calories: Calorie.getCalories(mask, i)));
          }
          state = AsyncData(list);
        }
      }
    );
  }

  void addEntry()
  {
    var list = List<FoodEntry>.from(state.requireValue, growable: true);
    list.add(FoodEntry(name: "", calories: 0.0));
    state = AsyncData(list);
  }

  void deleteLastEntry()
  {
    if(state.requireValue.isNotEmpty)
    {
      var list = List<FoodEntry>.from(state.requireValue, growable: true);
      list.removeLast();
      state = AsyncData(list);
    }
  }
}