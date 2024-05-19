import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<dynamic>> _events;
  late DateTime _startDate = DateTime(2022, 1, 1);
  var _endDate;
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _events = {};
  }

  Future<DateTime> fetchStartDate() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(yourEmail)
        .get();
    if (snapshot.exists) {
      return (snapshot.data() as Map<String, dynamic>)['firstDay'].toDate();
    } else {
      return DateTime.now();
    }
  }

  String getDayText(DateTime date) {
    int dayDifference = (date.difference(_startDate).inHours / 24).round();
    if (dayDifference >= 0 && dayDifference <= 65) {
      return 'Day ${dayDifference + 1}\n${date.day}';
    } else {
      return '\n${date.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<DateTime>(
            future: fetchStartDate(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching data'));
              } else {
                _startDate = snapshot.data!;
                _endDate = _startDate.add(const Duration(days: 65));
                return Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TableCalendar(
                              focusedDay: _selectedDay,
                              firstDay: DateTime(
                                  _startDate.year, _startDate.month, 1),
                              // Using zero here, below, refers to the last day of the previous month
                              lastDay: DateTime(
                                  _endDate.year, _endDate.month + 1, 0),
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
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.teal.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: Stack(children: [
                                      Positioned(
                                          top: 8,
                                          left: 0,
                                          right: 0,
                                          child: Text(
                                              getDayText(date).split('\n')[0],
                                              style: const TextStyle(
                                                  color: Color(0xFF636466),
                                                  fontSize: 8),
                                              textAlign: TextAlign.center)),
                                      Positioned(
                                          top: 24,
                                          left: 0,
                                          right: 0,
                                          child: Text(
                                              getDayText(date).split('\n')[1],
                                              style: const TextStyle(
                                                  color: Color(0xFF636466),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                              textAlign: TextAlign.center))
                                    ]));
                              }))
                        ]));
              }
            }));
  }
}
