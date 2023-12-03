import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String? id;
  final String serviceName;
  final String userPhone;
  final String address;
  final String userName;
  final String providerName;
  final String providerPhone;
  final String hourlyRate;
  final String description;
  final double lat;
  final double lang;
  final String uid;
  final String pId;
  final String imageUrl;
  final String providerImgUrl;
  final String status;

  BookingModel({
    this.id = '',
    required this.serviceName,
    required this.userName,
    required this.userPhone,

    required this.address,
    required this.providerName,
    required this.providerPhone,
    required this.description,
    required this.hourlyRate,
    required this.lat,
    required this.lang,
    required this.pId,
    required this.uid,
    required this.imageUrl,
    required this.providerImgUrl,
    this.status = 'Pending',
  });

  toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'userPhone': userPhone,
      'userName': userName,
      'address': address,
      'providerPhone': providerPhone,
      'providerName': providerName,
      'description': description,
      'hourlyRate': hourlyRate,
      'lat' : lat,
      'lang' : lang,
      'pId' : pId,
      'uid':uid,
      'providerImgUrl' : providerImgUrl,
      'imageUrl' : imageUrl,
      'status' : status,
    };
  }

  factory BookingModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final json = snapshot.data()!;
    return BookingModel(
      id: json["id"],
      serviceName: json["serviceName"],
      userName: json["userName"],
      userPhone: json["userPhone"],
      address: json["address"],
      providerName: json['providerName'],
      providerPhone: json['providerPhone'],
      description: json['description'],
      hourlyRate: json['hourlyRate'],
      lang: json['lang'],
      lat: json['lat'],
      pId: json['pId'],
      uid: json['uid'],
      imageUrl: json['imageUrl'],
      providerImgUrl: json['providerImgUrl'],
      status: json['status'],

    );
  }
}
