import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waterhero/core/presentation/design/atoms/custom_text.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/core/presentation/utils/icons_paths.dart';
import 'package:waterhero/features/comsumption/presentation/widgets/shower_plot.dart';
import 'package:waterhero/localization/generated/lang.dart';

class ComsumptionDay extends StatelessWidget {
  const ComsumptionDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: context.symetric(.03, .04),
            decoration: BoxDecoration(
              color: colors.white.withOpacity(.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors.black.withOpacity(.4),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      iconsPaths.iconPromotions,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        Lang.of(context).projectedConsumption,
                        fontSize: 11,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        children: [
                          CustomText(
                            '1000000',
                            fontSize: 20,
                            textColor: Colors.white,
                          ),
                          SizedBox(width: 5),
                          CustomText(
                            'Lts',
                            fontSize: 16,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: colors.white.withOpacity(.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: context.symetric(.03, .02),
                  child: Row(
                    children: [
                      CustomText(
                        Lang.of(context).showerTime,
                        fontSize: 12,
                        textColor: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: colors.black.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: CustomText(
                            '+15%',
                            fontSize: 10,
                            textColor: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                  child: ShowerPlot(
                    percent: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
