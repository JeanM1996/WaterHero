// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:waterhero/features/tips/domain/models/tips_model.dart';

class TipsState {
  final bool isLoading;
  final List<TipsModel> tips;

  TipsState({
    this.isLoading = true,
    this.tips = const [],
  });

  TipsState copyWith({
    bool? isLoading,
    List<TipsModel>? tips,
  }) {
    return TipsState(
      isLoading: isLoading ?? this.isLoading,
      tips: tips ?? this.tips,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
      'tips': tips.map((x) => x.toMap()).toList(),
    };
  }

  factory TipsState.fromMap(Map<String, dynamic> map) {
    return TipsState(
      isLoading: map['isLoading'] as bool,
      tips: List<TipsModel>.from(
        (map['tips'] as List<int>).map<TipsModel>(
          (x) => TipsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TipsState.fromJson(String source) =>
      TipsState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TipsState(isLoading: $isLoading, tips: $tips)';

  @override
  bool operator ==(covariant TipsState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading && listEquals(other.tips, tips);
  }

  @override
  int get hashCode => isLoading.hashCode ^ tips.hashCode;
}
