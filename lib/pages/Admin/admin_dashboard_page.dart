import 'dart:developer';

import 'package:app_pengaduan_masyarakat/controller/get_data_management.dart';
import 'package:app_pengaduan_masyarakat/pages/Masyarakat/buat_pengaduan.dart';
import 'package:app_pengaduan_masyarakat/pages/login_page.dart';
import 'package:app_pengaduan_masyarakat/widgets/input_text_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage>
    with TickerProviderStateMixin {
  String? id;

  String? docId;

  final getData = GetDataManagement();
  Map<String, String?> userData = {};

  void getAllData() async {
    final data = await getData.dataUser();
    setState(() {
      userData = data;
    });
  }
   void documentId() async {
    var collection = FirebaseFirestore.instance.collection('pengaduan');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; 
      
      setState(() {
        docId = documentID;
      });// <-- Document ID
    }
  }

  Future<Map<String, dynamic>> getPengaduan() async {
    final firebaseFirestore = FirebaseFirestore.instance;
    final snapshots = await firebaseFirestore
        .collection('pengaduan')
        .where('status', isEqualTo: 'Pending')
        .get();
    final data = Map<String, dynamic>();
    snapshots.docs.forEach((doc) {
      data[doc.id] = doc.data();
    });
    return data;
  }

  Future<Map<String, dynamic>> getPengaduanSudah() async {
    final firebaseFirestore = FirebaseFirestore.instance;
    final snapshots = await firebaseFirestore
        .collection('pengaduan')
        .where('status', isEqualTo: 'Sudah Ditanggapi')
        .get();
    final data = Map<String, dynamic>();
    snapshots.docs.forEach((doc) {
      data[doc.id] = doc.data();
    });
    return data;
  }

  void getPengaduanData() async {
    getPengaduan().then((data) {
      setState(() {
        pengaduanData = data;
      });
    });
  }

  void getPengaduanDataSudah() {
    getPengaduanSudah().then((data) {
      setState(() {
        pengaduanDataSudah = data;
      });
    });
  }

  

  final total = 10;

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

  Map<String, dynamic> pengaduanData = {};
  Map<String, dynamic> pengaduanDataSudah = {};
  late TabController tabController;
  final tanggapanCon = TextEditingController();

  final GlobalKey<FormState> textKey = GlobalKey<FormState>();
  final GlobalKey<FormState> buttonKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getAllData();
    getPengaduanData();
    getPengaduanDataSudah();
  documentId();
    tabController = TabController(length: 2, vsync: this);
    print('ada ');
  }

  Future<AggregateQuerySnapshot> count = FirebaseFirestore.instance
      .collection('pengaduan')
      .where('status', isEqualTo: 'Pending')
      .count()
      .get();
  Future<AggregateQuerySnapshot> countSudah = FirebaseFirestore.instance
      .collection('pengaduan')
      .where('status', isEqualTo: 'Sudah Ditanggapi')
      .count()
      .get();

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(50),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Pending',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                FutureBuilder<AggregateQuerySnapshot>(
                                  future: count,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('data hilang');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      int docCount = snapshot.data!.count;
                                      return Text(
                                        docCount.toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.green.withAlpha(50),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Sudah',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                FutureBuilder<AggregateQuerySnapshot>(
                                  future: countSudah,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('data hilang');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      int docCount = snapshot.data!.count;
                                      return Text(
                                        docCount.toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Semua Pengaduan:',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    Container(
                      child: TabBar(
                        controller: tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: const <Widget>[
                          Tab(
                            text: 'Status Pending',
                          ),
                          Tab(
                            text: 'Status Ditanggapi',
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          SizedBox(
                            height: 500,
                            child: ListView.separated(
                              itemCount: pengaduanData.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemBuilder: (context, index) {
                                final pengaduansData = pengaduanData.values
                                    .toList()[index] as Map<String, dynamic>;
                                return Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${pengaduansData['judul']}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${pengaduansData['tanggal']}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${pengaduansData['isi']}',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Status: ${pengaduansData['status']}',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                      ClipRect(
                                        clipBehavior: Clip.antiAlias,
                                        child: Image(
                                          image: NetworkImage(
                                              '${pengaduansData['image']}',
                                              scale: 5),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text(
                                                  'AlertDialog Title'),
                                              content: Column(
                                                children: [
                                                  Form(
                                                    key: textKey,
                                                    child: InputTextAuth(
                                                      controller: tanggapanCon,
                                                      placeholder:
                                                          'Isi Tanggapan anda',
                                                      keyboardType:
                                                          TextInputType.text,
                                                      obscureText: false,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Password belum terisi';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                              final updateTanggapan = FirebaseFirestore.instance.collection('pengaduan').doc(docId);

                                                      updateTanggapan.update({
                                                        'tanggapan': tanggapanCon.text,
                                                        'status': 'Sudah Ditanggapi',
                                                      });
                                                    Navigator.pop(
                                                      context,
                                                      'Tanggapi',
                                                    );
                                                  },
                                                  child: const Text('Tanggapi'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Text('Tanggapi'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 500,
                            child: ListView.separated(
                              itemCount: pengaduanDataSudah.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemBuilder: (context, index) {
                                final pengaduansDataSudah =
                                    pengaduanDataSudah.values.toList()[index]
                                        as Map<String, dynamic>;
                                return Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${pengaduansDataSudah['judul']}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${pengaduansDataSudah['tanggal']}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${pengaduansDataSudah['isi']}',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Status: ${pengaduansDataSudah['status']}',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Tanggapan: ${pengaduansDataSudah['tanggapan']}',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                        ),
                                      ),
                                      ClipRect(
                                          clipBehavior: Clip.antiAlias,
                                          child: Image(
                                            image: NetworkImage(
                                                '${pengaduansDataSudah['image']}',
                                                scale: 5),
                                          )),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
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
