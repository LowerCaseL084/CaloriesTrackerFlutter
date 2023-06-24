import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calories_tracker/data/controller.dart';

class CaloriesHomePage extends ConsumerStatefulWidget {
  const CaloriesHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<CaloriesHomePage> createState() => _CaloriesHomePageState();
}

class _CaloriesHomePageState extends ConsumerState<CaloriesHomePage> {
  @override
  Widget build(BuildContext context) {
    var asyncText = ref.watch(dataStateProvider);
    return Scaffold(
      //backgroundColor: ThemeColoursDefault.BACKGROUND_COLOUR,
      appBar: AppBar(
        title: Text(widget.title),
        //backgroundColor: ThemeColoursDefault.APP_BAR_COLOUR,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            asyncText.when(
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text(err.toString()),
              data: (text) => Text(
                  'Today\'s Goal:\n$text',
                  style: const TextStyle(
                    fontSize: 25.0,
                    //color: ThemeColoursDefault.TEXT_COLOUR,
                  ),
                ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                    size: 40,
                  ),
                ),
                const Text('Settings'),
              ],
            ),
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    Navigator.pushNamed(context, '/picture_taking');
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 40,
                  ),
                ),
                const Text('Add entry'),
              ],
            ),
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    Navigator.pushNamed(context, '/calendar');
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    size: 40,
                  ),
                ),
                const Text('Calendar'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
