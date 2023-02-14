import 'package:flutter/material.dart';

class MyNumberField extends StatelessWidget {

  final controller;
  final String nome;
  final String error;

  const MyNumberField({
    Key? key,
    required this.nome,
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
          keyboardType: TextInputType.number,
          controller: controller,
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
