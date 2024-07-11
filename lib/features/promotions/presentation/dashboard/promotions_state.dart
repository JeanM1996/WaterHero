// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PromotionsState {
  final bool isLoading;

  PromotionsState({
    this.isLoading = true,
  });

  PromotionsState copyWith({
    bool? isLoading,
  }) {
    return PromotionsState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
    };
  }

  factory PromotionsState.fromMap(Map<String, dynamic> map) {
    return PromotionsState(
      isLoading: map['isLoading'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromotionsState.fromJson(String source) =>
      PromotionsState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PromotionsState(isLoading: $isLoading)';

  @override
  bool operator ==(covariant PromotionsState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading;
  }

  @override
  int get hashCode => isLoading.hashCode;
}
