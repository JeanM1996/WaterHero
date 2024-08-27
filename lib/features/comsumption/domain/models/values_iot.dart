class ValuesIot {
  ValuesIot({
    required this.cubicmeters,
    required this.humid,
    required this.temp,
  });

  factory ValuesIot.fromJson(Map<String, dynamic> json) {
    return ValuesIot(
      cubicmeters: json['cubicmeters'],
      humid: json['humid'],
      temp: json['temp'],
    );
  }

  final num cubicmeters;
  final num humid;
  final num temp;

  Map<String, dynamic> toJson() {
    return {
      'cubicmeters': cubicmeters,
      'humid': humid,
      'temp': temp,
    };
  }

  ValuesIot copyWith({
    num? cubicmeters,
    num? humid,
    num? temp,
  }) {
    return ValuesIot(
      cubicmeters: cubicmeters ?? this.cubicmeters,
      humid: humid ?? this.humid,
      temp: temp ?? this.temp,
    );
  }

  @override
  String toString() =>
      'ValuesIot(cubicmeters: $cubicmeters, humid: $humid, temp: $temp)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ValuesIot &&
        o.cubicmeters == cubicmeters &&
        o.humid == humid &&
        o.temp == temp;
  }
}
