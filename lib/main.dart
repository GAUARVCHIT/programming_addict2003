import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:programmingaddict2003/services/notes_services.dart';

void setUpLocator() {
  GetIt.I.registerLazySingleton(() => NotesService());
}

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'StatusBar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page Widget'),
      ),
      body: Container(),
    );
  }
}
