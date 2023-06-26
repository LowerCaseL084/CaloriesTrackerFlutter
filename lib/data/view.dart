import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:calories_tracker/camera/controller/camera.dart';
import 'package:calories_tracker/data/controller.dart';
import 'package:calories_tracker/data/model.dart';

class DataPage extends ConsumerStatefulWidget {
  const DataPage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<DataPage> createState() => _DataPageState();
}

class _DataPageState extends ConsumerState<DataPage> {
  @override
  Widget build(BuildContext context) {
    final asyncEntries = ref.watch(foodEntriesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: asyncEntries.when(
      error: (err, stack) => Center(child: Text(err.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (entries) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 25,
            bottom: 25,
          ),
          child: ListView(
            children: <Widget>[
              //const SizedBox(height: 60),
              for(var i in entries)
                for(var j in drawEntry(context, i))
                  j,
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(foodEntriesProvider.notifier).addEntry();
                  /*newContent =
                      '${foodItemController.text}${caloriesController.text}  ';
                  ref.read(dataStateProvider.notifier).read(context);
                  ref.read(dataStateProvider.notifier).write(context);
                  ref.read(dataStateProvider.notifier).read(context);*/
                },
                child: const Text('Add'),
              ),
              if(entries.isNotEmpty)
                ElevatedButton(
                  onPressed: () {
                    ref.read(foodEntriesProvider.notifier).deleteLastEntry();
                    /*newContent =
                        '${foodItemController.text}${caloriesController.text}  ';
                    ref.read(dataStateProvider.notifier).read(context);
                    ref.read(dataStateProvider.notifier).write(context);
                    ref.read(dataStateProvider.notifier).read(context);*/
                  },
                  child: const Text('Remove'),
                ),
              ElevatedButton(
                onPressed: () {
                  enter(context, entries);
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('Enter'),
              ),
              const SizedBox(height: 20),
              /*const Text(
                'File Content:',
              ),
              Text(fileContent),
              const SizedBox(height: 20),*/
            ],
          ),
        );
      }
      ),
    );
  }

  List<Widget> drawEntry(BuildContext context, FoodEntry i)
  {
    return [
      getLabelText("Food Item"),
      getTextField(context,
          controller: i.nameController),
      const SizedBox(height: 10),
      getLabelText("Calories"),
      getTextField(context,
          controller: i.caloriesController),
      const SizedBox(height: 10),
      const Divider(),
    ];
  }

  Future<void> enter(BuildContext context, List<FoodEntry> entries) async
  {
    if(!await ref.read(dataStateProvider.notifier).write(entries))
    {
      if(context.mounted)
      {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid calories value!")));
      }
    }
  }

  Text getLabelText(String text, {TextAlign alignment = TextAlign.start}) =>
    Text(text, textScaleFactor: 1.1);

  TextField getTextField(BuildContext context,
        {required TextEditingController controller,
        bool obscureText = false}) =>
    TextField(
      controller: controller,
      obscureText: obscureText,

      //style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
}
