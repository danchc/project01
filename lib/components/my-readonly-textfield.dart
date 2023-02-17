import 'dart:developer';

import 'package:flutter/material.dart';

class ROTextfield extends StatelessWidget {

  final String testo;
  final bool hide, readOnly;
  final IconData? icona;
  final Function()? onPressed;

  ROTextfield({
    Key? key,
    required this.testo,
    required this.hide,
    required this.readOnly,
    this.icona,
    this.onPressed
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        readOnly: readOnly,
        style: const TextStyle(
          fontSize: 17,
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: testo,
          suffixIcon: IconButton(
            icon: Icon(icona),
            onPressed: onPressed,
          ),
        ),
        obscureText: hide,
      ),
    );
  }
}
