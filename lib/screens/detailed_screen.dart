import 'package:flutter/material.dart';
import 'package:todoapp/core/database_helper.dart';
import 'package:todoapp/models/note.dart';

class DetailedScreen extends StatefulWidget {
  
  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  Note myNote = Note('');
  DatabaseHelper dbHelper;

  getLastText() async {
    var result = await dbHelper.getList( Note.table );
    setState(() {
      myNote = Note.fromMapObject( result.last );
    });
  }

  _DetailedScreenState() {
    dbHelper = DatabaseHelper();
    getLastText();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: Container(
        child: Center(
          child: Text( myNote.content ),
        ),
      ),
    );
  }
}