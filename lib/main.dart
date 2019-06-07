import 'package:flutter/material.dart';
import 'package:todoapp/screens/detailed_screen.dart';
import 'package:todoapp/screens/main_screen.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatefulWidget{
  
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return MaterialApp(
      initialRoute: 'main_screen',
      routes: <String, WidgetBuilder>{
        'main_screen': (context) => MainScreen(),
        'detailed_screen': (context) => DetailedScreen(),
      },
    );
  }
}