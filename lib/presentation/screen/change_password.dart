import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_agent/components/button_loading_view.dart';
import 'package:ticket_agent/data/model/changePasswordResponse.dart';
import 'package:ticket_agent/presentation/screen/login_page.dart';
import 'package:ticket_agent/presentation/screen/verify_screen.dart';
import 'package:ticket_agent/utils/LangConstants.dart';
import 'package:ticket_agent/utils/MyThemes.dart';
import 'package:ticket_agent/utils/shared_pref_utils.dart';

import '../../business_logic/changepassword/changepass_bloc.dart';
import '../../data/repos/LoginRepository.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  ChangePassBloc bloc = ChangePassBloc(loginRepository: LoginRepository());
  var _controllerOldPassword = TextEditingController();
  var _controllerNewPassword = TextEditingController();
  var _controllerConfirmNewPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LangConstants.ac_ag_dash_c_pwd.tr),
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
          child: Text(LangConstants.ac_ag_dash_c_pwd.tr,
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

        Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                  controller: _controllerOldPassword,
                  decoration: InputDecoration(
                      hintText: "Old password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _controllerNewPassword,
                  decoration: InputDecoration(
                      hintText: LangConstants.ac_agpr_nw.tr,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),

                ),
                SizedBox(height: 10),
                TextField(
                  controller: _controllerConfirmNewPassword,
                  decoration: InputDecoration(
                      hintText: LangConstants.ac_agpr_nw_cfm.tr,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),

                ),
                SizedBox(height: 30),
                BlocBuilder<ChangePassBloc, ChangePassState>(
                  bloc: bloc,
                  builder: (context, state) {

                    return CustomLoadingButton(
                        isLoading: false,
                        title: "Save",
                        onPress: () {

                          if(_controllerNewPassword.text==_controllerConfirmNewPassword.text) {
                            bloc.add(ChangePasswordCall(
                                SharedPrefUtils.getAgentId(),
                                SharedPrefUtils.getUserName()!,
                                _controllerOldPassword.text,
                                _controllerNewPassword.text));
                          }else{
                            Fluttertoast.showToast(msg: LangConstants.ac_agpr_pwd_ntm.tr);
                          }

                          if(state is ChangePassSuccessState){
                            Fluttertoast.showToast(msg: LangConstants.pwd_change_success.tr);
                            SharedPrefUtils.clearData();
                            Get.offAll(LoginPage());
                          }

                        });


                  },
                )
              ],
            ),
          ),
        ),
]
      ),
    ),
      ),
    );
  }
}
