import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduledServiceModel {
  String? id;
  final String serviceName;
  final String phone;
  final String address;
  final String name;
  final String date;
  final String time;
  final String service;
  final String status;
  final double lat;
  final double lang;

  ScheduledServiceModel({
    this.id = '',
    required this.serviceName,
    required this.phone,
    required this.address,
    required this.name,
    required this.date,
    required this.time,
    required this.service,
    this.status = 'Pending',
    required this.lat,
    required this.lang,
  });

  toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'phone': phone,
      'name': name,
      'address': address,
      'date': date,
      'time': time,
      'service': service,
      'status': status,
      'lat' : lat,
      'lang' : lang,
    };
  }

  factory ScheduledServiceModel.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final json = snapshot.data()!;
    return ScheduledServiceModel(
      id: json["id"],
      serviceName: json["serviceName"],
      phone: json["phone"],
      name: json["name"],
      address: json["address"],
      date: json['date'],
      time: json['time'],
      service: json['service'],
      status: json['status'],
      lang: json['lang'],
      lat: json['lat'],
    );
  }
}
