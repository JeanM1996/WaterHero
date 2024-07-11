// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TipsState {
  final bool isLoading;

  TipsState({
    this.isLoading = true,
  });

  TipsState copyWith({
    bool? isLoading,
  }) {
    return TipsState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
    };
  }

  factory TipsState.fromMap(Map<String, dynamic> map) {
    return TipsState(
      isLoading: map['isLoading'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipsState.fromJson(String source) =>
      TipsState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TipsState(isLoading: $isLoading)';

  @override
  bool operator ==(covariant TipsState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading;
  }

  @override
  int get hashCode => isLoading.hashCode;
}
