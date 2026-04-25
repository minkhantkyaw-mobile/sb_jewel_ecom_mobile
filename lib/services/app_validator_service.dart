import 'package:flutter/material.dart';

import 'toast_service.dart';

class AppValidator {
  static FormFieldValidator nameValidator({required BuildContext context}) =>
      (value) {
        if (value.isEmpty) {
          ToastService.errorToast("Please Enter Your Name");
          return "";
        }
        return null;
      };
  static FormFieldValidator emailValidator({required BuildContext context}) =>
      (value) {
        if (value.isEmpty) {
          ToastService.errorToast("Please Enter Your Email");
          return "";
        } else if (!value.toString().contains("@")) {
          ToastService.errorToast("Please Enter Valid Email");
          return "";
        }
        return null;
      };
  static FormFieldValidator passwordValidator(
          {required BuildContext context}) =>
      (value) {
        if (value.isEmpty) {
          ToastService.errorToast("Please Enter Your Password");
          return "";
        } else if (value.length < 6) {
          ToastService.errorToast("Password must be at least 6 characters");
          return "";
        }
        return null;
      };

  static FormFieldValidator confirmPasswordValidator(
          {required BuildContext context, required String password}) =>
      (value) {
        if (value.isEmpty) {
          ToastService.errorToast("Please Enter Your Password");
          return "";
        } else if (value.length < 6) {
          ToastService.errorToast("Password must be at least 6 characters");
          return "";
        } else if (value != password) {
          ToastService.errorToast("Passwords do not match");
          return "";
        }
        return null;
      };
}
