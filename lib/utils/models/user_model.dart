import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  final String userName;
  final String phone;
  final String email;
  final String photoUrl;

  UserModel({
    this.id = '',
    required this.userName,
    required this.phone,
    required this.email,
    required this.photoUrl,
  });

  toJson() {
    return {
      'id': id,
      'userName': userName,
      'phone': phone,
      'email': email,
      'photoUrl' : photoUrl,
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
        photoUrl : json['photoUrl'],
    );
  }
}
