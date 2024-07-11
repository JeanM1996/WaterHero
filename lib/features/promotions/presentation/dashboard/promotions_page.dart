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
    Future.delayed(Duration.zero, getInitData);
    super.initState();
  }

  Future<void> getInitData() async {
    final controller = ref.read(promotionsController.notifier);
    controller.loadContacts();
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.promotions.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: context.symetric(.05, 0),
                            child: Column(
                              children: [
                                Container(
                                  margin: context.symetric(.05, 0),
                                  child: Text(
                                    state.promotions[index].name,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Container(
                                  margin: context.symetric(.05, 0),
                                  child: Text(
                                    state.promotions[index].email,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Container(
                                  margin: context.symetric(.05, 0),
                                  child: Text(
                                    state.promotions[index].phone,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Container(
                                  margin: context.symetric(.05, 0),
                                  child: Text(
                                    state.promotions[index].address,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
