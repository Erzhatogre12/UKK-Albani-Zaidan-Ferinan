import 'package:app_pengaduan_masyarakat/controller/user_management.dart';
import 'package:app_pengaduan_masyarakat/model/user_model.dart';
import 'package:app_pengaduan_masyarakat/pages/Admin/admin_page.dart';
import 'package:app_pengaduan_masyarakat/pages/Admin/list_user_page.dart';
import 'package:app_pengaduan_masyarakat/widgets/input_text_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuatUserPage extends StatefulWidget {
  const BuatUserPage({super.key});

  @override
  State<BuatUserPage> createState() => _BuatUserPageState();
}

class _BuatUserPageState extends State<BuatUserPage> {
  String? _selectedRole;

  final _roles = <String>['Admin', 'Masyarakat', 'Petugas'];
  final email = TextEditingController();
  final nama = TextEditingController();
  final nik = TextEditingController();
  final noTelp = TextEditingController();
  final password = TextEditingController();

  final GlobalKey<FormState> textKey = GlobalKey<FormState>();
  final GlobalKey<FormState> buttonKey = GlobalKey<FormState>();

  void _submitForm() async {
    if (textKey.currentState!.validate() && _selectedRole != null) {
      final firebaseAuth = FirebaseAuth.instance;
      final firebaseFirestore = FirebaseFirestore.instance;

      try {
        final authResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        final uid = authResult.user!.uid;
        final documentReference =
            firebaseFirestore.collection('users').doc(uid);
        final data = {
          'nama': nama.text,
          'email': email.text,
          'nik': nik.text,
          'noTelp': noTelp.text,
          'uid': uid,
          'role': _selectedRole,
          
        };
        await documentReference.set(data);

        textKey.currentState!.reset();
        setState(() {
          _selectedRole = null;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const AdminPage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        print('Failed to create user: ${e.message}');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          top: 6,
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const AdminPage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: textKey,
                        child: Column(
                          children: [
                            InputTextAuth(
                              controller: email,
                              placeholder: 'email',
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email belum terisi';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputTextAuth(
                              controller: password,
                              placeholder: 'password',
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'password belum terisi';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputTextAuth(
                              controller: nik,
                              placeholder: 'nik',
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'NIK belum terisi';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputTextAuth(
                              controller: nama,
                              placeholder: 'nama',
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama belum terisi';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputTextAuth(
                              controller: noTelp,
                              placeholder: 'No Telp',
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'No Telp belum terisi';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value;
                          });
                        },
                        items: _roles
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.black.withAlpha(100),
                              ),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                            hintText: 'Role',
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        child: Text('Buat User'),
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
