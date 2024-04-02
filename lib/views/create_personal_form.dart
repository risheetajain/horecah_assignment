import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horecah_assignment/create_with_ai_form.dart';
import 'package:horecah_assignment/views/common_widgets/custom_appbar.dart';
import 'package:horecah_assignment/views/common_widgets/custom_button.dart';
import 'package:horecah_assignment/views/common_widgets/custom_text_field.dart';
import 'package:horecah_assignment/views/common_widgets/customdropdownbutton.dart';

import '../constant/gaps_box.dart';

class CreatePersonalForm extends StatefulWidget {
  const CreatePersonalForm({super.key});

  @override
  State<CreatePersonalForm> createState() => _CreatePersonalFormState();
}

class _CreatePersonalFormState extends State<CreatePersonalForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? selectedCity;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Form 1"),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              CustomTextFieldWithTitle(
                title: "Name",
                hintText: "Name",
                controller: nameController,
                keyboardType: TextInputType.name,
                validator: (p0) {
                  if (p0 == null && p0!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              gapV20,
              CustomTextFieldWithTitle(
                title: "Mobile",
                hintText: "9876543210",
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: phoneController,
                validator: (p0) {
                  if (p0 == null && p0!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              gapV20,
              CustomTextFieldWithTitle(
                title: "Email",
                controller: emailController,
                hintText: "yourmain@gmail.com",
                validator: (p0) {
                  if (p0 == null && p0!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              gapV20,
              CustomDropdownwithTitle(
                  items: const ["Chennai", "Rajasthan", "MP", "Maharastra"],
                  onChanged: (val) {
                    setState(() {
                      selectedCity = val;
                    });
                  },
                  title: "City")
            ],
          ),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 30),
        child: PrimaryButton(
            onTap: () {
              if (selectedCity == null) {
                Fluttertoast.showToast(msg: "Please select atleast city");
                return;
              }

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateWIthAIForm(
                        myData: {
                          "name": nameController.text,
                          "phone": phoneController.text,
                          "email": emailController.text,
                          "city": selectedCity
                        },
                      )));
            },
            isDisabled: nameController.text.isEmpty &&
                phoneController.text.isEmpty &&
                emailController.text.isEmpty &&
                selectedCity == null,
            title: "Next"),
      ),
    );
  }
}
