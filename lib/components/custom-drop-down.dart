

import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final String hint;
  final dynamic selectedValue;
  final ValueChanged<dynamic>? onChanged;
  final List<DropdownMenuItem> menuItem;

  const DropDown(
      {Key? key,
      required this.hint,
      required this.selectedValue,
      required this.menuItem,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            hint,
            //style: LotOfThemes.hint,
            overflow: TextOverflow.ellipsis,
          ),
          items: menuItem,
          value: selectedValue,
          onChanged: onChanged,
          icon: const Icon(
            Icons.expand_more,
          ),
          iconSize: 30,
          iconEnabledColor:Colors.green,
          iconDisabledColor: Colors.grey,
          // buttonHeight: 50,
          // buttonWidth: double.infinity,
          // buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          // buttonDecoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(5),
          //   border: Border.all(
          //     color: AppColors.midGrey,
          //   ),
          //   color: Colors.white,
          // ),
          // itemHeight: 35,
          // dropdownMaxHeight: MediaQuery.of(context).size.width * 0.50,
          // dropdownWidth: MediaQuery.of(context).size.width * 0.92,
          // //  dropdownPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          // dropdownDecoration: BoxDecoration(
          //   color: Colors.white,
          //   shape: BoxShape.rectangle,
          //   borderRadius: BorderRadius.circular(5),
          //   border: Border.all(color: AppColors.midGrey, width: 1),
          // ),
          // dropdownElevation: 5,
          // scrollbarRadius: const Radius.circular(2),
          // scrollbarThickness: 6,
          // scrollbarAlwaysShow: true,
          // offset: const Offset(1, -2),
        ),
      ),
    );
  }
}
