import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_agent/utils/color_utils.dart';

class CustomPasswordTextField extends StatefulWidget {

  final validator;
  final focusNode;
  final hint;
  final keyboardType;
  final textEditingController;
  final onChanged;
  late final obscureText;
  CustomPasswordTextField({Key? key, this.validator, this.focusNode ,this.hint, this.keyboardType, this.textEditingController, this.obscureText, this.onChanged}) : super(key: key);

  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {

  bool showPassword = true;
  handleShowPass() {
    return InkWell(
      onTap: ()
      {
        setState(() => showPassword = !showPassword);
      },
      child: Text(
         showPassword
            ? "Show"
            : "Hide",
          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SvgPicture.asset("assets/images/password_icon.svg"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 8),
            child: VerticalDivider(thickness: 3),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              obscureText: showPassword,
              controller: widget.textEditingController,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  labelText: widget.hint,
                  hintText: widget.hint),
              onChanged: widget.onChanged,

            ),
          ),
          Expanded(
            flex: 1,
              child: InkWell(
                onTap: ()
                  {
                    setState(() {
                      widget.obscureText = false;
                    });
                  },
                  child: widget.obscureText?handleShowPass():Container()//Text(widget.obscureText?"Show":"Hide",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold))
     ))
        ],
      ),
    );
  }
}
