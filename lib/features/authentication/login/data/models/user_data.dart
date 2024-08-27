/// {email: jean.paul@tresastronautas.com, code: dev.351077454522098, uid: RCJIWBLYeQf64CfSue7kReWH5PQ2, name: Jean, createdAt: 2024-07-11T11:11:32.475959}

class UserData {
  UserData({
    required this.email,
    required this.code,
    required this.uid,
    required this.name,
    required this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        email: json['email'],
        code: json['code'],
        uid: json['uid'],
        name: json['name'],
        createdAt: json['createdAt'],
      );

  final String email;
  final String code;
  final String uid;
  final String name;
  final String createdAt;

  Map<String, dynamic> toJson() => {
        'email': email,
        'code': code,
        'uid': uid,
        'name': name,
        'createdAt': createdAt,
      };
}
