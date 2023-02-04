import 'package:flutter/material.dart';
import 'package:project01/components/my-textfield.dart';
import 'package:project01/components/my-button.dart';
import 'package:project01/components/my-square-image.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //colore sfondo
      backgroundColor: Colors.grey[300],

      //corpo
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),

              //testo iniziale
              const Text('Bentornato!',
                style:
                TextStyle(
                  fontFamily: 'Barlow',
                  fontSize: 50,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 80,),

              // zona input
              Container(
                child: Column(
                  children: [

                    //email input
                    MyTextField(nome: 'Inserisci la tua e-mail', hide: false, controller: emailController),

                    const SizedBox(height: 20,),

                    //password input
                    MyTextField(nome: 'Inserisci la tua password', hide: true, controller: passwordController),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Text(
                            'Hai dimenticato la password?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Barlow',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    //bottone invio
                    MyButton(name: 'Login', onTap: signIn),

                    const SizedBox(height: 50,),

                    //servizi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [

                        //google
                        SquareImage(image: 'assets/images/google.png'),

                        SizedBox(width:30),

                        //apple
                        SquareImage(image: 'assets/images/apple.png'),

                      ],
                    ),

                    const SizedBox(height: 70,),

                    //dicitura finale
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Non sei ancora un membro?',
                          style: TextStyle(
                            fontFamily: 'Barlow',
                          ),
                        ),

                        Text(
                          ' Registrati!',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Barlow',
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
