import 'package:app_pengaduan_masyarakat/controller/get_data_management.dart';
import 'package:app_pengaduan_masyarakat/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashBoardPage extends StatefulWidget {
  const AdminDashBoardPage({super.key});

  @override
  State<AdminDashBoardPage> createState() => _AdminDashBoardPageState();
}

class _AdminDashBoardPageState extends State<AdminDashBoardPage> {
  final total = 10;

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
        padding: EdgeInsets.all(16),
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
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          ),
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
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(50),
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Pengaduan',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$total',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Kumpulan Pengaduan:',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 500,
                      child: ListView.separated(
                        itemCount: 10,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              
                            },
                            
                            child: Container(
                              height: 60,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(10),),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Judul',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                    
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_right,
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
