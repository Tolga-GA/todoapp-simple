import 'package:flutter/material.dart';
import 'package:todoapp/core/database_helper.dart';
import 'package:todoapp/models/note.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  TextEditingController controller;
  DatabaseHelper dbHelper;

  _MainScreenState() {
    controller = TextEditingController();
    dbHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[

            TextField(
              controller: controller,
            ),

            RaisedButton(
              color: Colors.blue,
              onPressed: () {
                Note myNote = Note(controller.text);
                dbHelper.insert( Note.table, myNote );
              },
              child: Text('Save'),
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'detailed_screen');
        },
        child: Icon( Icons.arrow_forward ),
      ),
    );
  }
}