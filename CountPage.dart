import 'package:flutter/material.dart';

class CountPage extends StatefulWidget {
  final Map<String, List<Map<String, String>>> events;

  CountPage({required this.events});

  @override
  _CountPageState createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  TextEditingController _searchController = TextEditingController();
  String? searchResult;
  String? selectedEvent;

  @override
  void initState() {
    super.initState();
    // Initialize the selectedEvent with the first event in the list
    selectedEvent = widget.events.keys.first;
  }

  void searchStudent() {
    String studentName = _searchController.text;
    List<String> participatingEvents = [];

    widget.events.forEach((event, participants) {
      participants.forEach((participant) {
        if (participant['name'] == studentName) {
          participatingEvents.add(event);
        }
      });
    });

    setState(() {
      searchResult = participatingEvents.isNotEmpty
          ? '$studentName is participating in: ${participatingEvents.join(', ')}'
          : '$studentName is not participating in any event.';
    });
  }

  int getStudentCountInEvent(String event) {
    return widget.events[event]!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Event Counts"),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      value: selectedEvent,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedEvent = newValue;
                        });
                      },
                      items: widget.events.keys.map((String event) {
                        return DropdownMenuItem<String>(
                          value: event,
                          child: Text(event, style: TextStyle(color: Colors.green)),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Student Count in $selectedEvent: ${getStudentCountInEvent(selectedEvent!)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(labelText: 'Enter Student Name'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: searchStudent,
                      child: Text("Search"),
                    ),
                    SizedBox(height: 20),
                    if (searchResult != null)
                      Text(
                        searchResult!,
                        style: TextStyle(color: Colors.white),
                      ),
                  ],
                ),
              ),
            ),
            ),
        );
    }
}