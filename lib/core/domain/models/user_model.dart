class UserModel {

  UserModel(
      {this.id = '',
      this.name = '',
      this.email = '',
      this.active = false,
      this.role = '',
      this.uid = '',}
  );

  //to map and from map

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String? ?? '',
        name = json['name'] as String? ?? '',
        email = json['email'] as String? ?? '',
        active = json['active'] as bool? ?? false,
        role = json['role'] as String? ?? '',
        uid = json['uid'] as String? ?? '';
  final String id;
  final String name;
  final String email;
  final bool active;
  final String role;
  final String uid;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'active': active,
        'role': role,
        'uid': uid,
      };
}
