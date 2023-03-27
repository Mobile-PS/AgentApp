import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticket_agent/utils/color_utils.dart';


class CustomLoadingButton extends StatefulWidget {
  bool isLoading;
  String title;
  Function onPress;

  CustomLoadingButton(
      {Key? key,
      required this.isLoading,
      required this.title,
      required this.onPress})
      : super(key: key);

  @override
  State<CustomLoadingButton> createState() => _CustomLoadingButtonState();
}

class _CustomLoadingButtonState extends State<CustomLoadingButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.isLoading ? null : widget.onPress();
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
           /* boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                color: ColorUtils.primary.withOpacity(0.5), //New
              ),
            ],*/
            color: widget.isLoading
                ?  ColorUtils.primary.withOpacity(0.4)
                :  ColorUtils.primary,
            border: Border.all(
              color: widget.isLoading
                  ?  ColorUtils.primary.withOpacity(0.4)
                  :  ColorUtils.primary,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: widget.isLoading
            ? Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
              )
            : Center(
                child: Text(widget.title,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white))),
              ),
      ),
    );
  }
}
