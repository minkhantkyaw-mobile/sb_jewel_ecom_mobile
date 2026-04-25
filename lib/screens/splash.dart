import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:spjewellery/controllers/auth_controller.dart';
import 'package:spjewellery/controllers/product_controller.dart';
import 'package:spjewellery/screens/advertisement_page.dart';

import '../core/constants/app_color.dart';
import '../router/route_helper.dart';
import '../services/push_notification_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  ProductController productController = Get.find<ProductController>();
  AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();

    init();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _rotationAnimation = Tween<double>(
      begin: -0.01,
      end: 0.01,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  Future<void> init() async {
    final bool isConnected =
        await InternetConnectionChecker.createInstance().hasConnection;
    if (isConnected) {
      await PushNotificationHelper.initialized();
      if (authController.appToken.isEmpty) {
        Get.offNamed(RouteHelper.login);
      } else {
        productController.getAdvertisement().then((value) {
          Get.offNamed(
            RouteHelper.advertisement,
            arguments: AdvertisementScreen(images: value),
          );
        });
      }
    } else {
      Get.offNamed(RouteHelper.noInternet);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                RotationTransition(
                  turns: _controller,
                  child: SizedBox(
                    height: 160,
                    width: 160,
                    child: CustomPaint(painter: CircularBorderPainter()),
                  ),
                ),
                ClipOval(
                  child: Image.asset(
                    'assets/img/logo.png',
                    height: 140,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const Gap(20),
            RotationTransition(
              turns: _rotationAnimation,
              child: Text(
                'SoFresh Clothing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColor.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = AppColor.primaryClr
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final double startAngle = 0;
    final double sweepAngle = 3.14 * 1.5;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width / 2) - 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
