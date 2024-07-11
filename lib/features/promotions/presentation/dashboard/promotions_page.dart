import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/presentation/design/atoms/circular_progress.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/features/promotions/presentation/dashboard/promotions_controller.dart';

class PromotionsPage extends ConsumerStatefulWidget {
  const PromotionsPage(this.information, {super.key});
  final Map<dynamic, dynamic> information;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends ConsumerState<PromotionsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(promotionsController);
    final controller = ref.read(promotionsController.notifier);
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
