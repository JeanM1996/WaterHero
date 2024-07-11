import 'package:flutter/material.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/localization/generated/lang.dart';

class ConsumptionChart extends StatelessWidget {
  const ConsumptionChart({
    required this.hours,
    required this.consumption,
    required this.threshold,
    required this.currentHour,
    super.key,
  });
  final List<int> hours;
  final List<int> consumption;
  final int threshold;
  final int currentHour;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.symetric(.03, .04),
      decoration: BoxDecoration(
        color: colors.white.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            Lang.of(context).dailyConsumption,
            textColor: colors.white,
          ),
          CustomPaint(
            size: const Size(
              double.infinity,
              120,
            ), // Increased height to accommodate labels
            painter: ConsumptionChartPainter(
              hours,
              consumption,
              threshold,
              currentHour,
            ),
          ),
        ],
      ),
    );
  }
}

class ConsumptionChartPainter extends CustomPainter {
  ConsumptionChartPainter(
    this.hours,
    this.consumption,
    this.threshold,
    this.currentHour,
  );
  final List<int> hours;
  final List<int> consumption;
  final int threshold;
  final int currentHour;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final barWidth = size.width / hours.length;
    final maxConsumption = consumption.reduce((a, b) => a > b ? a : b);
    final borderRadius = BorderRadius.circular(10);

    for (var i = 0; i < hours.length; i++) {
      final barHeight = (consumption[i] / maxConsumption) *
          (size.height - 30); // Adjusted height
      final barColor = hours[i] == currentHour
          ? (consumption[i] > threshold ? Colors.red : Colors.blue)
          : Colors.grey.withOpacity(0.5);

      paint.color = barColor;

      final rrect = RRect.fromRectAndCorners(
        Rect.fromLTWH(
          i * barWidth,
          size.height - barHeight - 30,
          barWidth - 4,
          barHeight,
        ),
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      );

      canvas.drawRRect(rrect, paint);

      // Draw hour labels
      final textSpan = TextSpan(
        text: '${hours[i]}',
        style: TextStyle(color: Colors.white.withOpacity(.5), fontSize: 12),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(
        maxWidth: barWidth,
      );

      final offset = Offset(
        i * barWidth + (barWidth - textPainter.width) / 2,
        size.height - 20,
      );

      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
