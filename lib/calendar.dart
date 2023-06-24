import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSettingsPage extends StatefulWidget {
  const CalendarSettingsPage({super.key, required this.title});
  final String title;
  @override
  State<CalendarSettingsPage> createState() => _CalendarState();
}

class _CalendarState extends State<CalendarSettingsPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
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
        )
      ],
    );
  }
}
