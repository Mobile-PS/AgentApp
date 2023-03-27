import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_agent/utils/color_utils.dart';
import 'package:ticket_agent/utils/validator.dart';

class CustomTextField extends StatefulWidget {
  final validator;
  final focusNode;
  final prefixIcon;
  final hint;
  final keyboardType;
  final textEditingController;
  final obscureText;
  final onChanged;

  CustomTextField({
    Key? key,
    this.validator,
    this.prefixIcon,
    this.hint,
    this.keyboardType,
    this.focusNode,
    this.textEditingController,
    this.obscureText,
    this.onChanged
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool showPassword = false;

  handleShowPass() {
    return IconButton(
      icon: showPassword
          ? Icon(Icons.remove_red_eye, color: Colors.white, size: 20)
          : Icon(Icons.visibility_off, color: Colors.white, size: 20),
      color: ColorUtils.primary,
      onPressed: () {
        setState(() => showPassword = !showPassword);
      },
    );
  }

  String? _validator(value) {
    if (widget.obscureText) {
      if (value == null || value.isEmpty) {
        return 'type a ${widget.hint}';
      }
      return null;
    } else {
      if (value == null || value.isEmpty) {
        return 'type a ${widget.hint}';
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(3.0),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SvgPicture.asset("assets/images/user_icon.svg"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 8),
            child: VerticalDivider(thickness: 3),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  labelText: widget.hint,
                  errorStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14
                  ),
                  hintText: widget.hint),
              focusNode: widget.focusNode,
             // validator: widget.validator ?? _validator,
              controller: widget.textEditingController,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              cursorColor: Colors.black,
              obscureText: widget.obscureText ? !showPassword : false,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
