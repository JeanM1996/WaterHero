import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/presentation/design/atoms/circular_progress.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/features/comsumption/presentation/dashboard/comsumption_controller.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(comsumptionController);
    final controller = ref.read(comsumptionController.notifier);
    return Flexible(
      fit: FlexFit.tight,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: state.isLoading
                ? const CircularProgress()
                : SafeArea(
                    child: Container(
                      padding: context.symetric(0, .05),
                      margin: context.symetric(.05, 0),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
