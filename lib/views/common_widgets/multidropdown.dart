import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horecah_assignment/constant/apptextstyle.dart';
import 'package:horecah_assignment/constant/colors.dart';
import 'package:horecah_assignment/views/common_widgets/custom_text_field.dart';

class MultipleDropdown extends StatefulWidget {
  const MultipleDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.labelText,
    required this.selectedList,
    this.maxSelection = 4,
    this.keyValue = false,
    this.enableSearch = false,
  });
  final List items;
  final void Function(dynamic) onChanged;
  final List<String> selectedList;
  final bool keyValue;

  final String labelText;
  final int maxSelection;
  final bool enableSearch;

  @override
  State<MultipleDropdown> createState() => _MultipleDropdownState();
}

class _MultipleDropdownState extends State<MultipleDropdown> {
  final TextEditingController _textFieldController = TextEditingController();
  List mySelectedList = [];
  final TextEditingController searchController = TextEditingController();

  void _showDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            StatefulBuilder(builder: (context, setModalState) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select ${widget.labelText}",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          TextButton(
                            onPressed: () {
                              List<String> myKeyList = [];
                              List<String> myValueList = [];

                              for (var i = 0; i < mySelectedList.length; i++) {
                                myKeyList.add(mySelectedList[i].toString());
                                myValueList.add(mySelectedList[i].toString());
                              }
                              _textFieldController.text =
                                  myValueList.join(", ");
                              widget.onChanged(myKeyList);

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "SAVE",
                              style: AppTextStyle.style14w400.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (widget.enableSearch)
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          onChanged: (_) {
                            setModalState(() {});
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for an item...',
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    Column(
                      children: List.generate(
                        widget.items.length,
                        (i) {
                          final myDropdownData = widget.items[i];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Checkbox(
                                activeColor: AppColors.whiteColor,
                                side: const BorderSide(
                                    color: AppColors.orangeColor),
                                fillColor: const MaterialStatePropertyAll(
                                    AppColors.whiteColor),
                                checkColor: AppColors.orangeColor,
                                onChanged: (val) {
                                  (val ?? false)
                                      ? widget.maxSelection >
                                              mySelectedList.length
                                          ? mySelectedList.add(myDropdownData)
                                          : Fluttertoast.showToast(
                                              msg:
                                                  "You can select max ${widget.maxSelection}")
                                      : mySelectedList.remove(myDropdownData);
                                  setModalState(() {});
                                },
                                value: mySelectedList.contains(myDropdownData),
                              ),
                              title: Text(
                                myDropdownData,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    List mySelectedListTemp = widget.selectedList;
    List mySelectedValueList = [];

   
    List.generate(mySelectedListTemp.length, (index) {
      final myElement = widget.items.firstWhere((element) {
   
        return element.key == mySelectedListTemp[index];
      });
      mySelectedValueList.add(myElement);
      mySelectedList.add(myElement);
    });

    _textFieldController.text = mySelectedValueList.join(', ');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.labelText,
              style: const TextStyle(
                color: AppColors.lightGrey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CustomTextField(
            style: Theme.of(context).textTheme.bodyMedium,
            controller: _textFieldController,
            readOnly: true,
            onTap: () {
              _showDialog(context);
            },
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 10,
            hintText: 'Please select',
            suffixIcon: Icon(
              _textFieldController.text.isEmpty
                  ? Icons.expand_more
                  : Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
