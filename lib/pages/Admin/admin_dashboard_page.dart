import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdminDashBoardPage extends StatefulWidget {
  const AdminDashBoardPage({super.key});

  @override
  State<AdminDashBoardPage> createState() => _AdminDashBoardPageState();
}

class _AdminDashBoardPageState extends State<AdminDashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Ini Dashboard'),
      ),
    );
  }
}
