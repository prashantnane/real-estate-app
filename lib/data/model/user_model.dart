// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/Extensions/lib/adaptive_type.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? mobile;
  String? address;
  int? isActive;
  bool? isProfileCompleted;
  int? notification;
  String? profile;
  String? rera;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {
      this.id,
      this.name,
      this.mobile,
      this.email,
      this.address,
      this.isActive,
      this.isProfileCompleted,
      this.notification,
      this.profile,
      this.rera,
      this.createdAt,
      this.updatedAt
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    isActive = Adapter.forceInt(json['isActive']);
    isProfileCompleted = json['isProfileCompleted'];
    notification = (json['notification'] is int)
        ? json['notification']
        : int.parse((json['notification']));
    profile = json['profile'];
    rera = json['rera'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['isActive'] = isActive;
    data['isProfileCompleted'] = isProfileCompleted;
    data['notification'] = notification;
    data['profile'] = profile;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic>? data = snapshot.data();
    log("Data at snapshot.id is : ${snapshot.id}");
    return UserModel(
      id: snapshot.id,
      name: data?['name'] ?? '',
      mobile: data?['mobile'] ?? '',
      email: data?['email'] ?? '',
      address: data?['address'] ?? '',
      isActive: data?['isActive'] ?? '',
      isProfileCompleted: data?['isProfileCompleted'] ?? '',
      notification: data?['notification'] ?? '',
      profile: data?['profile'] ?? '',
      rera: data?['rera'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(address: $address, createdAt: $createdAt, email: $email, isActive: $isActive, isProfileCompleted: $isProfileCompleted, mobile: $mobile, name: $name, notification: $notification, profile: $profile, updatedAt: $updatedAt)';
  }
}
