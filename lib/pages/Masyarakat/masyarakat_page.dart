import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MasyarakatPage extends StatefulWidget {
  const MasyarakatPage({super.key});

  @override
  State<MasyarakatPage> createState() => _MasyarakatPageState();
}

class _MasyarakatPageState extends State<MasyarakatPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Ini Masyarakat Page'),
    );
  }
}