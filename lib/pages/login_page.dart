import 'package:app_pengaduan_masyarakat/pages/Admin/admin_page.dart';
import 'package:app_pengaduan_masyarakat/pages/Masyarakat/masyarakat_page.dart';
import 'package:app_pengaduan_masyarakat/pages/Petugas/petugas_page.dart';
import 'package:app_pengaduan_masyarakat/widgets/input_text_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  final GlobalKey<FormState> textLogKey = GlobalKey<FormState>();
  final GlobalKey<FormState> buttonLogKey = GlobalKey<FormState>();

   void login() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then(
      (value) {
        FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: value.user!.uid)
            .get()
            .then(
          (docs) {
            if (docs.docs.isNotEmpty) {
              if (docs.docs.first.get('role') == 'Masyarakat') {
                print('Role Masyarakat');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MasyarakatPage(),
                  ),
                );
              }
            } else if (docs.docs.isNotEmpty) {
              if (docs.docs.first.get('role') == 'Admin') {
                print('Role Admin');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminPage(),
                  ),
                );
              }
            } else if (docs.docs.isNotEmpty) {
              if (docs.docs.first.get('role') == 'Petugas') {
                print('Role Petugas');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PetugasPage(),
                  ),
                );
              }
            }
          },
        );
      },
    );
  }

  signIn(context) async {
    try {
      print('try 1');
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((user) {
        print('try 2');
        login();
        print('selesai');
      });
    } catch (e) {
      print(e);
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut().then(
      (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
        );
      },
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
                        key: textLogKey,
                        child: Column(
                          children: [
                            InputTextAuth(
                              controller: email, 
                              placeholder: 'Email', 
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
                              placeholder: 'Password', 
                              keyboardType: TextInputType.text, 
                              obscureText: true, 
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password belum terisi';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        key: buttonLogKey,
                        onPressed: () async {
                        if (textLogKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')
                              ),
                            );
                            print('data semua sudah terisi');
                            login();
                            print('data berhasil di masukan ke firebase');
                          }
                      }, 
                        child: Text('Log In'),
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