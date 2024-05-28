import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? id;
  String? profilePicture;
  String? name;
  String? lastName;
  String? phoneNumber;
  String? birthDate;
  String? role;
  String? field; // sınıf bolumlerı mobil2a, .net1a
  String? email;
  String? tcNo;
  String? country;
  String? city;
  String? district;
  String? address;
  String? aboutMe;
  // announcement
  // lessons
  
  UserModel({
    this.id,
    this.profilePicture,
    this.name,
    this.lastName,
    this.phoneNumber,
    this.birthDate,
    this.role,
    this.field,
    this.email,
    this.tcNo,
    this.country,
    this.city,
    this.district,
    this.address,
    this.aboutMe,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'profilePicture': profilePicture,
      'name': name,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'role': role,
      'field': field,
      'email': email,
      'tcNo': tcNo,
      'country': country,
      'city': city,
      'district': district,
      'address': address,
      'aboutMe': aboutMe,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      profilePicture: map['profilePicture'] != null
          ? map['profilePicture'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      birthDate: map['birthDate'] != null ? map['birthDate'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      field: map['field'] != null ? map['field'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      tcNo: map['tcNo'] != null ? map['tcNo'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      aboutMe: map['aboutMe'] != null ? map['aboutMe'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
