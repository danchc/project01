import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcproject/pages/logged/home_page.dart';
import 'package:mcproject/pages/login_page.dart';
import 'package:mcproject/pages/welcome_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          //se è un utente con e-mail verificata
          if(snapshot.hasData && FirebaseAuth.instance.currentUser!.emailVerified) {
            return const HomePage();
          }
          //altrimenti
          else {
            return const WelcomePage();
          }

        },
      ),
    );
  }
}
