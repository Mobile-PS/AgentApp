import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_agent/presentation/screen/login_page.dart';
import 'package:ticket_agent/utils/LangConstants.dart';
import 'package:ticket_agent/utils/MyThemes.dart';

import '../../components/CustomPasswordTextField.dart';
import '../../components/button_loading_view.dart';







class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    var passController;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SvgPicture.asset("assets/images/change_password.svg",height: 150,color: Colors.blue,),
            ),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(LangConstants.ac_agpr_nw.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child:
              SvgPicture.asset("assets/images/blue_divider.svg"),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                  "Your new password must be different from previous used password",
                style: AppStyle.customTextTheme(
                    Colors.black, FontWeight.w400, 15),),

            ),
            SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomPasswordTextField(
                    hint: LangConstants.ac_agpr_nw.tr,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textEditingController: passController,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  CustomPasswordTextField(
                    hint: LangConstants.ac_agpr_nw_cfm.tr,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textEditingController: passController,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(LangConstants.ac_agpr_pwd_ntm.tr),

                  SizedBox(
                    height: 20,
                  ),


                  Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: CustomLoadingButton(
                        isLoading: false, title: LangConstants.ac_tic_pay_submit.tr, onPress: () {
                      Get.to(LoginPage());
                    }
                    ),
                  ),







                ],
              ),
            ),
          ],
        ),
      ),    );
  }
}


