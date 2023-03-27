import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_agent/business_logic/savenewpassword/savenewpassword_bloc.dart';
import 'package:ticket_agent/presentation/screen/new_password.dart';
import 'package:ticket_agent/utils/shared_pref_utils.dart';

import '../../components/CustomPasswordTextField.dart';
import '../../components/button_loading_view.dart';
import '../../data/repos/LoginRepository.dart';
import '../../utils/MyThemes.dart';
import 'login_page.dart';


class VerificationPage extends StatefulWidget {
  String username;

  VerificationPage({Key? key, required this.username}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  SaveNewPasswordBloc bloc = SaveNewPasswordBloc(
      loginRepository: LoginRepository());

  String? code ;

  var isLoading =false;

  @override
  Widget build(BuildContext context) {

    var passController = TextEditingController();
    var newPassController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: SvgPicture.asset(
                  "assets/images/otp.svg", color: Colors.blue,)),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text("OTP Verification",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child:
              SvgPicture.asset("assets/images/blue_divider.svg"),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: RichText(
                text: TextSpan(
                  text: "A one time password (OTP) has been sent your mobile number",
                  style: AppStyle.customTextTheme(
                      Colors.black, FontWeight.w400, 15),),
              ),
            ),
            RichText(
              text: TextSpan(
                text: "Username : ",
                style: AppStyle.customTextTheme(
                    Colors.black, FontWeight.w400, 15),),
            ),
            SizedBox(
              height: 5,
            ),
            VerificationCode(
              fullBorder: true,
              textStyle: TextStyle(
                  fontSize: 20.0, color: Colors.black),
              keyboardType: TextInputType.number,
              underlineColor: Colors.black,
              length: 6,
              cursorColor: Colors.black,
              onCompleted: (String value) {
                setState(() {
                  code = value;
                });
              },
              onEditing: (bool value) {
                setState(() {
                 // _onEditing = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomPasswordTextField(
                    hint: "New Password",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textEditingController: passController,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  CustomPasswordTextField(
                    hint: "Confirm Password",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textEditingController: newPassController,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("both passwords must match"),


                  // Padding(
                  // padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  // child: CustomLoadingButton(
                  // isLoading: false, title: "Verify", onPress: () {
                  //  Get.to(NewPassword());
                  // }
                  // ),
                  // ),


                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: BlocBuilder<SaveNewPasswordBloc, SaveNewPasswordState>(
          bloc: bloc,
          builder: (context, state) {
            return CustomLoadingButton(
                isLoading: isLoading, title: "Submit", onPress: () {
                  if(passController.text == newPassController.text && code?.length==6)
                    {
                      bloc.add(SaveNewPasswordCall(widget.username,SharedPrefUtils.getAgentId(),passController.text,newPassController.text,code!));
                    }
                  else
                    {
                      Fluttertoast.showToast(msg: "Password not matched ...");
                    }

                  if(state is LoadingsavenewpasswordState)
                    {
                      setState(() {
                        isLoading=true;
                      });
                    }
                  else if(state is SaveNewPasswordSuccessState)
                    {
                      setState(() {
                        isLoading=false;
                      });
                      Get.offAll(LoginPage());
                    }
                  else
                    {
                      setState(() {
                        isLoading=false;
                      });
                    }


            }
            );
          },
        ),
      ),
    );
  }
}