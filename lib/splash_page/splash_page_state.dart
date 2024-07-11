// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SplashPageState {
  final bool isLoading;

  SplashPageState({
    this.isLoading = true,
  });

  SplashPageState copyWith({
    bool? isLoading,
  }) {
    return SplashPageState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
    };
  }

  factory SplashPageState.fromMap(Map<String, dynamic> map) {
    return SplashPageState(
      isLoading: map['isLoading'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SplashPageState.fromJson(String source) =>
      SplashPageState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SplashPageState(isLoading: $isLoading)';

  @override
  bool operator ==(covariant SplashPageState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading;
  }

  @override
  int get hashCode => isLoading.hashCode;
}
