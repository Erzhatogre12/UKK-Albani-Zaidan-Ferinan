import 'dart:io';

import 'package:app_pengaduan_masyarakat/pages/Masyarakat/masyarakat_page.dart';
import 'package:app_pengaduan_masyarakat/widgets/input_text_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BuatPengaduan extends StatefulWidget {
  const BuatPengaduan({Key? key}) : super(key: key);

  @override
  State<BuatPengaduan> createState() => _BuatPengaduanState();
}

class _BuatPengaduanState extends State<BuatPengaduan> {
  final judul = TextEditingController();
  final isiPengaduan = TextEditingController();

  final GlobalKey<FormState> textKey = GlobalKey<FormState>();
  final GlobalKey<FormState> buttonLogKey = GlobalKey<FormState>();



  CollectionReference reference =
      FirebaseFirestore.instance.collection('pengaduan');

  String imageUrl = '';
  final tanggal =
      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

  void _submitForm() async {
    Map<String, String> dataToSend = {
      'judul': judul.text,
      'tanggal': tanggal,
      'isi': isiPengaduan.text,
      'image': imageUrl,
      'status': 'Pending',
      'tanggapan': '',
    };

    reference.add(dataToSend);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MasyarakatPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Form(
                        key: textKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MasyarakatPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.arrow_back_ios_new),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputTextAuth(
                              controller: judul,
                              placeholder: 'Judul',
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Judul belum terisi';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputTextAuth(
                              controller: isiPengaduan,
                              placeholder: 'Isi',
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Isi pengaduan belum terisi';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.camera);
                          print('${file?.path}');

                          if (file == null) return;

                          String fileName =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');

                          Reference referenceImageToUpload =
                              referenceDirImages.child(fileName);
                          try {
                            await referenceImageToUpload
                                .putFile(File(file.path));
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                            print(imageUrl);
                          } catch (error) {
                            print(error);
                          }
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            children: const [
                              Text('Pilih foto anda'),
                              Icon(Icons.photo_camera_back_outlined),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        key: buttonLogKey,
                        onPressed: () async {
                          if (textKey.currentState!.validate()) {
                            if (imageUrl.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Tolong Upload Foto terlebih dahulu')));
                            }
                            _submitForm();
                            print('dapet $imageUrl');
                            print('data semua sudah terisi');
                          }
                        },
                        child: Text('Adukan!'),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
