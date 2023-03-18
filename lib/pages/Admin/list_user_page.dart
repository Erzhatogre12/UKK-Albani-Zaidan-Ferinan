import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({super.key});

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Buat User'),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    ));
  }
}
