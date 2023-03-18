import 'package:app_pengaduan_masyarakat/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserManagement {
  var useRole = '';

  createNewUser(
    user,
    nama,
    nik,
    noTelp,
    context,
  ) {
    FirebaseFirestore.instance.collection('users').add(
      {
        'email': user.email,
        'uid': user.uid,
        'nama': nama,
        'nik': nik,
        'noTelp': noTelp,
        'role': 'Masyarakat'
      },
    ).then(
      (value) {
        print('data masuk $value');
        // Navigator.pop(context);
        // Navigator.pushReplacement(
        //   context,
        //   CupertinoPageRoute(
        //     builder: (_) => const LoginPage(),
        //   ),
        // );
      },
    );
  }
}

class UserCreateManagement {
   String? _selectedRole;
  var useRole = '';

  createNewUser(
    nama,
    nik,
    noTelp,
    context,
  ) {
    void _addRole() async {
    if (_selectedRole != null) {
      final firebaseFirestore = FirebaseFirestore.instance;
      final documentReference = firebaseFirestore.collection('users').doc();
      final data = {'role': _selectedRole};
      await documentReference.set(data);
    }
  }
    FirebaseFirestore.instance.collection('users').add(
      {
        'nama': nama,
        'nik': nik,
        'role': _selectedRole,
        'noTelp': noTelp,
      },
    ).then(
      (value) {
        print('data masuk $value');
        // Navigator.pop(context);
        // Navigator.pushReplacement(
        //   context,
        //   CupertinoPageRoute(
        //     builder: (_) => const LoginPage(),
        //   ),
        // );
      },
    );
  }
}