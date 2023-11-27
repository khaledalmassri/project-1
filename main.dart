import 'package:flutter/material.dart';
import 'package:untitled1/Data.dart';
import 'registration.dart';
import 'event.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isBackgroundImageVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            "SCHOOL EVENT",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: isBackgroundImageVisible
                  ? DecorationImage(
                image: AssetImage("images/k.jpg"),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RegistrationPage()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: Text("Register"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EventPage()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: Text("Event"),
                  ),
                  SizedBox(height: 20),

                  SizedBox(height: 20),
                  Checkbox(
                    value: isBackgroundImageVisible,
                    onChanged: (value) {
                      setState(() {
                        isBackgroundImageVisible = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            ),
        );
    }
}