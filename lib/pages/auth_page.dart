import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcproject/pages/logged/home_page.dart';
import 'package:mcproject/pages/login_page.dart';
import 'package:mcproject/pages/welcome_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          //se è loggato
          if(snapshot.hasData) {

            return const HomePage();
          }
          //se non è loggato
          else {
            return const WelcomePage();
          }

        },
      ),
    );
  }
}
