import 'package:app_pengaduan_masyarakat/controller/user_management.dart';
import 'package:app_pengaduan_masyarakat/pages/login_page.dart';
import 'package:app_pengaduan_masyarakat/widgets/input_text_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  singup() async {
    print('try 1');
    try {
      print('try 2');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((signedUser) async {
        print('try 3');
        await UserManagement().createNewUser(
          signedUser.user,
          nama.text,
          nik.text,
          noTelp.text,
          context,
        );
        print('masuk semua');

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      });
    } catch (error) {
      print(error);
    }
  }

  final GlobalKey<FormState> textKey = GlobalKey<FormState>();
  final GlobalKey<FormState> buttonKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final nama = TextEditingController();
  final nik = TextEditingController();
  final noTelp = TextEditingController();
  final password = TextEditingController();

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
                    ElevatedButton(
                      key: buttonKey,
                      onPressed: () async {
                        if (textKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          print('data semua sudah terisi');
                          await singup();
                          print('data berhasil di masukan ke firebase');
                        }
                      },
                      child: Text('Register'),
                    ),
                    Row(
                        children: [
                          Text(
                            'Dah Punya Akun?',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Log In',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
