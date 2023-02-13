import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcproject/components/my-option-card.dart';

class Profilo extends StatefulWidget {
  const Profilo({Key? key}) : super(key: key);

  @override
  State<Profilo> createState() => _ProfiloState();
}

class _ProfiloState extends State<Profilo> {

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  /* informazioni utente */
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],

      /* header */
      appBar: AppBar(
        title: const Text(
            'Impostazioni',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [

            /* start zona pic+nome+exit */
            Divider(
              thickness: 1,
              color: Colors.grey[400],
            ),

            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /* foto profilo */
                  Container(
                    width: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Text(
                      'U',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),

                  /* nome utente */
                  Padding(
                    padding: const EdgeInsets.only(right: 100.0),
                    child: Container(
                      child: Text(
                        user.email!,
                        style: TextStyle(
                          fontFamily: 'Barlow',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  /* exit button */
                  GestureDetector(
                    onTap: signOut,
                    child: Container(
                      child: const Icon(
                        Icons.exit_to_app,
                        size: 30,
                      ),
                    ),
                  ),


                ],
              ),
            ),

            Divider(
              thickness: 1,
              color: Colors.grey[400],
            ),
            /* end zona pic+nome+exit */

            /* opzioni */

            MyOptionCard(descrizione: 'Profilo', icona: Icons.person),
            MyOptionCard(descrizione: 'Impostazioni', icona: CupertinoIcons.gear_solid),
            MyOptionCard(descrizione: 'Crediti', icona: CupertinoIcons.info_circle_fill),


          ],
        ),
      ),
    );

  }
}
