import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/presentation/design/atoms/circular_progress.dart';
import 'package:waterhero/core/presentation/design/atoms/custom_text.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/features/tips/presentation/dashboard/tips_controller.dart';
import 'package:waterhero/localization/generated/lang.dart';

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
                      child: Column(
                        children: [
                          CustomText(
                            Lang.of(context).helpAndFollowTheAdvices,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            textColor: colors.white,
                          ),
                          CustomText(
                            Lang.of(context).togetherWeCanSave,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            textColor: colors.white.withOpacity(.5),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.tips.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: context.symetric(.05, .025),
                                decoration: BoxDecoration(
                                  color: colors.whiteBereus.withOpacity(.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: context.symetric(.05, 0),
                                        child: Image.network(
                                          state.tips[index].imageUrl,
                                          height: context.height(.2),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: context.symetric(.05, 0),
                                            child: CustomText(
                                              state.tips[index].title,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              textColor: colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: context.height(.01),
                                          ),
                                          Container(
                                            margin: context.symetric(.05, 0),
                                            child: CustomText(
                                              state.tips[index].description,
                                              fontWeight: FontWeight.w400,
                                              textColor:
                                                  colors.white.withOpacity(.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
