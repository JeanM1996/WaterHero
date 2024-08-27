// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:waterhero/features/comsumption/domain/models/register_iot.dart';

class ComsumptionState {
  final bool isLoading;
  final List<num> hours;
  final List<num> consumption;
  final bool soonToExcess;
  final num threshold;
  final num currentHour;
  final num percentageShower;
  final num waterComsumptionProjection;
  final List<RegisterIot> consumptionData;
  ComsumptionState({
    this.isLoading = true,
    this.hours = const [],
    this.consumption = const [],
    this.consumptionData = const [],
    this.soonToExcess = false,
    this.threshold = 100.00,
    this.currentHour = 0.0,
    this.percentageShower = 0.0,
    this.waterComsumptionProjection = 0.0,
  });

  ComsumptionState copyWith({
    bool? isLoading,
    List<num>? hours,
    List<num>? consumption,
    bool? soonToExcess,
    num? threshold,
    num? currentHour,
    num? percentageShower,
    num? waterComsumptionProjection,
    List<RegisterIot>? consumptionData,
  }) {
    return ComsumptionState(
      isLoading: isLoading ?? this.isLoading,
      hours: hours ?? this.hours,
      consumption: consumption ?? this.consumption,
      soonToExcess: soonToExcess ?? this.soonToExcess,
      threshold: threshold ?? this.threshold,
      currentHour: currentHour ?? this.currentHour,
      percentageShower: percentageShower ?? this.percentageShower,
      waterComsumptionProjection:
          waterComsumptionProjection ?? this.waterComsumptionProjection,
      consumptionData: consumptionData ?? this.consumptionData,
    );
  }

  @override
  String toString() {
    return 'ComsumptionState(isLoading: $isLoading, hours: $hours, consumption: $consumption, soonToExcess: $soonToExcess, threshold: $threshold, currentHour: $currentHour, percentageShower: $percentageShower, waterComsumptionProjection: $waterComsumptionProjection, consumptionData: $consumptionData)';
  }

  @override
  bool operator ==(covariant ComsumptionState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        listEquals(other.hours, hours) &&
        listEquals(other.consumption, consumption) &&
        other.soonToExcess == soonToExcess &&
        other.threshold == threshold &&
        other.currentHour == currentHour &&
        other.percentageShower == percentageShower &&
        other.waterComsumptionProjection == waterComsumptionProjection &&
        listEquals(other.consumptionData, consumptionData);
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        hours.hashCode ^
        consumption.hashCode ^
        soonToExcess.hashCode ^
        threshold.hashCode ^
        currentHour.hashCode ^
        percentageShower.hashCode ^
        waterComsumptionProjection.hashCode ^
        consumptionData.hashCode;
  }
}
