import 'dart:developer';

import 'package:app_pengaduan_masyarakat/controller/get_data_management.dart';
import 'package:app_pengaduan_masyarakat/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class MasyarakatPage extends StatefulWidget {
  const MasyarakatPage({super.key});

  @override
  State<MasyarakatPage> createState() => _MasyarakatPageState();
}

class _MasyarakatPageState extends State<MasyarakatPage> {
  final getData = GetDataManagement();

  Map<String, String?> userData = {};

  void getAllData() async {
    final data = await getData.dataUser();
    setState(() {
      userData = data;
    });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut().then(
      (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Keluar')),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getAllData();
    print('ada ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Halo ${userData['nama']}!',
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          logout();
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Adukan Aduan Anda'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Pengaduan Anda:',
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 400,
                    child: ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          color: Colors.cyan,
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    ));
  }
}
