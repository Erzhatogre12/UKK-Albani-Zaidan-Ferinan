import 'package:app_pengaduan_masyarakat/pages/Admin/admin_page.dart';
import 'package:app_pengaduan_masyarakat/pages/Masyarakat/masyarakat_page.dart';
import 'package:app_pengaduan_masyarakat/pages/Petugas/petugas_page.dart';
import 'package:app_pengaduan_masyarakat/pages/register_page.dart';
import 'package:app_pengaduan_masyarakat/widgets/input_text_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class BuatPengaduan extends StatefulWidget {
  const BuatPengaduan({Key? key}) : super(key: key);

  @override
  State<BuatPengaduan> createState() => _BuatPengaduanState();
}

class _BuatPengaduanState extends State<BuatPengaduan> {
  final judul = TextEditingController();
  final isiPengaduan = TextEditingController();

  final GlobalKey<FormState> textLogKey = GlobalKey<FormState>();
  final GlobalKey<FormState> buttonLogKey = GlobalKey<FormState>();

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
                        key: textLogKey,
                        child: Column(
                          children: [
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
                              obscureText: true,
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
                        onTap: () {
                          ImagePicker imagePicker = ImagePicker();
                          imagePicker.pickImage(source: ImageSource.camera);
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
                          if (textLogKey.currentState!.validate()) {

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
