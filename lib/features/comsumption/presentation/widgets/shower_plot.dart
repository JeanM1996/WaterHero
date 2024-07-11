import 'dart:async';

import 'package:flutter/widgets.dart';

class ShowerPlot extends StatefulWidget {
  const ShowerPlot({required this.percent, super.key});
  final int percent;

  @override
  State<ShowerPlot> createState() => _ShowerPlotState();
}

class _ShowerPlotState extends State<ShowerPlot> with TickerProviderStateMixin {
  late final AnimationController firstController;
  late final Animation<double> firstAnimation;

  late final AnimationController secondController;
  late final Animation<double> secondAnimation;

  late final AnimationController thirdController;
  late final Animation<double> thirdAnimation;

  late final AnimationController fourthController;
  late final Animation<double> fourthAnimation;

  @override
  void initState() {
    super.initState();

    firstController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
      CurvedAnimation(parent: firstController, curve: Curves.easeInOut),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          firstController.forward();
        }
      });

    secondController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
      CurvedAnimation(parent: secondController, curve: Curves.easeInOut),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController.forward();
        }
      });

    thirdController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
      CurvedAnimation(parent: thirdController, curve: Curves.easeInOut),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController.forward();
        }
      });

    fourthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
      CurvedAnimation(parent: fourthController, curve: Curves.easeInOut),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController.forward();
        }
      });

    Timer(const Duration(seconds: 2), () {
      firstController.forward();
    });

    Timer(const Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(const Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomPaint(
      painter: MyPainter(
        firstAnimation.value,
        secondAnimation.value,
        thirdAnimation.value,
        fourthAnimation.value,
        widget.percent,
      ),
      child: SizedBox(
        height: size.height,
        width: size.width,
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.fourthValue,
    this.percent,
  );
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;
  final int percent;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 139, 141, 145).withOpacity(.8)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * (1 - percent / 100) / firstValue)
      ..cubicTo(
        size.width / 4,
        size.height * (1 - percent / 100) / fourthValue,
        size.width / 2,
        size.height * (1 - percent / 100) / secondValue,
        size.width,
        size.height * (1 - percent / 100) / fourthValue,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
