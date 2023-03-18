import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? id;
  final String nama;
  final String nik;
  final String noTelp;
  final String email;

   UserModel({
    this.id,
    required this.nama,
    required this.nik,
    required this.noTelp,
    required this.email,
  }) : assert(EmailValidator.validate(email));

  Map<String, String?> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nik': nik,
      'noTelp': noTelp,
      'email': email,
    };
  }

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      nama: data['nama'],
      nik: data['nik'],
      noTelp: data['noTelp'],
      email: data['email'],
    );
  }
}


class ListUser {
  final String? id;
  final String? nama;
  final String? nik;
  final String? noTelp;
  final String? email;


  ListUser({
    this.id,
    this.nama,
    this.nik,
    this.noTelp,
    this.email,
  });

  factory ListUser.fromMap(Map<String, dynamic> data) {
    return ListUser(
      id: data['id'],
      nama: data['nama'],
      nik: data['nik'],
      noTelp: data['noTelp'],
      email: data['email'],
    );
  }

  static fromJson(String data) {}
}