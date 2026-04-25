import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../constants/app_color.dart';

Widget textSpanButton(
        {required String firstText,
        required String buttonText,
        required void Function() ontap,
        required BuildContext context}) =>
    /*Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: " $firstText ", style: Theme.of(context).textTheme.bodyMedium),

        TextSpan(
          text: " $buttonText ",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(decoration: TextDecoration.underline,
              color: AppColor.primaryClr, fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()..onTap = ontap,
        )
      ])),
    );*/
    Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(" $firstText ".tr,style: Theme.of(context).textTheme.bodyMedium),
          InkWell(
            onTap: (){
            },
            child: Container(
              padding: EdgeInsets.only(
                bottom: 1, // Space between underline and text
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                    color: AppColor.primaryClr,
                    width: 1.0, // Underline thickness
                  ))
              ),
              child: Text(" $buttonText ".tr,
                style: TextStyle(
                  color: AppColor.primaryClr,
                ),
              ),
            ),
          )
        ],
      ),
    );
