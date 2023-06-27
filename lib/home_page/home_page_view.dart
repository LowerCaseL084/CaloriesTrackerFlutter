import 'package:calories_tracker/settings/model/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calories_tracker/data/controller.dart';
import 'package:calories_tracker/settings/controller/settings_controller.dart';
//import 'package:calories_tracker/data/model.dart';

class CaloriesHomePage extends ConsumerStatefulWidget {
  const CaloriesHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<CaloriesHomePage> createState() => _CaloriesHomePageState();
}

class _CaloriesHomePageState extends ConsumerState<CaloriesHomePage> {
  @override
  Widget build(BuildContext context) {
    var asyncSettings = ref.watch(settingsNotifier);
    var asyncData = ref.watch(dataStateProvider);
    return asyncSettings.when(
      loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text(err.toString()),
        data: (settings) {
        return Scaffold(
          //backgroundColor: ThemeColoursDefault.BACKGROUND_COLOUR,
          appBar: AppBar(
            title: Text(widget.title),
            //backgroundColor: ThemeColoursDefault.APP_BAR_COLOUR,
          ),
          body: asyncData.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text(err.toString()),
            data: (data) {
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Today\'s Consumption:',
                        style: TextStyle(
                          fontSize: 25.0,
                          //color: ThemeColoursDefault.TEXT_COLOUR,
                        ),
                      ),
                      const SizedBox(height:32),
                      drawGoal(settings, data),
                    ],
                  ),
                ),
              );
            }
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
                        if(settings.manualInputMode)
                        {
                          Navigator.pushNamed(context, '/data/data_view');
                        }
                        else
                        {
                          Navigator.pushNamed(context, '/picture_taking');
                        }
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
    );
  }

  Widget drawGoal(CaloriesAppSettings settings, String data)
  {
    var lines = data.split('\n');
    var totalCalories = 0.0;
    var day = DateTime.now();
    var value = 0.0;
    for(var line in lines..removeLast())
    {
      var fields = line.split('\t');
      var date = DateTime.parse(fields[0]);
      if(date.day == day.day)
      {
        totalCalories += double.parse(fields[2]);
      }
    }
    if(!settings.isRecommendedSettings && settings.targetCalories != 0.0)
    {
      value = totalCalories/settings.targetCalories;
    }
    return Column (
      children: [
        LinearProgressIndicator(value: value),
        const SizedBox(height:10),
        Text("$totalCalories/${settings.targetCalories}"),
        const SizedBox(height:10),
        if(settings.isCaloriesLessThan)
          Text(value>1.0?"It's ok! Focus harder tomorrow!":"Keep it up!"),
        if(!settings.isCaloriesLessThan)
          Text(value<1.0?"Come on! You can do it!":"Good job!"),
      ]
    );
  }
}
