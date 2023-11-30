import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderModel {
  String? id;
  final String providerName;
  final String phone;
  final String email;
  final String service;
  final String imageUrl;

  ServiceProviderModel({
    this.id = '',
    required this.providerName,
    required this.phone,
    required this.email,
    required this.service,
    required this.imageUrl,
  });

  toJson() {
    return {
      'id': id,
      'providerName': providerName,
      'phone': phone,
      'email': email,
      'service': service,
      'photoUrl': imageUrl,
    };
  }

  factory ServiceProviderModel.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final json = snapshot.data()!;
    return ServiceProviderModel(
      id: json["id"],
      providerName: json["providerName"],
      phone: json["phone"],
      email: json["email"],
      service: json["service"],
      imageUrl: json['photoUrl'],
    );
  }
}
