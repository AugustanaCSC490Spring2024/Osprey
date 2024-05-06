import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:transform66/auth.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late User? user;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<dynamic>> _events;
  //late TextEditingController _eventController;

  @override
  void initState() {
    super.initState();
    user = Auth().currentUser;
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _events = {};
    //_eventController = TextEditingController();
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24
          ),
        ),
        backgroundColor: Colors.teal
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //_calendarButton(),
            const Text(
                'Your history:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            const SizedBox(height: 20),
            TableCalendar(
              focusedDay: _selectedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _selectedDay = focusedDay;
              },
              eventLoader: (day) {
                // Return events for a particular day from _events map
                return _events[day] ?? [];
              },
            ),
          ],
        ),
      ),
    );
  }
}
