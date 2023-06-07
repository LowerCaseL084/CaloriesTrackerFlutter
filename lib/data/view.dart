import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calories_tracker/data/controller.dart';

class DataPage extends ConsumerStatefulWidget {
  DataPage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<DataPage> createState() => _DataPageState();
}

class _DataPageState extends ConsumerState<DataPage> {
  final TextEditingController foodItemController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dataStateProvider);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 25,
          bottom: 25,
        ),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 60),
            getLabelText("Food Item"),
            getTextField(context,
                hintText: "Enter food item", controller: foodItemController),
            const SizedBox(height: 10),
            getLabelText("Calories"),
            getTextField(context,
                hintText: "Enter Caloric value",
                controller: caloriesController),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                newContent =
                    '${foodItemController.text}${caloriesController.text}  ';
                ref.read(dataStateProvider.notifier).read(context);
                ref.read(dataStateProvider.notifier).write(context);
                ref.read(dataStateProvider.notifier).read(context);
              },
              child: const Text('Add'),
            ),
            const SizedBox(height: 20),
            const Text(
              'File Content:',
            ),
            Text(fileContent),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
