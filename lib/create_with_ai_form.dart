import 'package:flutter/material.dart';
import 'package:horecah_assignment/constant/colors.dart';
import 'package:horecah_assignment/views/common_widgets/custom_appbar.dart';
import 'package:horecah_assignment/views/common_widgets/custom_button.dart';
import 'package:horecah_assignment/views/common_widgets/custom_text_field.dart';
import 'package:horecah_assignment/views/common_widgets/dialogbox.dart';
import 'package:horecah_assignment/views/common_widgets/multidropdown.dart';
import 'package:horecah_assignment/views/view_form.dart';

import '../constant/gaps_box.dart';

class CreateWIthAIForm extends StatefulWidget {
  const CreateWIthAIForm({super.key, required this.myData});
  final Map<String, dynamic> myData;

  @override
  State<CreateWIthAIForm> createState() => _CreateWIthAIFormState();
}

class _CreateWIthAIFormState extends State<CreateWIthAIForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> selectedLanguages = [];
  TextEditingController linkController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  bool _buttonEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Form 2"),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          onChanged: () {
            setState(() {
              _buttonEnabled = selectedLanguages.isEmpty &&
                  linkController.text.isEmpty &&
                  aboutController.text.isEmpty;
            });
          },
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              CustomTextFieldWithTitle(
                title: "About",
                minLines: 2,
                maxLines: 6,
                maxLength: 600,
                isShowCounterText: true,
                controller: aboutController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: "Use Previous form data as a prompt to write with AI",
                keyboardType: TextInputType.name,
                validator: (p0) {
                  if (p0 == null && p0!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              gapV20,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: PrimaryButton(
                        isDisabled: false,
                        imagePath: "sparkle.png",
                        imageColor: AppColors.orangeColor,
                        title: "Write With AI"),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(child: MyOutlinedButton(title: "Type"))
                ],
              ),
              gapV20,
              CustomTextFieldWithTitle(
                title: "Portfolio Link",
                hintText: "example.com",
                controller: linkController,
                keyboardType: TextInputType.url,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (p0) {
                  if (p0 == null && p0!.isEmpty) {
                    return "Please enter your url";
                  }
                  return null;
                },
                titleSuffixIcon: const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.lightGrey,
                  size: 20,
                ),
              ),
              gapV20,
              MultipleDropdown(
                maxSelection: 6,

                // onUpdateSelectedItems: (p0) {},
                items: const [
                  'Arabic',
                  'Hindi',
                  "English",
                  'Marathi',
                  "Gujarati",
                  "French",
                  "German"
                ],
                labelText: "Languages",
                onChanged: (val) {
                  selectedLanguages = val;
                },
                selectedList: selectedLanguages,
              )
            ],
          ),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: PrimaryButton(
                  onTap: () {
                    Map<String, dynamic> myData = {
                      "languages": selectedLanguages,
                      "portfolio": linkController.text,
                      "about": aboutController.text
                    };

                    myData.addAll(widget.myData);
                    print(widget.myData);
                    DialogBox.areYouSureDialog(
                        context: context,
                        successOnTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileView(
                                    myData: myData,
                                  )));
                        });
                  },
                  isDisabled: _buttonEnabled,
                  title: "Submit"),
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
                child: SecondaryButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: "Back"))
          ],
        ),
      ),
    );
  }
}
