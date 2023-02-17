import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mcproject/components/my-option-card.dart';
import 'package:mcproject/pages/logged/options/bug_report_page.dart';
import 'package:mcproject/pages/logged/options/profilo_page.dart';

import 'crediti_page.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  /* nome utente */
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        user.email!,
                        style: const TextStyle(
                          fontFamily: 'Barlow',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  /* exit button */
                  Flexible(
                    fit: FlexFit.loose,
                    child: GestureDetector(
                      onTap: signOut,
                      child: Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.exit_to_app,
                          size: 30,
                        ),
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

            MyOptionCard(
                descrizione: 'Profilo',
                icona: Icons.person,
                onTap: () => {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountDetails()))
                },
            ),

            MyOptionCard(
                descrizione: 'Segnala un bug',
                icona: LineIcons.bug,
                onTap: () => {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => BugReportPage()))
                },
            ),

            MyOptionCard(
                descrizione: 'Crediti',
                icona: CupertinoIcons.info_circle_fill,
                onTap: () => {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreditsPage()))
              },
            ),


          ],
        ),
      ),
    );

  }
}
