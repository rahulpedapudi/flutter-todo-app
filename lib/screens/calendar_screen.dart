import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.utc(2030, 10, 10),
      ),
    );
  }
}
