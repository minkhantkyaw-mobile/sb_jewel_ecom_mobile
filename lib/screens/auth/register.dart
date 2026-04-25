import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';

import 'package:toastification/toastification.dart';

import '../../controllers/auth_controller.dart';
import '../../core/app_data.dart';
import '../../core/app_widgets/app_button.dart';
import '../../core/app_widgets/app_logo_widget.dart';
import '../../core/app_widgets/my_text_filed.dart';
import '../../core/app_widgets/text_span_button.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../router/route_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthController controller = Get.find<AuthController>();
  bool isChecked = false;
  final picker = ImagePicker();
  File? pickedImgPath;
  XFile? pickedFile;

  Future<void> pickImg() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImgPath = File(pickedFile!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---- Pink Header ----
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 0, 0, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(400, 100),
                      bottomRight: Radius.elliptical(400, 100),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/png/sp_logo.png', // your logo asset
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
                  // ---- Title ----
                  const Text(
                    "Create your new account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Please create account to login",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  const SizedBox(height: 25),

                  // ---- Email ----
                  const Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  MyTextFieldWidget(
                    controller: controller.regNameController,
                    isPasswords: false,
                    inputType: TextInputType.name,
                    hintText: "Enter your name",
                    inputAction: TextInputAction.next,
                    height: Dimesion.height40,
                    prefixIcon: Icons.person,
                  ),

                  // const SizedBox(height: 20),
                  // MyTextFieldWidget(
                  //   controller: controller.regEmailController,
                  //   isPasswords: false,
                  //   inputType: TextInputType.name,
                  //   hintText: "enter your email",
                  //   inputAction: TextInputAction.next,
                  //   height: Dimesion.height40,
                  //   prefixIcon: Icons.email,
                  // ),
                  const SizedBox(height: 20),
                  // ---- Phone ----
                  const Text(
                    "Phone",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  MyTextFieldWidget(
                    controller: controller.regPhoneController,
                    isPasswords: false,
                    inputType: TextInputType.phone,
                    hintText: "Enter your phone",
                    inputAction: TextInputAction.next,
                    height: Dimesion.height40,
                    prefixIcon: Icons.phone,
                  ),

                  const SizedBox(height: 20),

                  // ---- Password ----
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  MyTextFieldWidget(
                    controller: controller.regPasswordController,
                    isPasswords: true,
                    inputType: TextInputType.text,
                    hintText: "********",
                    inputAction: TextInputAction.next,
                    height: Dimesion.height40,
                    prefixIcon: Icons.password,
                  ),

                  const SizedBox(height: 20),

                  // ---- Confirm Password ----
                  const Text(
                    "Confirm Password",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  MyTextFieldWidget(
                    controller: controller.regConfirmPassController,
                    isPasswords: true,
                    inputType: TextInputType.text,
                    hintText: "********",
                    inputAction: TextInputAction.done,
                    height: Dimesion.height40,
                    prefixIcon: Icons.password,
                  ),

                  const SizedBox(height: 15),

                  // ---- Checkbox ----
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() => isChecked = value ?? false);
                        },
                        activeColor: const Color(0xFFA8345E),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "I accept ",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "Terms and conditions and privacy and policy",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () =>
                                              Get.toNamed(RouteHelper.privacy),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ---- Register Button ----
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!isChecked) {
                          Get.snackbar(
                            "Warning",
                            "Please agree to terms and conditions",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }
                        controller.registerUser(context, pickedImgPath);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.myRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ---- Login Footer ----
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(RouteHelper.login),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
