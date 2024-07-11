// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContactsModel {
  ContactsModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });
  final String name;
  final String email;
  final String phone;
  final String address;

  ContactsModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    return ContactsModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  factory ContactsModel.fromMap(Map<String, dynamic> map) {
    return ContactsModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactsModel.fromJson(String source) =>
      ContactsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactsModel(name: $name, email: $email, phone: $phone, address: $address)';
  }

  @override
  bool operator ==(covariant ContactsModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ phone.hashCode ^ address.hashCode;
  }
}
