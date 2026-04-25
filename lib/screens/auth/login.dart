import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:toastification/toastification.dart';
import '../../controllers/auth_controller.dart';
import '../../core/app_widgets/app_button.dart';
import '../../core/app_widgets/app_logo_widget.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/my_text_filed.dart';
import '../../core/app_widgets/text_span_button.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../router/route_helper.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: controller.loginFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ---- Pink Oval Header ----
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColor.bottomBgColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(400, 100),
                        bottomRight: Radius.elliptical(400, 100),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/png/sp_logo.png', // your logo image path
                        height: 150,
                        width: 150,
                      ),
                      const SizedBox(height: 5),
                      // const Text(
                      //   "MPP CLOTHING",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w500,
                      //     letterSpacing: 1.2,
                      //     color: Colors.black87,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimesion.width20,
                  vertical: Dimesion.height20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---- Welcome text ----
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Please log in to continue",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // ---- Email or Phone ----
                    const Text(
                      "Phone",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    MyTextFieldWidget(
                      controller: controller.loginphoneController,
                      isPasswords: false,
                      inputType: TextInputType.phone,
                      hintText: "Enter your phone",
                      inputAction: TextInputAction.next,
                      height: Dimesion.height40,
                      prefixIcon: Icons.label,
                    ),

                    const SizedBox(height: 20),

                    // ---- Password ----
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    MyTextFieldWidget(
                      controller: controller.loginPasswordController,
                      isPasswords: true,
                      inputType: TextInputType.text,
                      hintText: "********",
                      inputAction: TextInputAction.done,
                      height: Dimesion.height40,
                      prefixIcon: Icons.lock,
                    ),

                    const SizedBox(height: 10),

                    // ---- Remember me + Forgot password ----
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Obx(() => Checkbox(
                            //       value: controller.rememberMe.value,
                            //       onChanged: (val) =>
                            //           controller.rememberMe.value =
                            //               val ?? false,
                            //       activeColor: const Color(0xFFA8345E),
                            //     )),
                            const SizedBox(width: 5),
                            const Text(
                              "Remember me",
                              style: TextStyle(color: Colors.black87),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(RouteHelper.contact_us),
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ---- Login Button ----
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.loginphoneController.text.isNotEmpty &&
                              controller
                                  .loginPasswordController
                                  .text
                                  .isNotEmpty) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (controller.loginFormKey.currentState!
                                .validate()) {
                              controller.login(context: context);
                            }
                          } else {
                            Get.snackbar(
                              "Warning",
                              "Please fill Phone and Password",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }

                          // Get.toNamed(RouteHelper.nav);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.myRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ---- Register ----
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            "Haven’t create your account? ",
                            style: TextStyle(color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(RouteHelper.register),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ... inside the Column, after the Register Wrap widget
                    const SizedBox(height: 20),

// ---- Divider ----
                    const Row(
                      children: [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("OR", style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),

                    const SizedBox(height: 20),

// ---- Guest Mode Button ----
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Call the guest login logic
                          Get.offNamed(RouteHelper.nav);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey.shade700,
                        ),
                        child: const Text(
                          "Continue as Guest",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
