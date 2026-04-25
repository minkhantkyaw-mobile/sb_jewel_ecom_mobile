import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../controllers/auth_controller.dart';
import '../../core/app_widgets/app_button.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../services/toast_service.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  late StreamController<ErrorAnimationType> errorController;
  final AuthController controller = Get.find<AuthController>();
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    otpController.text = "";
    // ✅ Fix: make broadcast stream to avoid "Stream has already been listened to" error
    errorController = StreamController<ErrorAnimationType>.broadcast();
  }

  @override
  void dispose() {
    errorController.close();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (builder) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: backButton(),
            backgroundColor: const Color(0xFFD5A5AE), // pink top bar
            centerTitle: true,
            title: Text(
              "Verification",
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimesion.font16,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(Dimesion.radius15),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Dimesion.height30),

                // Image
                Image.asset(
                  "assets/img/vefy.png",
                  height: Dimesion.screenHeight / 3.5,
                ),
                SizedBox(height: Dimesion.height20),

                // Title
                Text(
                  "Verification",
                  style: TextStyle(
                    fontSize: Dimesion.font18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: Dimesion.height10),

                // Subtitle
                Text(
                  "Sent OTP code to your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Dimesion.font14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: Dimesion.height30),

                // OTP input
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  animationType: AnimationType.fade,
                  controller: otpController,
                  cursorColor: AppColor.myRed,
                  keyboardType: TextInputType.number,
                  errorAnimationController: errorController,
                  obscureText: false,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 55,
                    fieldWidth: 50,
                    activeColor: AppColor.myRed,
                    inactiveColor: Colors.pink.shade200,
                    selectedColor: AppColor.myRed,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  onCompleted: (v) {
                    if (otpController.text.isNotEmpty &&
                        otpController.text.length == 4) {
                      builder.verify_forgotPassword(
                        email: builder.forgotEmailController.text,
                        code: otpController.text,
                      );
                    } else {
                      errorController.add(ErrorAnimationType.shake);
                      ToastService.errorToast("Enter OTP Code");
                    }
                    // Get.offNamed(RouteHelper.updatePass);
                  },
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
                SizedBox(height: Dimesion.height30),

                // Continue Button
                AppButtonWidget(
                  title: Text(
                    "Continue",
                    style: context.bodyLarge!.copyWith(color: Colors.white),
                  ),
                  onTap: () {
                    if (otpController.text.isNotEmpty &&
                        otpController.text.length == 4) {
                      builder.verify_forgotPassword(
                        email: builder.forgotEmailController.text,
                        code: otpController.text,
                      );
                    } else {
                      errorController.add(ErrorAnimationType.shake);
                      ToastService.errorToast("Enter OTP Code");
                    }
                  },
                  color: AppColor.myRed,
                  minWidth: double.infinity,
                ),
                SizedBox(height: Dimesion.height20),

                // Resend Code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Did not receive the code?",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: Dimesion.font14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.forgotPassword(
                          email: controller.forgotEmailController.text,
                        );
                      },
                      child: Text(
                        "RESEND",
                        style: TextStyle(
                          color: AppColor.myRed,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimesion.font14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimesion.height20),
              ],
            ),
          ),
        );
      },
    );
  }
}
