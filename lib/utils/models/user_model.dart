import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  final String userName;
  final String phone;
  final String email;
  UserModel({
    this.id = '',
    required this.userName,
    required this.phone,
    required this.email,
  });

  toJson() {
    return {
      'id': id,
      'userName': userName,
      'phone': phone,
      'email': email,
    };
  }

  factory UserModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final json = snapshot.data()!;
    return UserModel(
      id: json["id"],
      userName: json["userName"],
      phone: json["phone"],
      email: json["email"],
    );
  }
}
