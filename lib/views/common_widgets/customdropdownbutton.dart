import 'package:flutter/material.dart';
import 'package:horecah_assignment/constant/decoration.dart';

import '../../constant/colors.dart';

class CustomDropdownwithTitle extends StatelessWidget {
  const CustomDropdownwithTitle(
      {super.key, required this.items, this.onChanged, required this.title});
  final List<String> items;
  final void Function(String?)? onChanged;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: title.isNotEmpty ? title : '',
          ),
          style: const TextStyle(
            color: AppColors.lightGrey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField(
          onChanged: onChanged,
          
          items: List.generate(
              items.length,
              (index) => DropdownMenuItem(
                  value: items[index], child: Text(items[index].toString()))),

          //  items.map((e) {
          //   print(e);
          //   return ;
          // }).toList(),
          decoration: inputdecoration(context),
        ),
      ],
    );
  }
}
