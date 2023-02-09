import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/pages/logged/add_allenamento.dart';

class Allenamenti extends StatefulWidget {
  const Allenamenti({Key? key}) : super(key: key);

  @override
  State<Allenamenti> createState() => _AllenamentiState();
}

class _AllenamentiState extends State<Allenamenti> {

  late List<String> _columnNames;
  final List<Map<String, String>> _data = [];

  @override
  void initState() {
    if(_data.isNotEmpty) {
      _columnNames = _data[0].keys.toList();
    } else {
      _columnNames = [];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Allenamenti'
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: colore,
        actions: [
          /*
          GestureDetector(
            onTap: () => {
              log('add allenamento'),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddAllenamentoPage()))},
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),*/
        ],
      ),


      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(_data.isNotEmpty) ...[
                    DataTable(
                      columns: _columnNames.map((columnName) {
                        return DataColumn(
                          label: Text(
                            columnName,
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                        );
                      }).toList(),

                      rows: _data.map((row) {
                        return DataRow(
                            cells: row.values.map((cellValue) {
                              return DataCell(
                                Text(
                                  cellValue,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }).toList());
                      }).toList(),
                    )
                  ] else ... [
                    Container(
                      alignment: AlignmentDirectional.center,
                      child:
                        const Text(
                          'Non ci sono ancora allenamenti',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        )

                    ),
                  ],

                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddAllenamentoPage()));
        },
        child: Icon(Icons.add),
      ),
    );


  }
}
