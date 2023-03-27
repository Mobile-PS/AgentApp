import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_agent/components/CustomPasswordTextField.dart';
import 'package:ticket_agent/components/CustomTextField.dart';
import 'package:ticket_agent/components/button_loading_view.dart';
import 'package:ticket_agent/presentation/screen/verification_page.dart';
import 'package:ticket_agent/utils/string_utils.dart';

import '../../business_logic/forgotpassword/forgotPassword_bloc.dart';
import '../../data/repos/LoginRepository.dart';

class ForgetPage extends StatefulWidget {
  const ForgetPage({Key? key}) : super(key: key);

  @override
  State<ForgetPage> createState() => _LoginPagerState();
}

class _LoginPagerState extends State<ForgetPage> {
  final usernameController = TextEditingController();

  String? _validatorEmail(value) {
    if (!regExp.hasMatch(value)) {
      return "type a valid email";
    }
    return null;
  }

  final regExp = RegExp(
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\$");
  ForgotPasswordBloc bloc =
      ForgotPasswordBloc(loginRepository: LoginRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(
                    flex: 4,
                    child: Center(
                        child: SvgPicture.asset(
                            "assets/images/forgot_password.svg"))),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(StringUtils.forget_password,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: Text("To Continue AFRITEK AGENT"),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 20, bottom: 30, right: 15),
                          child: SvgPicture.asset(
                              "assets/images/blue_divider.svg")),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextField(
                              hint: "Enter username",
                              prefixIcon: Icons.account_circle,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                               textEditingController: usernameController
                            ),
                            SizedBox(height: 35),
                            BlocBuilder<ForgotPasswordBloc,
                                ForgotPasswordState>(
                              bloc: bloc,
                              builder: (context, state) {
                                return CustomLoadingButton(
                                    isLoading: false,
                                    title: StringUtils.send,
                                    onPress: () {
                                      bloc.add(ForgotPasswordCall(usernameController.text));

                              if(state is ForgotPasswordSuccessState)
                                {
                                 Get.to(VerificationPage(username: usernameController.text));
                                 }
                                else
                                {
                                  Fluttertoast.showToast(msg: "No user found");
                                }
    });
                              }
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
