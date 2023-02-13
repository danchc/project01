import 'package:flutter/material.dart';
import 'package:mcproject/pages/logged/home.dart';
import 'pages/welcome_page.dart';
import 'pages/logged/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  //inizializzazione hive (local storage)
  await Hive.initFlutter();

  //apriamo spazio per salvataggio dati
  var box = await Hive.openBox('project_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
