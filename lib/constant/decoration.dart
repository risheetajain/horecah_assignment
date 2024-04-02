import 'package:flutter/material.dart';
import 'package:horecah_assignment/constant/apptextstyle.dart';
import 'package:horecah_assignment/constant/colors.dart';

InputDecoration inputdecoration(context) => InputDecoration(
    enabledBorder: inputBorder(AppColors.textfieldBorder),
    focusedBorder: inputBorder(AppColors.textfieldBorder),
    disabledBorder: inputBorder(AppColors.textfieldBorder),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.lightGrey)),
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    filled: true,
    hintStyle: AppTextStyle.style14w400.copyWith(color: AppColors.lightGrey),
    labelStyle: AppTextStyle.style14w400.copyWith(color: AppColors.lightGrey),
    fillColor: AppColors.whiteColor);
InputBorder inputBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color));
