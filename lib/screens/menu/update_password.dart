import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:spjewellery/services/toast_service.dart';

import '../../controllers/auth_controller.dart';
import '../../core/app_widgets/app_button.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/my_text_filed.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../services/app_validator_service.dart';

class UpdatePasswordPage extends GetView<AuthController> {
  const UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: backButton(),
        backgroundColor: const Color(
          0xFFD5A5AE,
        ), // pink header like your design
        centerTitle: true,
        title: Text(
          "New Password",
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

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimesion.width20,
          vertical: Dimesion.height30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Set New Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimesion.font16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: Dimesion.height10),

            // Description
            Text(
              "Please enter the new password contains at least 8 characters and 1 digit",
              style: TextStyle(
                fontSize: Dimesion.font14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: Dimesion.height30),

            // New Password Field
            MyTextFieldWidget(
              hintText: "New Password",
              controller: controller.passwordController,
              isPasswords: true,
              hideIcon: true,
              prefixIcon: Icons.lock_outline,
              inputType: TextInputType.text,
              inputAction: TextInputAction.done,
              fieldValidator: AppValidator.passwordValidator(context: context),
              height: Dimesion.height40,
            ),
            const Spacer(),

            // Done Button
            AppButtonWidget(
              color: AppColor.myRed,
              minWidth: double.infinity,
              height: Dimesion.height40,
              title: Text(
                "Done",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
              onTap: () {
                if (controller.passwordController.text.isEmpty) {
                  ToastService.errorToast("Please enter a new password");
                } else if (controller.passwordController.text.length < 8) {
                  ToastService.errorToast(
                    "Password must be at least 8 characters long",
                  );
                } else {
                  controller.update_password(
                    email: controller.forgotEmailController.text,
                    password: controller.passwordController.text,
                    confirm_password: controller.passwordController.text,
                  );
                }
                // Get.offNamed(RouteHelper.nav);
              },
            ),
          ],
        ),
      ),
    );
  }
}
