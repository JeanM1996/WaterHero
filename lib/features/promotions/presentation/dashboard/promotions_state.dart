// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:waterhero/features/promotions/domain/models/contacts_model.dart';

class PromotionsState {
  final bool isLoading;
  final List<ContactsModel> promotions;

  PromotionsState({
    this.promotions = const [],
    this.isLoading = true,
  });

  PromotionsState copyWith({
    bool? isLoading,
    List<ContactsModel>? promotions,
  }) {
    return PromotionsState(
      isLoading: isLoading ?? this.isLoading,
      promotions: promotions ?? this.promotions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
      'promotions': promotions.map((x) => x.toMap()).toList(),
    };
  }

  factory PromotionsState.fromMap(Map<String, dynamic> map) {
    return PromotionsState(
      isLoading: map['isLoading'] as bool,
      promotions: List<ContactsModel>.from(
        (map['promotions'] as List<int>).map<ContactsModel>(
          (x) => ContactsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PromotionsState.fromJson(String source) =>
      PromotionsState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PromotionsState(isLoading: $isLoading, promotions: $promotions)';

  @override
  bool operator ==(covariant PromotionsState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        listEquals(other.promotions, promotions);
  }

  @override
  int get hashCode => isLoading.hashCode ^ promotions.hashCode;
}
