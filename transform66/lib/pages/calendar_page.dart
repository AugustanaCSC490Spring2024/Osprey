import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  late DateTime _startDate = DateTime(2022, 1, 1);
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
      return (snapshot.data() as Map<String, dynamic>)['first_day'].toDate();
    } else {
      return DateTime.now();
    }
  }

  String getDayText(DateTime date) {
    if (_startDate != null) {
      int dayDifference = date.difference(_startDate).inDays;
      if (dayDifference >= 0 && dayDifference <= 65) {
        return 'Day ${dayDifference + 1}\n${date.day}';
      } else {
        return '${date.day}\n';
      }
    } else {
      return '${date.day}\n';
    }
  }

  TextStyle getDayTextStyle(DateTime date) {
    if (_startDate != null && date == _startDate) {
      return TextStyle(
        color: Color(0xFF636466),
        fontSize: 13, 
      );
    } else {
      return TextStyle(
        color: Color(0xFF636466),
        fontSize: 13,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, 
      body: FutureBuilder<DateTime>(
        future: fetchStartDate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else {
            _startDate = snapshot.data!;
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
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
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4.0),
                            
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 8,
                                left: 0,
                                right: 0,
                                child: Text(
                                  getDayText(date).split('\n')[0],
                                  style: getDayTextStyle(date),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Positioned(
                                top: 24,
                                left: 0,
                                right: 0,
                                child: Text(
                                  getDayText(date).split('\n')[1],
                                  style: TextStyle(
                                    color: Color(0xFF636466),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
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
            );
          }
        },
      ),
    );
  }
}
