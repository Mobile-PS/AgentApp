import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ticket_agent/components/CustomPasswordTextField.dart';
import 'package:ticket_agent/components/CustomTextField.dart';
import 'package:ticket_agent/components/button_loading_view.dart';
import 'package:ticket_agent/utils/LangConstants.dart';
import 'package:ticket_agent/utils/shared_pref_utils.dart';
import 'package:ticket_agent/utils/string_utils.dart';
import '../../business_logic/auth/login/login_bloc.dart';
import '../../business_logic/auth/login/login_event.dart';
import '../../business_logic/auth/login/login_state.dart';
import '../../data/repos/LoginRepository.dart';
import 'forget_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPagerState();
}

class _LoginPagerState extends State<LoginPage> {
  final loginController = TextEditingController();
  final passController = TextEditingController();
  bool showPassword = false;

  bool isLoading = false;
  final regExp = RegExp(
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\$");

  String? _validatorEmail(value) {
    if (!regExp.hasMatch(value)) {
      return "type a valid email";
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  late LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context)=>LoginRepository(),
      child: BlocProvider(
          create: (context) => LoginBloc(loginRepository: RepositoryProvider.of<LoginRepository>(context)),
        child: Scaffold(
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
                                  "assets/images/login_icon.svg"))),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(LangConstants.ac_ag_login_str_lg.tr,
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
                            loginForm()
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state;
        if (formStatus is LoginError) {
          isLoading = false;
          _showSnackBar(context, formStatus.error);
        }
        if (formStatus is Logined) {
          SharedPrefUtils.setData(StringUtils.loginInfosp, formStatus.loginResponse.toJson());
          SharedPrefUtils.setData(StringUtils.username,loginController.text);
          isLoading = false;

          Get.to(HomePage());
        }
        if (formStatus is LoginLoading) {
          isLoading = true;
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextField(
                  hint: LangConstants.ac_ag_login_usnm.tr,
                  validator: _validatorEmail,
                  prefixIcon: Icons.account_circle,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  textEditingController: loginController),
              SizedBox(height: 15),
              CustomPasswordTextField(
                hint: LangConstants.ac_ag_login_pwd.tr,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                textEditingController: passController,
              ),
              SizedBox(height: 35),
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                return CustomLoadingButton(
                    isLoading: isLoading,
                    title: LangConstants.ac_ag_login_str_lg.tr,
                    onPress: () {
                      if (loginController.text.isNotEmpty &&
                          passController.text.isNotEmpty) {
                        BlocProvider.of<LoginBloc>(context).add(Create(loginController.text, passController.text));
                      } else {
                        Fluttertoast.showToast(msg: "Enter valid credentials");
                      }
                    });
              }),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Get.to(ForgetPage());
                },
                child: Text(
                  LangConstants.ac_ag_login_fg_pwd.tr,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
  //  bloc = LoginBloc(loginRepository: RepositoryProvider.of<LoginRepository>(context));
 //   bloc.add(initEvent());
    super.initState();
  }
}
