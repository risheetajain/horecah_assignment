import 'package:flutter/material.dart';
import 'package:horecah_assignment/constant/colors.dart';

PreferredSize customAppbar(String title) => PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight * 2),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: AppColors.primaryColor, boxShadow: [
        BoxShadow(
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 4),
            color: AppColors.primaryColor.withOpacity(0.3))
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Image.asset("assets/app_icon.png"),
          const SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor),
          )
        ],
      ),
    ));
