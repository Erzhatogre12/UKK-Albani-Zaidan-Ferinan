import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetDataManagement {
  String? namaUser;
  String? emailUser;
  String? nikUser;
  String? telpUser;

  Future<Map<String, String?>> dataUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final snapshot = await FirebaseFirestore.instance
          .collection('/users')
          .where('uid', isEqualTo: user?.uid)
          .get();
      final data = snapshot.docs.first.data();
      namaUser = data['nama'];
      emailUser = data['email'];
      nikUser = data['nik'];
      telpUser = data['noTelp'];
      return {
        'nama': namaUser,
        'email': emailUser,
        'nik': nikUser,
        'noTelp': telpUser,
      };
    } catch (e) {
      print(e);
      return {};
    }
  }
}

class GetDataPengaduan {
  String? judul;
  String? isi;
  String? status;
  String? image;

  
}
