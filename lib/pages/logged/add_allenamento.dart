import 'package:flutter/material.dart';

class AddAllenamentoPage extends StatefulWidget {
  const AddAllenamentoPage({Key? key}) : super(key: key);

  @override
  State<AddAllenamentoPage> createState() => _AddAllenamentoPageState();
}

class _AddAllenamentoPageState extends State<AddAllenamentoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: [

            AppBar(
              leading: const BackButton(
                color: Colors.black,
              ),
              backgroundColor: Colors.grey[300],
              elevation: 0,
            ),



          ],
        ),
      ),
    );
  }
}
