import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/presentation/design/atoms/circular_progress.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/features/tips/presentation/dashboard/tips_controller.dart';

class TipsPage extends ConsumerStatefulWidget {
  const TipsPage(this.information, {super.key});
  final Map<dynamic, dynamic> information;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TipsPageState();
}

class _TipsPageState extends ConsumerState<TipsPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, getInitData);
    super.initState();
  }

  Future<void> getInitData() async {
    final controller = ref.read(tipsControllerProvider.notifier);
    controller.loadTips();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tipsControllerProvider);
    final controller = ref.read(tipsControllerProvider.notifier);
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
                        itemCount: state.tips.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: context.symetric(.05, 0),
                            child: Column(
                              children: [
                                Container(
                                  margin: context.symetric(.05, 0),
                                  child: Image.network(
                                    state.tips[index].imageUrl,
                                    height: context.height(.2),
                                  ),
                                ),
                                Container(
                                  margin: context.symetric(.05, 0),
                                  child: Text(
                                    state.tips[index].title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Container(
                                  margin: context.symetric(.05, 0),
                                  child: Text(
                                    state.tips[index].description,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
