import 'package:flutter/material.dart';
import '/components/my-button.dart';
import '/pages/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  //colore principale
  static const color = Color(0xff2b8efd);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //colore background
      backgroundColor: color,
      resizeToAvoidBottomInset: false,
      //corpo principale organizzato a colonna
      body: SafeArea(
        child: Center(
          child: Column(
            children: [

              const SizedBox(height: 60,),

              //logo
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/mainicon.png',
                  height: 180,
                ),
              ),


              //testo
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Benvenuto!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Barlow'),
                  ),
                ),
              ),

              //sottotitolo
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Sei pronto ad accettare la sfida?',
                    style: TextStyle(
                        color: Colors.white, fontSize: 20, fontFamily: 'Barlow'),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              //bottoni
              MyButton(name: 'Login',
                onTap: () => {
                  Navigator.pushNamed(context, '/login')
                }
              ),

              //divisore
              Expanded(
                child: Padding(
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
                        style: TextStyle(color: Colors.white),
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
              ),


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
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '© Daniel Checchia',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Barlow',
                          fontSize: 15,
                        ),
                      ),
                    ),
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
