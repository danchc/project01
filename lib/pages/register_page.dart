import 'package:flutter/material.dart';
import 'package:mcproject/services/auth_service.dart';
import '/components/my-textfield.dart';
import '/components/my-button.dart';
import '/components/my-square-image.dart';
import 'package:google_sign_in/google_sign_in.dart';


class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //final nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                //zona tasto back
                AppBar(
                  leading: const BackButton(
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.grey[300],
                  elevation: 0,
                ),

                const SizedBox(height: 30,),

                //testo principale
                const Text('Registrazione',
                  style:
                  TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20,),

                //testo secondario
                const Text('Inserisci i dati per essere dei nostri',
                  style:
                  TextStyle(
                      fontFamily: 'Barlow',
                      fontSize: 20,
                      color: Colors.black
                  ),
                ),

                //zona input
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        MyTextField(
                            nome: 'Inserisci il tuo username',
                            hide: false,
                            controller: usernameController,
                          error: 'Username non valido',
                        ),
                        const SizedBox(height: 20,),
                        MyTextField(
                            nome: 'Inserisci la tua e-mail',
                            hide: false,
                            controller: emailController,
                            error: 'E-mail non valida'
                        ),
                        const SizedBox(height: 20,),
                        MyTextField(
                            nome: 'Inserisci la tua password',
                            hide: true,
                            controller: passwordController,
                            error: 'Password non valida'
                        ),
                        const SizedBox(height: 20,),

                        //bottoni
                        MyButton(name: 'Invio', onTap: () => print('tasto premuto'),),

                        const SizedBox(height: 50,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            //google
                            SquareImage(
                                image: 'assets/images/google.png',
                                onTap: () => AuthService().googleSignIn(),
                            ),

                            const SizedBox(width:30),

                            //apple
                            SquareImage(
                              image: 'assets/images/apple.png',
                              onTap: () => {},
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )

      ),
    );
  }
}
