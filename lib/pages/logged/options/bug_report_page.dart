import 'package:flutter/material.dart';

class BugReportPage extends StatelessWidget {
  BugReportPage({Key? key}) : super(key: key);


  /* form key */
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          'Segnala un bug',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Barlow',
            color: Color.fromARGB(255, 11, 49, 93)
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.grey[300],
      ),

      backgroundColor: Colors.grey[300],

      body: Center(
        child: Container(
        height: 450,
        width: 400,
        margin: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 1,
                  color: Colors.grey[300]!)
            ]),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Contatta',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 11, 49, 93)
                    )),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Required*';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Messaggio'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 45,
                  width: 110,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    onPressed: null,
                    child: const Text('In arrivo', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
    ),
    ),
    );
  }
}
