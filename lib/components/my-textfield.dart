import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final controller;
  final String nome;
  final bool hide;
  final String error;

  const MyTextField({
    Key? key,
    required this.nome,
    required this.hide,
    required this.error,
    required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextFormField(
          validator: (value) {
            if(value == null || value.isEmpty) {
              return error;
            }
            return null;
          },
          controller: controller,
          obscureText: hide,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: nome,
          ),
        ),
      ),
    );
  }
}
