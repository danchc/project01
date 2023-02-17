import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcproject/components/my-readonly-textfield.dart';

class AccountDetails extends StatefulWidget {
  AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  /* controllers */
  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordConfirmController = TextEditingController();

  /* informazioni utente */
  final user = FirebaseAuth.instance.currentUser!;

  final String photoURL = 'assets/images/mainicon.png';

  /* altre variabili */
  final bool readOnly = true;

  /* metodo per aggiornare password */
  void aggiornaPassword() {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          'Dettagli account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Barlow',
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              color: Colors.blueAccent,
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 90,
                    child: CircleAvatar(
                      radius: 85,
                      backgroundImage: AssetImage(photoURL),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () => {
                            log('cambia foto premuto')
                          },
                          child: Container(
                            height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black,
                              ),
                              child: const Icon(Icons.photo_camera,size: 40,)
                          ),
                        ),
                      ),
                    )
                  )
                ),
              )
            ),

            Container(
                color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      /* username */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Container(
                               margin: const EdgeInsets.only(bottom: 5.0),
                              child: const Text(
                                  'Username',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Barlow',
                                  color: Color.fromARGB(255, 11, 49, 93),
                                  fontSize: 20
                                ),
                              )
                          ),
                        ],
                      ),
                      ROTextfield(
                          testo: user.displayName ?? 'Non presente',
                          hide: false,
                          readOnly: readOnly,
                      ),

                      /* email */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 5.0),
                              child: const Text(
                                  'E-mail',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Barlow',
                                    color: Color.fromARGB(255, 11, 49, 93),
                                    fontSize: 20
                                ),
                              )
                          ),
                        ],
                      ),
                      ROTextfield(
                        testo: user.email ?? 'Non presente',
                        hide: false,
                        readOnly: readOnly,
                      ),

                      /* password */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 5.0),
                              child: const Text(
                                  'Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Barlow',
                                    color: Color.fromARGB(255, 11, 49, 93),
                                    fontSize: 20
                                ),
                              )
                          ),
                        ],
                      ),

                      ROTextfield(
                        testo: '****',
                        hide: true,
                        readOnly: readOnly,
                          icona: Icons.edit,
                        onPressed: () => {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(

                                title: Text('Aggiorna password'),

                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //input nome esercizio
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: TextField(
                                        controller: passwordController,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Password'
                                        ),
                                        obscureText: true,
                                        obscuringCharacter: '*',
                                      ),
                                    ),

                                    //input numero sets
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: TextField(
                                        controller: passwordConfirmController,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Conferma Password'
                                        ),
                                        obscureText: true,
                                        obscuringCharacter: '*',
                                      ),
                                    ),
                                  ],
                                ),

                                actions: [
                                  Center(
                                    child: Material(
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                                      elevation: 18.0,
                                      clipBehavior: Clip.antiAlias,
                                      child: MaterialButton(
                                          onPressed: aggiornaPassword,
                                          child: const Text(
                                            'Salva',
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),

                        },
                      ),


                    ],
                  ),
                ),
              ),
            ),

            SizedBox(child: Container(height: 100,),)
         ],
        ),
      ),

    );
  }
}
