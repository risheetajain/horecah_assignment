import 'package:flutter/material.dart';
import 'package:horecah_assignment/constant/apptextstyle.dart';

import 'common_widgets/custom_appbar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.myData});
  final Map<String, dynamic> myData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Profile"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              dataCard(title: "Name", value: myData["name"]),
              dataCard(title: "Mobile Number", value: myData["phone"]),
              dataCard(title: "Email", value: myData["email"]),
              dataCard(title: "Selected City", value: myData["city"]),
              dataCard(title: "About", value: myData["about"]),
              dataCard(title: "Portfolio Link", value: myData["portfolio"]),
              dataCard(
                  title: "Languages", value: myData["languages"].join(", ")),
            ],
          ),
        ),
      ),
    );
  }

  Widget dataCard({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.style14w400,
        ),
        Text(
          value,
          style: AppTextStyle.style14w400,
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
