import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<dynamic>> _events;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _events = {};
  }

  String getDayText(DateTime date) {
    if (date.year == 2024 && date.month == 5 && date.day == 4) {
      return 'Day 1\n4';
    } else {
      return '${date.day}\n'; // Always return two lines, even if the second line is empty
    }
  }

  TextStyle getDayTextStyle(DateTime date) {
    if (date.year == 2024 && date.month == 5 && date.day == 1) {
      return TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12, // Small font size for Day 1
        // textAlign: TextAlign.center,
      );
    } else {
      return TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: null, // Remove the app bar
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            SizedBox(height: 20),
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
              eventLoader: (day) {
                return _events[day] ?? [];
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, _) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getDayText(date)
                              .split('\n')[0], // Display first line (Day 1)
                          style: getDayTextStyle(
                              date), // Use the custom text style
                        ),
                        SizedBox(height: 2), // Add space between lines
                        Text(
                          getDayText(date)
                              .split('\n')[1], // Display second line (4)
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
