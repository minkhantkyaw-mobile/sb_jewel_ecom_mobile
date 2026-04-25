import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spjewellery/router/route_helper.dart';

import '../../controllers/auth_controller.dart';
import '../../core/app_widgets/app_button.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/my_cache_img.dart';
import '../../core/app_widgets/my_text_filed.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../services/app_validator_service.dart';
import '../../services/toast_service.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UpdateProfilePage extends StatefulWidget {
  final AuthController authController;
  const UpdateProfilePage({super.key, required this.authController});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? pickedImgPath;
  XFile? pickedFile;
  final picker = ImagePicker();

  Future<void> pickImg() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImgPath = File(pickedFile!.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.authController.userData.value.name ?? '';
    phoneController.text = widget.authController.userData.value.phone ?? '';
    emailController.text = widget.authController.userData.value.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.authController.userData.value;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryClr,
        title: Text(
          "Edit Profile".tr,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        pickedImgPath != null
                            ? FileImage(pickedImgPath!)
                            : (user.image == null ||
                                user.image == "null" ||
                                user.image!.isEmpty)
                            ? const AssetImage("assets/img/d_pic.png")
                            : CachedNetworkImageProvider(user.image!)
                                as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    child: InkWell(
                      onTap: pickImg,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColor.primaryClr,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),

            // Name
            const Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            _buildEditableField(nameController, "Hellen", Icons.person),
            const SizedBox(height: 20),

            // Email
            const Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            _buildEditableField(
              emailController,
              "Hellen2@gmail.com",
              Icons.email,
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Phone
            const Text(
              "Phone Number",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            _buildEditableField(
              phoneController,
              "-",
              Icons.phone,
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: 25),

            // Change password
            InkWell(
              onTap: () {
                Get.toNamed(RouteHelper.changePass);
                // TODO: Navigate to Change Password
              },
              child: Text(
                "change_password".tr,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Update button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty &&
                      emailController.text.isNotEmpty) {
                    widget.authController.updateProfile(
                      phone: phoneController.text,
                      name: nameController.text,
                      email: emailController.text,
                      img: pickedImgPath,
                    );
                  } else {
                    ToastService.errorToast("Please fill all fields");
                    // Get.toNamed(RouteHelper.changePass);
                  }
                },
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          suffixText: "edit",
          suffixStyle: const TextStyle(color: Colors.grey),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
        ),
      ),
    );
  }
}
