import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  //testo nel bottone
  final String name;
  final Function()? onTap;

  const MyButton({Key? key, required this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //funzione ontap
      onTap: onTap,

      //il container
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),

        //al centro del bottone abbiamo il testo
        child: Center(
          //testo
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Barlow',
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
