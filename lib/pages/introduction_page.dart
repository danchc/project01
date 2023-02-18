import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:mcproject/pages/auth_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        // 2. Pass that key to the `IntroductionScreen` `key` param
        key: _introKey,
        curve: Curves.elasticIn,
        pages: [

          /* prima pagina */
          PageViewModel(
              title: '',
              bodyWidget: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      Container(
                        child: Lottie.asset('assets/animations/firstscreen.json',
                        height: 350),
                      ),
                      const SizedBox(height: 50,),
                      Text(
                        'Tieni traccia dei tuoi allenamenti',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Barlow',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Inserisci le tue schede allenamento per restare in forma ogni giorno, '
                              'quando vuoi, come preferisci tu.',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ],
                ),
              )
          ),

          /* seconda pagina */
          PageViewModel(
              title: '',
              bodyWidget:  Center(
                child: Column(
                  children: [
                    Container(
                      child: Lottie.asset('assets/animations/secondscreen.json'),
                    ),
                    const SizedBox(height: 30,),
                    Text(
                      'Controlla cosa mangi',
                      style: TextStyle(
                          fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Barlow',
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      'Monitora constantemente la tua alimentazione, aggiungendo o '
                          'eliminando gli alimenti utili al tuo fabbisogno',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
          )
        ],

        showNextButton: true,
        next: Material(
          color: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text('Next',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Barlow',
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        showDoneButton: true,
        done: Material(
          color: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text('Inizia!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Barlow',
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onDone: () => {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => AuthPage()))
        },
      ),
    );
  }
}
