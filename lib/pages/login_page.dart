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

  void login() async {
    print('ini cek auth FireBase');
    final UserCredential value =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    print('ini cek role user');
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: value.user!.uid)
        .get()
        .then(
      (docs) {
        if (docs.docs.isNotEmpty) {
          print('Mulai');
          if (docs.docs.first.get('role') == 'Masyarakat') {
            print('role Masyarakat');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const MasyarakatPage(),
              ),
            );
            print('berhasil');
          } else if (docs.docs.first.get('role') == 'Admin') {
            print('role Admin');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminPage(),
              ),
            );
            print('berhasil');
          } else if (docs.docs.first.get('role') == 'Petugas') {
            print('role Petugas');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const PetugasPage(),
              ),
            );
            print('berhasil');
          } else {
            print('not called');
          }
        }
      },
    );
  }

  signIn(context) async {
    try {
      print('try 1');
      login();
      print('try 2');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Berhasil Masuk')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password Atau Email Salah'),
        ),
      );
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
                              const SnackBar(content: Text('Processing Data')),
                            );
                            print('data semua sudah terisi');
                            login();
                          }
                        },
                        child: Text('Log In'),
                      ),
                      Row(
                        children: [
                          Text(
                            'Belum Punya Akun?',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Register',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
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
