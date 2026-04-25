import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spjewellery/screens/chat_screen/color_constants.dart';
import 'package:timer_snackbar/timer_snackbar.dart';

import '../../controllers/auth_controller.dart';
import '../../core/app_widgets/app_button.dart';
import '../../core/app_widgets/my_cache_img.dart';
import '../../core/app_widgets/my_toggle.dart';
import '../../core/app_widgets/no_login_widget.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../router/route_helper.dart';
import '../auth/profile_update.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.primaryRed,
          centerTitle: true,
          title: Text(
            "Profile",
            style: GoogleFonts.outfit(
              color: AppColor.white,
              fontWeight: FontWeight.bold,
              fontSize: Dimesion.font16 + 2,
            ),
          ),
        ),
        body:
            controller.appToken.isEmpty
                ? InkWell(
              onTap: () => Get.toNamed(RouteHelper.login),
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: Container(

                  height: 150,
                  width: double.infinity, // or a specific width
                  alignment: Alignment.center,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Larger, soft-colored icon background
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.login_rounded, color: Colors.blue[700], size: 32),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Sign in to continue",
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),

                    ],
                  ),
                ),
              ),
            )
                : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Image
                        Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.grey[200],
                                backgroundImage:
                                    controller.userData.value.image == null ||
                                            controller.userData.value.image ==
                                                "null"
                                        ? const AssetImage(
                                          "assets/img/d_pic.png",
                                        )
                                        : NetworkImage(
                                              controller.userData.value.image
                                                  .toString(),
                                            )
                                            as ImageProvider,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                controller.userData.value.name ?? "User",
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Account Settings".tr,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Menu List
                        _buildSettingTile(
                          icon: Icons.person_outline,
                          title: "profile".tr,
                          onTap: () {
                            Get.toNamed(
                              RouteHelper.profileUpdate,
                              arguments: UpdateProfilePage(
                                authController: controller,
                              ),
                            );
                          },
                        ),
                        _buildSettingTile(
                          icon: Icons.history,
                          title: "order_history".tr,
                          onTap: () => Get.toNamed(RouteHelper.orderhistory),
                        ),
                        _buildSettingTile(
                          icon: Icons.favorite_border,
                          title: "wishlist".tr,
                          onTap: () => Get.toNamed(RouteHelper.fav),
                        ),
                        _buildSettingTile(
                          icon: Icons.contact_support_outlined,
                          title: "contact_us".tr,
                          onTap: () => Get.toNamed(RouteHelper.contact_us),
                        ),
                        _buildSettingTile(
                          icon: Icons.privacy_tip_outlined,
                          title: "privacy_policy".tr,
                          onTap: () => Get.toNamed(RouteHelper.privacy),
                        ),
                        _buildSettingTile(
                          icon: Icons.delete_outline,
                          title: "delete_account".tr,
                          onTap: () {
                            Get.defaultDialog(
                              title: "Delete Account",
                              middleText:
                                  "Are you sure you want to delete your account?",
                              confirm: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                  controller.deleteAccount();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                                child: const Text("Yes, Delete"),
                              ),
                              cancel: TextButton(
                                onPressed: () => Get.back(),
                                child: const Text("Cancel"),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),

                        // Language
                        Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(color: AppColor.bgColor),
                            child: Row(
                              children: [
                                Flexible(
                                  child: ListTile(
                                    leading: Container(
                                      height: Dimesion.height20 * 2,
                                      padding: EdgeInsets.only(
                                        right: Dimesion.height10 + 2,
                                      ),
                                      child: Image.asset(
                                        "assets/img/global.png",
                                        width: Dimesion.iconSize25,
                                        height: Dimesion.iconSize25,
                                        color: AppColor.primaryClr,
                                      ),
                                    ),
                                    title: Text(
                                      "language".tr.tr,
                                      style: TextStyle(
                                        color: AppColor.black,
                                        fontSize: Dimesion.font16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                CupertinoSlidingSegmentedControl(
                                  groupValue: controller.slideTab.value,
                                  thumbColor: AppColor.white,
                                  backgroundColor: AppColor.primaryClr,
                                  children: {
                                    0: Text(
                                      'ENG',
                                      style: TextStyle(
                                        color:
                                            controller.slideTab.value == 0
                                                ? AppColor.black
                                                : AppColor.white,
                                      ),
                                    ),
                                    1: Text(
                                      'MYN',
                                      style: TextStyle(
                                        color:
                                            controller.slideTab.value == 1
                                                ? AppColor.black
                                                : AppColor.white,
                                      ),
                                    ),
                                  },
                                  onValueChanged: controller.onChangeSlide,
                                ),
                                Gap(Dimesion.width15),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Logout Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Get.toNamed(RouteHelper.login);
                              controller.logout();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryClr,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "logout".tr,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.white,
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColor.primaryClr),
        title: Text(
          title,
          style: GoogleFonts.outfit(fontSize: 15, color: Colors.black),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
