import 'package:flutter/material.dart';
import 'package:horecah_assignment/constant/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.isDisabled,
      required this.title,
      this.onTap,
      this.imagePath,
      this.imageColor});
  final bool isDisabled;
  final String title;
  final void Function()? onTap;
  final String? imagePath;
  final Color? imageColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        height: 45,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
            color:
                isDisabled ? AppColors.disableButton : AppColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (imagePath != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ImageIcon(
                  AssetImage(
                    "assets/$imagePath",
                  ),
                  size: 20,
                  color: imageColor,
                ),
              ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.title, this.onTap});

  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 45,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton({super.key, required this.title, this.onTap});

  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
