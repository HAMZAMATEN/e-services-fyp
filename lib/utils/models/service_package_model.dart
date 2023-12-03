import 'package:cloud_firestore/cloud_firestore.dart';

class ServicePackageModel {
  String? id;
  String? providerImageUrl;
  String? imageUrl;
  final List<int> stars;
  final String providerName;
  final String providerPhone;
  final String providerEmail;
  final String providerId;
  final String hourlyRate;
  final String service;
  final String description;
  // bool isBooked;

  ServicePackageModel({
    this.id = '',
    this.providerImageUrl = '',
    this.imageUrl = '',
    required this.providerName,
    required this.providerPhone,
    required this.providerEmail,
    required this.providerId,
    required this.hourlyRate,
    required this.service,
    required this.description,
    required this.stars,
  // this.isBooked = false,
  });

  toJson() {
    return {
      'id': id,
      'providerImageUrl': providerImageUrl,
      'imageUrl': imageUrl,
      'providerName': providerName,
      'providerPhone' : providerPhone,
      'providerEmail': providerEmail,
      'providerId': providerId,
      'hourlyRate': hourlyRate,
      'service': service,
      'description' : description,
      'stars' : stars,
      // 'isBooked' : isBooked,
    };
  }

  factory ServicePackageModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final json = snapshot.data()!;
    return ServicePackageModel(
      id: json["id"],
      providerImageUrl: json["providerImageUrl"],
      imageUrl: json["imageUrl"],
      providerName: json["providerName"],
      providerPhone : json['providerPhone'],
      providerEmail: json["providerEmail"],
      providerId: json["providerId"],
      hourlyRate: json["hourlyRate"],
      service: json["service"],
      description : json['description'],
      stars: json['stars'],
      // isBooked: json['isBooked'],
    );
  }
}
