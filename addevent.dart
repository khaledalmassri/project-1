import 'package:flutter/material.dart';
import 'event.dart';
class AddEvent extends StatelessWidget {
  Function(String, String, String) onStudentAdded;

  AddEvent({Key? key, required this.onStudentAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _idController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _genderController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Student to Event"),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/k.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Student Information",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  TextField(
                    controller: _genderController,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Add Student"),
                            content: Text("Do you want to add this student to the event?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Call the callback function to add the student to the event
                                  onStudentAdded(
                                    _idController.text,
                                    _nameController.text,
                                    _genderController.text,
                                  );

                                  // Close the confirmation dialog
                                  Navigator.of(context).pop();

                                  // Close the AddEvent page
                                  Navigator.of(context).pop();
                                },
                                child: Text("Add"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Add Student"),
                  ),
                ],
              ),
            ),
            ),
        );
    }
}