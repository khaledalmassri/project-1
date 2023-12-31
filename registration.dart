import 'dart:ui'; // Import the dart:ui library for ImageFilter
import 'package:flutter/material.dart';
import 'Data.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _gender = 'Male'; // Default gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registration Page"),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/k.jpg"), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust the sigma values for blur intensity
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _idController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'ID',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an ID';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Gender",
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'Male',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value.toString();
                                  });
                                },
                              ),
                              Text('Male', style: TextStyle(color: Colors.white)),
                              Radio(
                                value: 'Female',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value.toString();
                                  });
                                },
                              ),
                              Text('Female', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                setState(() {
                                  students.add({
                                    'id': _idController.text,
                                    'name': _nameController.text,
                                    'gender': _gender,
                                  });
                                });

                                _idController.clear();
                                _nameController.clear();

                                setState(() {});
                              }
                            },
                            child: Text("Add"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Student List:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('ID', style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text('Name', style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text('Gender', style: TextStyle(color: Colors.white))),
                      ],
                      rows: students
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
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Back"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
        );
    }
}