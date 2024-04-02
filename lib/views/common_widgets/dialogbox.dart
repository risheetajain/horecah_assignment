import 'package:flutter/material.dart';
import 'package:horecah_assignment/constant/colors.dart';
import 'package:horecah_assignment/views/common_widgets/custom_button.dart';

class DialogBox {
  static void areYouSureDialog(
      {required BuildContext context, required Function() successOnTap}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: Theme.of(context).colorScheme.onBackground,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
            content: const Text(
              "Are You Sure ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor),
            ),
            actionsAlignment: MainAxisAlignment.center,
            alignment: Alignment.center,
            actions: [
              Column(
                children: [
                  PrimaryButton(
                    isDisabled: false,
                    title: "Confirm",
                    onTap: successOnTap,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SecondaryButton(
                    title: "Go back",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          );
        });
  }
}
