import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waterhero/core/presentation/design/atoms/custom_text.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/core/presentation/utils/date_extension.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/core/presentation/utils/icons_paths.dart';
import 'package:waterhero/features/comsumption/domain/models/register_iot.dart';
import 'package:waterhero/localization/generated/lang.dart';

class AlertSection extends StatelessWidget {
  const AlertSection({
    required this.registerIot,
    super.key,
    this.isExceeded = false,
  });
  final bool isExceeded;
  final RegisterIot registerIot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.symetric(.05, .05),
      decoration: BoxDecoration(
        color: isExceeded
            ? colors.error.withOpacity(.4)
            : Colors.blue.withOpacity(.4),
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
              child: isExceeded
                  ? SvgPicture.asset(
                      iconsPaths.iconWarning,
                      width: 20,
                      height: 20,
                    )
                  : const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  isExceeded
                      ? Lang.of(context).exceedExpectedConsumption
                      : Lang.of(context).youAreSavingWater,
                  fontSize: 12,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 5),
                CustomText(
                  isExceeded
                      ? Lang.of(context).exceedExpectedConsumptionMessage
                      : Lang.of(context).youAreSavingWaterMessage,
                  fontSize: 16,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 10),
                CustomText(
                  '${Lang.of(context).lastRegisterOf}: ${registerIot.body.cubicmeters} ${Lang.of(context).cubicMeters} '
                  '${Lang.of(context).at} ${DateTime.fromMillisecondsSinceEpoch(
                    registerIot.when.toInt() * 1000,
                  ).toFormattedDateTime()}',
                  fontSize: 12,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
