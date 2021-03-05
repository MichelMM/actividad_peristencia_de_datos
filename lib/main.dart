import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'home/home.dart';

void main() async {
  // Asegurar de que inicialice Hive
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await getApplicationDocumentsDirectory(); // no c ve
  // final storageExternal = await getExternalStorageDirectory(); // si c ve
  Hive.init(storage.path);
  await Hive.openBox("configs");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'persistencia',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Persistencia de datos"),
        ),
        body: Home(),
      ),
    );
  }
}
