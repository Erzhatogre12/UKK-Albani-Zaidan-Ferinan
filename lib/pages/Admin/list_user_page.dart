import 'package:app_pengaduan_masyarakat/controller/get_data_management.dart';
import 'package:app_pengaduan_masyarakat/pages/Admin/buat_user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({super.key});

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  Future<Map<String, dynamic>> getUsersData() async {
    final firebaseFirestore = FirebaseFirestore.instance;
    final snapshots = await firebaseFirestore.collection('users').get();
    final data = Map<String, dynamic>();
    snapshots.docs.forEach((doc) {
      data[doc.id] = doc.data();
    });
    return data;
  }

  Map<String, dynamic> usersData = {};

  @override
  void initState() {
    super.initState();
    getUsersData().then((data) {
      setState(() {
        usersData = data;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const BuatUserPage(),
                        ),
                      );
                    },
                    child: Text('Tambah User'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 500,
                    padding: const EdgeInsets.all(4),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final userData = usersData.values.toList()[index]
                            as Map<String, dynamic>;
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 75,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Nama: ${userData['nama'] ?? ''}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Nik: ${userData['nik'] ?? ''}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Role: ${userData['role'] ?? ''}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                        // Text('${userData['nama'] ?? ''}');
                      },
                      // separatorBuilder: (context, index) => const SizedBox(
                      //   height: 10,
                      // ),
                      itemCount: usersData.length,
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
