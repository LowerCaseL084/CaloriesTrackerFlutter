import 'package:flutter/material.dart';

class CaloriesHomePage extends StatefulWidget {
  const CaloriesHomePage({super.key, required this.title});

  final String title;

  @override
  State<CaloriesHomePage> createState() => _CaloriesHomePageState();
}

class _CaloriesHomePageState extends State<CaloriesHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ThemeColoursDefault.BACKGROUND_COLOUR,
      appBar: AppBar(
        title: Text(widget.title),
        //backgroundColor: ThemeColoursDefault.APP_BAR_COLOUR,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Today\'s Goal:',
              style: TextStyle(
                fontSize: 25.0,
                //color: ThemeColoursDefault.TEXT_COLOUR,
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