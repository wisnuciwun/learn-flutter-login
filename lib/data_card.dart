import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learn_flutter_login/data_api.dart';

class DataCard extends StatelessWidget {
  final DataApi dataApi;

  const DataCard({Key? key, required this.dataApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.amber[400],
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 50,
              child: Text('ID'),
            ),
            SizedBox(width: 220, child: Text("${dataApi.id}"),)
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 50,
              child: Text("Name"),
            ),
            SizedBox(width: 220, child: Text("${dataApi.name}"),)
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 50,
              child: Text("Email"),
            ),
            SizedBox(width: 220, child: Text("${dataApi.email}"),)
          ],
        )
      ],
    ),
   ); 
  }
}