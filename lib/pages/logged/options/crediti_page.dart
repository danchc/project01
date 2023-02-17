import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key? key}) : super(key: key);

  Future<void> openUrl(String url) async {
    final _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.platformDefault)) { // <--
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          'Crediti',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Barlow',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255,28,28,30),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[300],

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/images/dc.png'),
            ),
            const SizedBox(height: 10,),

            Container(
              child: const Text(
                'Daniel Checchia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'Barlow',
                ),
              ),
            ),

            const SizedBox(height: 10,),

            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Questa applicazione è stata sviluppata in Flutter',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Barlow'
                        ),
                      ),

                      Container(
                        width: 24,
                        child: SvgPicture.asset(
                            'assets/images/icons8-flutter.svg',
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Sono state utilizzate le icone di',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Barlow'
                        ),
                      ),

                      Text(
                        ' https://icons8.it',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Barlow',
                          color: Colors.blue
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255,28,28,30),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Sito Web',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Barlow',
                              fontWeight: FontWeight.bold,
                              fontSize: 28
                            ),
                          ),
                        ),

                        IconButton(
                            onPressed: () async => {
                              openUrl("https://danchc.github.io"),
                            },
                            icon: Icon(Icons.arrow_forward,color: Colors.white,),
                  )

                      ],
                    ),
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
