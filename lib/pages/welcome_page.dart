import 'package:flutter/material.dart';
import 'package:project01/components/my-button.dart';
import 'package:project01/pages/login_page.dart';
import 'package:project01/pages/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  //metodo per login
  void signUserIn() {}

  //metodo per signup
  void signUserUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //colore background
      backgroundColor: Colors.grey[300],

      //corpo principale organizzato a colonna
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),

              //logo
              Image.asset(
                'assets/images/mainicon.png',
                height: 200,
              ),

              const SizedBox(height: 50),

              //testo
              const Text(
                'Benvenuto!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Barlow'),
              ),

              const SizedBox(height: 24),

              //sottotitolo
              const Text(
                'Sei pronto ad accettare la sfida?',
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: 'Barlow'),
              ),

              const SizedBox(height: 25),

              //bottoni
              MyButton(name: 'Login',
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage())),
                  //print("Card tapped.")
              }),

              const SizedBox(height: 50),

              //divisore
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Oppure',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ]),
              ),

              const SizedBox(height: 50),

              //bottone registrazione
              MyButton(name: 'Sign Up',
                  onTap: () =>
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegisterPage())
                    ),
                  }
              ),

              const SizedBox(height: 50),

              //copyright
              Center(
                child: Text(
                  '© Daniel Checchia',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: 'Barlow',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
