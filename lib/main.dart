import 'package:flutter/material.dart';
import 'package:mcproject/data/allenamenti_data.dart';
import 'package:mcproject/pages/auth_page.dart';
import 'package:mcproject/pages/logged/home.dart';
import 'package:mcproject/pages/login_page.dart';
import 'package:mcproject/pages/register_page.dart';
import 'package:provider/provider.dart';
import 'data/workout_data.dart';
import 'pages/welcome_page.dart';
import 'pages/logged/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkoutData>(
          create: (_) => WorkoutData(),
        ),
        ChangeNotifierProvider<AllenamentiData>(
          create: (_) => AllenamentiData() ,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
        routes: {
          '/login' : (context) =>  LoginPage(),
          '/register' : (context) =>  RegisterPage(),
        },
      ),
    );
  }
}
