// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RestoreState {
  final bool isLoading;

  const RestoreState({
    this.isLoading = false,
  });

  RestoreState copyWith({
    bool? isLoading,
  }) {
    return RestoreState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
    };
  }

  factory RestoreState.fromMap(Map<String, dynamic> map) {
    return RestoreState(
      isLoading: map['isLoading'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestoreState.fromJson(String source) =>
      RestoreState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RestoreState(isLoading: $isLoading)';

  @override
  bool operator ==(covariant RestoreState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading;
  }

  @override
  int get hashCode => isLoading.hashCode;
}
