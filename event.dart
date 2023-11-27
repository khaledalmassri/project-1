// event_page.dart

import 'package:flutter/material.dart';
import 'NewEvent.dart';
import 'addevent.dart';
import 'data.dart'; // Import the students list
import 'CountPage.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Map<String, String>> students1 = [
    {'id': '1', 'name': 'nawfal', 'gender': 'Male', 'sport': 'Football'},
    {'id': '2', 'name': 'Jane', 'gender': 'Female', 'sport': 'Basketball'},
    {'id': '3', 'name': 'saif', 'gender': 'Male', 'sport': 'Football'},
    {'id': '4', 'name': 'ali', 'gender': 'Male', 'sport': 'Basketball'},
    {'id': '5', 'name': 'bilal', 'gender': 'Male', 'sport': 'running'},
    {'id': '6', 'name': 'Nadim', 'gender': 'Male', 'sport': 'Tennis'},
  ];


  String selectedEvent = 'Football';

  Map<String, String> eventImages = {
    'Football': 'images/footbal.jpg',
    'Basketball': 'images/bascket.jpg',
    'Tennis': 'images/tennis.jpg',
  };

  int getStudentCount(String event) {
    return students1.where((student) => student['sport'] == event).length;
  }

  void addStudentToEvent(String id, String name, String gender) {
    setState(() {
      students1.add({'id': id, 'name': name, 'gender': gender, 'sport': selectedEvent});
    });
  }

  void onEventAdded(String newEvent) {
    setState(() {
      eventImages[newEvent] = 'assets/football.jpg';
    });
  }

  void showStudentCount() {
    int footballCount = getStudentCount('Football');
    int basketballCount = getStudentCount('Basketball');
    int tennisCount = getStudentCount('Tennis');

    Map<String, List<Map<String, String>>> eventCounts = {
      'Football': students1.where((student) => student['sport'] == 'Football').toList(),
      'Basketball': students1.where((student) => student['sport'] == 'Basketball').toList(),
      'Tennis': students1.where((student) => student['sport'] == 'Tennis').toList(),
    };

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CountPage(events: eventCounts)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Event"),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/k.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Select Your Event",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: selectedEvent,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedEvent = newValue!;
                      });
                    },
                    items: eventImages.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('ID', style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text('Name', style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text('Gender', style: TextStyle(color: Colors.white))),
                      ],
                      rows: students1
                          .where((student) => student['sport'] == selectedEvent)
                          .map(
                            (student) => DataRow(
                          cells: [
                            DataCell(Text(student['id'] ?? '', style: TextStyle(color: Colors.white))),
                            DataCell(Text(student['name'] ?? '', style: TextStyle(color: Colors.white))),
                            DataCell(Text(student['gender'] ?? '', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      )
                          .toList(),
                    ),
                  ),
                  if (eventImages.containsKey(selectedEvent))
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Image.asset(
                        eventImages[selectedEvent]!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  final newEvent = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NewEvent()),
                  );

                  if (newEvent != null && newEvent is String) {
                    onEventAdded(newEvent);
                  }
                },
                child: Text("Add"),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddEvent(onStudentAdded: addStudentToEvent)),
                  );
                },
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: showStudentCount,
                child: Text("see"),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
    }
}