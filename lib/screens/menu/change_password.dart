import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:spjewellery/router/route_helper.dart';

import '../../controllers/auth_controller.dart';
import '../../core/app_widgets/app_button.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/my_text_filed.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../services/app_validator_service.dart';
import '../../services/toast_service.dart';

class ChangePasswordPage extends GetView<AuthController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFFD9A1AA),
        title: const Text(
          "Change Password",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile avatar
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage("assets/img/d_pic.png"),
                    backgroundColor: Colors.white,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColor.pink,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Old Password
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Old Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            _buildPasswordField(controller.oldPasswordController),

            const SizedBox(height: 20),

            // New Password
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "New Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            _buildPasswordField(controller.newPasswordController),

            const SizedBox(height: 20),

            // Confirm Password
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirm Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            _buildPasswordField(controller.newConfirmPasswordController),

            const SizedBox(height: 40),

            // Change button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.myRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // if (controller.oldPasswordController.text.isNotEmpty &&
                  //     controller.newPasswordController.text.isNotEmpty &&
                  //     controller.newConfirmPasswordController.text.isNotEmpty) {
                  //   controller.changePassword(
                  //     oldPassword: controller.oldPasswordController.text,
                  //     newPassword: controller.newPasswordController.text,
                  //     confirmPassword: controller.newConfirmPasswordController.text,
                  //   );
                  // } else {
                  //   ToastService.errorToast("Please fill all fields");
                  // }

                  Get.toNamed(RouteHelper.nav);
                },
                child: const Text(
                  "Change",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Password field widget with show/hide toggle
  Widget _buildPasswordField(TextEditingController controller) {
    final RxBool obscureText = true.obs;
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText.value,
          decoration: InputDecoration(
            hintText: "********",
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 14,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText.value ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () => obscureText.value = !obscureText.value,
            ),
          ),
        ),
      ),
    );
  }
}
