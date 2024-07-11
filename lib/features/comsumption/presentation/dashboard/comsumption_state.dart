// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ComsumptionState {
  final bool isLoading;

  ComsumptionState({
    this.isLoading = true,
  });

  ComsumptionState copyWith({
    bool? isLoading,
  }) {
    return ComsumptionState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
    };
  }

  factory ComsumptionState.fromMap(Map<String, dynamic> map) {
    return ComsumptionState(
      isLoading: map['isLoading'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComsumptionState.fromJson(String source) =>
      ComsumptionState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ComsumptionState(isLoading: $isLoading)';

  @override
  bool operator ==(covariant ComsumptionState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading;
  }

  @override
  int get hashCode => isLoading.hashCode;
}
