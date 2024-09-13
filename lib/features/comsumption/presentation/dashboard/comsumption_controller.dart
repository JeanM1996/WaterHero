import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/features/authentication/login/domain/use_cases/get_user_info_current_session_use_case.dart';
import 'package:waterhero/features/comsumption/domain/models/register_iot.dart';
import 'package:waterhero/features/comsumption/domain/use_cases/get_register_iot_use_case.dart';
import 'package:waterhero/features/comsumption/presentation/dashboard/comsumption_state.dart';

class ComsumptionController extends StateNotifier<ComsumptionState> {
  ComsumptionController(
    this.getAdvisorsUseCase,
    this.getUserInfoCurrentSessionUseCase,
  ) : super(
          ComsumptionState(),
        );
  final GetRegisterIotUseCase getAdvisorsUseCase;
  final GetUserInfoCurrentSessionUseCase getUserInfoCurrentSessionUseCase;
  dynamic setIsLoading(isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  // Function to group registers by day
  List<List<RegisterIot>> groupRegistersByDay(
    List<RegisterIot> hourlyRegisters,
  ) {
    final groupedRegisters = <String, List<RegisterIot>>{};
    for (final register in hourlyRegisters) {
      final dayKey = DateFormat('yyyy-MM-dd').format(
        DateTime.fromMillisecondsSinceEpoch(
          register.when.toInt() * 1000,
        ),
      );
      print('dayKey: $dayKey');

      if (!groupedRegisters.containsKey(dayKey)) {
        groupedRegisters[dayKey] = [];
      }
      groupedRegisters[dayKey]!.add(register);
    }

    // Convert the map values to a list of lists
    return groupedRegisters.values.toList();
  }

  //get thresolh from     final remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> getThreshold() async {
    // final threshold = remoteConfig.getInt('threshold');
    var threshold = 100.00;
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );
    await remoteConfig.fetchAndActivate();
    await remoteConfig.setDefaults(<String, dynamic>{
      'threshold': threshold,
    });

    threshold = remoteConfig.getDouble('threshold');
    state = state.copyWith(threshold: threshold);
    //LocalStorage
    final storage = await SharedPreferences.getInstance();
    final serviceCode = storage.getString('serviceCode');

    if (serviceCode == null) {
      final result = await getUserInfoCurrentSessionUseCase.execute();
      result.fold(
        (failure) => state = state.copyWith(isLoading: false),
        (serviceCode) {
          storage.setString('serviceCode', serviceCode);
        },
      );
    }
  }

  Future<void> getRegistersDevice() async {
    final storage = await SharedPreferences.getInstance();
    final serviceCode = storage.getString('serviceCode') ?? 'error';

    if (serviceCode != 'error') {
      final code = serviceCode.replaceAll('.', ':');
      final result = await getAdvisorsUseCase.execute(code);
      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false);
        },
        (registers) {
          final days = <num>[];
          final consumption = <num>[];

          registers.sort((a, b) => a.triWhen.compareTo(b.triWhen));

          //generate a register for each day with the total of cubic meters consumed
          final registersByDay = groupRegistersByDay(registers);
          // List<List<RegisterIot>>
          for (final element in registersByDay) {
            final dayInNumber = DateTime.fromMillisecondsSinceEpoch(
              element.first.triWhen.toInt() * 1000,
            );
            final totalCubicMeters = element.fold<num>(
              0,
              (previousValue, element) =>
                  previousValue + element.body.cubicmeters,
            );
            consumption.add(totalCubicMeters);
            days.add(dayInNumber.day);
          }

          final currentDay = DateTime.now().day;

          var falseS = false;
          if (consumption.isNotEmpty) {
            falseS = consumption.last > state.threshold;
          }

          //final soonToExcess = consumption.last > state.threshold;
          state = state.copyWith(
            isLoading: false,
            hours: days,
            consumption: consumption,
            currentHour: currentDay,
            soonToExcess: falseS,
            percentageShower: calculateExcessPercentage(
              consumption,
              0.13,
            ),
            consumptionData: registers,
            waterComsumptionProjection: projectWaterComsumptionDaily(
              consumption,
            ),
          );
        },
      );
    }
  }

  num projectWaterComsumptionDaily(List<num> cubicMeters) {
    if (cubicMeters.isEmpty) {
      return 0;
    }
    return cubicMeters.last * 1000;
  }

  num calculateExcessPercentage(
    List<num> dailyShowerTimes,
    num normalShowerTime,
  ) {
    if (dailyShowerTimes.isEmpty) {
      return 0; // Avoid division by zero if the list is empty
    }

    // Count the number of days with excess shower time
    var excessCount = 0;
    for (final showerTime in dailyShowerTimes) {
      if (showerTime > normalShowerTime) {
        excessCount++;
      }
    }

    // Calculate the percentage of days with excess shower time
    final percentageExcess = (excessCount / dailyShowerTimes.length) * 100;

    return percentageExcess;
  }
}

final comsumptionController =
    StateNotifierProvider<ComsumptionController, ComsumptionState>((ref) {
  return ComsumptionController(
    ref.read(getRegisterIotUseCaseProvider),
    ref.read(getUserInfoCurrentSessionUseCaseProvider),
  );
});
