import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
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
  final gemini = Gemini.instance;
  bool isLoading = false;

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
                hintText: "About",
                keyboardType: TextInputType.name,
                validator: (p0) {
                  if (p0 == null && p0!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              gapV20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: PrimaryButton(
                        onTap: () async {
                          isLoading = true;
                          setState(() {});
                          final textGenerated = await gemini.text(
                              '''Please create a very brief self-description for me with a maximum of 600 words. Here are the details:
Name: ${widget.myData["name"]}
Phone: ${widget.myData["phone"]}
Email: ${widget.myData["email"]}
City: ${widget.myData["city"]}
Feel free to add some basic additional information about me. Please keep in mind that it should be maximum of 600 words
'''
                              // "Could you write a very short self-description for me? Include my name ${widget.myData["name"]}, phone number ${widget.myData["phone"]}, email ${widget.myData["email"]}, and city ${widget.myData["city"]} within 600 words. Feel free to add details about my background, interests, and personality traits."
                              //"" I've written a brief description of myself ${aboutController.text} and here's my basic details Name-${widget.myData["name"]},Email-${widget.myData["email"]},Phone ${widget.myData["phone"]}, City-${widget.myData["city"]} but I'd like to expand on it. Could you please use this text as a make a interesting insights about me with respect to my carrer? please make sure maximum no. of words not exceed of 600 words"
                              );
                          print(
                              textGenerated?.content?.parts!.first.text ?? "");

                          aboutController.text =
                              textGenerated?.content?.parts?.last.text ?? "";
                          isLoading = false;
                          setState(() {});
                        },
                        isDisabled: isLoading,
                        imagePath: "sparkle.png",
                        imageColor: AppColors.orangeColor,
                        title: "Write With AI"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Expanded(child: MyOutlinedButton(title: "Type"))
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
