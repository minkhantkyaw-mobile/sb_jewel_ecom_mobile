import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../core/app_widgets/back_button.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../controllers/contact_controller.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ContactController controller = Get.put(ContactController());

  Future<void> _makePhoneCall(String phone) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phone);
    await launchUrl(launchUri);
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Inquiry from App',
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchURL(String url) async {
    final Uri launchUri = Uri.parse(url);
    await launchUrl(launchUri, mode: LaunchMode.externalApplication);
  }

  @override
  void initState() {
    super.initState();
    controller.fetchContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryClr,
        title: Text("Contact Us", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final contact = controller.contact.value;
        if (contact == null) {
          return const Center(child: Text("No contact information available."));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              // ------------------ MAP IMAGE ------------------
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(8),
              //   child: Image.asset(
              //     'assets/img/location.png',
              //     height: 200,
              //     width: double.infinity,
              //     fit: BoxFit.cover,
              //   ),
              // ),

              SizedBox(height: 20),

              // ------------------ ADDRESS ------------------
              Text(
                contact.address ?? "No address available",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),

              // ------------------ PHONE ------------------
              Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    if (controller.numberList.isNotEmpty) {
                      _makePhoneCall(controller.numberList.first);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, size: 20),
                      SizedBox(width: 10),
                      Text(
                        controller.numberList.isEmpty
                            ? "No phone available"
                            : controller.numberList.join(" , "),
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12),

              // ------------------ EMAIL ------------------
              Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    if (contact.email != null) {
                      _sendEmail(contact.email!);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email_outlined, size: 20),
                      SizedBox(width: 10),
                      Text(
                        contact.email ?? "No email",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // ------------------ SOCIAL MEDIA ------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (contact.telegramUrl != null)
                    _socialButton(
                      icon: FontAwesomeIcons.telegram,
                      color: Colors.blue,
                      onTap: () => _launchURL(contact.telegramUrl!),
                    ),
                  SizedBox(width: 24),

                  if (contact.viberUrl != null)
                    _socialButton(
                      icon: FontAwesomeIcons.viber,
                      color: Colors.purple,
                      onTap: () => _launchURL(contact.viberUrl!),
                    ),
                  SizedBox(width: 24),

                  if (contact.facebookUrl != null)
                    _socialButton(
                      icon: FontAwesomeIcons.facebookF,
                      color: Colors.blue,
                      onTap: () => _launchURL(contact.facebookUrl!),
                    ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 26,
        backgroundColor: Colors.white,
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
