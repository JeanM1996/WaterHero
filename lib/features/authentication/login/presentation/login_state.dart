// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginState {
  final bool isLoading;

  const LoginState({
    this.isLoading = false,
  });

  LoginState copyWith({
    bool? isLoading,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      isLoading: map['isLoading'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginState.fromJson(String source) =>
      LoginState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginState(isLoading: $isLoading)';

  @override
  bool operator ==(covariant LoginState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading;
  }

  @override
  int get hashCode => isLoading.hashCode;
}
