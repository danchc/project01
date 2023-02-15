import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({Key? key}) : super(key: key);

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
      body: Column(
        children: [


          Expanded(
            child: Container(
              color: Colors.blueAccent,
              child:  Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 90,
                  child: CircleAvatar(
                    radius: 85,
                    backgroundImage: AssetImage('assets/images/mainicon.png'),
                    child: Container(
                      alignment: Alignment.bottomRight,
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
                  )
                )
              )
            ),
          ),

          Expanded(
            child: Container(
                color: Colors.grey[300],
            ),
          ),

          SizedBox(child: Container(height: 100,),)
       ],
      ),

    );
  }
}
