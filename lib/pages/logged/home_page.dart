import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                //header
                Container(
                  color: Colors.grey[600],
                  height: 300,
                ),

                const SizedBox(height: 80,),

                /* body */
                Column(
                  children: [
                    Center(
                      child: SvgPicture.asset('assets/images/void.svg',
                      height: 200,),
                    ),


                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            'Mi sembra ancora vuoto!',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Barlow',
                            ),
                          ),
                        ),


                      ],
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
