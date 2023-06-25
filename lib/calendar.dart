import 'package:calories_tracker/data/controller.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CalendarSettingsPage extends ConsumerStatefulWidget {
  const CalendarSettingsPage({super.key, required this.title});
  final String title;
  @override
  ConsumerState<CalendarSettingsPage> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<CalendarSettingsPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  Widget getDetails(DateTime day)
  {
    return ref.watch(dataStateProvider).when(
      data: (data) {
        var lines = data.split('\n');
        var totalCalories = 0.0;
        List<Widget> widgets = List.empty(growable: true);
        for(var line in lines..removeLast())
        {
          var fields = line.split('\t');
          var date = DateTime.parse(fields[0]);
          if(date.day == day.day)
          {
            totalCalories += double.parse(fields[2]);
            widgets.add(
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 64, child: Text(DateFormat('HH:mm').format(date)),),
                  Expanded(child: Text(fields[1])),
                  Text(fields[2]),
                ],
              )
            );
            widgets.add(const SizedBox(height: 10,));
            //widgets.add(const Divider());
          }
        }
        return Column(
          children: [
            const Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 64, child: Text("Time")),
                Expanded(child: Text("Food")),
                Text("Calories"),
              ],
            ),
            const Divider(),
            ... widgets,
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total: ", textScaleFactor: 1.3),
                Text(totalCalories.toString(), textScaleFactor: 1.3),
              ],
            ),
          ],
        );
      },
      error: (err, stack) => Text(err.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: content()
      ),
    );
  }

  Widget content() {
    return ListView(
      children: [
        TableCalendar(
          rowHeight: 43,
          headerStyle:
              const HeaderStyle(formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
          focusedDay: today,
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: DateTime(2030, 12, 31),
          onDaySelected: _onDaySelected,
        ),
        const SizedBox(height: 13),
        const Divider(),
        Text(
          DateFormat("dd MMMM").format(today),
          textAlign: TextAlign.left,
          textScaleFactor: 2.3,
        ),
        getDetails(today),
      ],
    );
  }
}
