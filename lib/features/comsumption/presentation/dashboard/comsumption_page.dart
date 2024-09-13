import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/presentation/design/atoms/circular_progress.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/features/comsumption/domain/models/register_iot.dart';
import 'package:waterhero/features/comsumption/presentation/dashboard/comsumption_controller.dart';
import 'package:waterhero/features/comsumption/presentation/widgets/alert_section.dart';
import 'package:waterhero/features/comsumption/presentation/widgets/comsumption_chart.dart';
import 'package:waterhero/features/comsumption/presentation/widgets/comsumption_day.dart';
import 'package:waterhero/features/main/widgets/navbar_bottom/navbar_bottom_controller.dart';

class ComsumptionPage extends ConsumerStatefulWidget {
  const ComsumptionPage(this.information, {super.key});
  final Map<dynamic, dynamic> information;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ComsumptionPageState();
}

class _ComsumptionPageState extends ConsumerState<ComsumptionPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, loadData);
    super.initState();
  }

  late List<num> _hours = [];
  late List<num> _consumption = [];
  late bool soonToExcess = false;
  late num _threshold = 100.0;

  Future loadData() async {
    final controller = ref.read(comsumptionController.notifier);
    final state = ref.read(comsumptionController);
    controller.setIsLoading(true);
    await controller.getThreshold();
    _threshold = state.threshold;
    await controller.getRegistersDevice();
    _hours = state.hours;
    _consumption = state.consumption;
    soonToExcess = state.soonToExcess;
    controller.setIsLoading(false);
    final controllerBar = ref.watch(navbarBottomControllerProvider.notifier);
    controllerBar.updateWarning(soonToExcess);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(comsumptionController);
    final controller = ref.read(comsumptionController.notifier);

    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: context.height(.5)),
                  if (state.isLoading) const CircularProgress(),
                  const SizedBox(height: 20),
                  AlertSection(
                    isExceeded: soonToExcess,
                    registerIot: state.consumptionData.isNotEmpty
                        ? state.consumptionData.last
                        : RegisterIot.empty(),
                  ),
                  const SizedBox(height: 10),
                  ComsumptionDay(
                    projectedConsumption: state.waterComsumptionProjection,
                    showerTime: state.percentageShower,
                  ),
                  const SizedBox(height: 10),
                  ConsumptionChart(
                    hours: _hours,
                    consumption: _consumption,
                    threshold: _threshold,
                    currentHour: DateTime.now().day,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
