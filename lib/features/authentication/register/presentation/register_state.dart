// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterState {
  final bool isLoading;

  const RegisterState({
    this.isLoading = false,
  });

  RegisterState copyWith({
    bool? isLoading,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
    };
  }

  factory RegisterState.fromMap(Map<String, dynamic> map) {
    return RegisterState(
      isLoading: map['isLoading'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterState.fromJson(String source) =>
      RegisterState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RegisterState(isLoading: $isLoading)';

  @override
  bool operator ==(covariant RegisterState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading;
  }

  @override
  int get hashCode => isLoading.hashCode;
}
