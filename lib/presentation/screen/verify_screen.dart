import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:ticket_agent/utils/MyThemes.dart';

import '../../components/button_loading_view.dart';

class Verify_Screen extends StatefulWidget {
  const Verify_Screen({Key? key}) : super(key: key);

  @override
  State<Verify_Screen> createState() => _Verify_ScreenState();
}

class _Verify_ScreenState extends State<Verify_Screen> {
  set _onEditing(bool _onEditing) {}

  set _code(bool _code) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body:
        Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Verify Code',style: AppStyle.customTextTheme(Colors.black, FontWeight.bold, 30),),

            SizedBox(
              height: 20,
            ),
            Center(
              child: VerificationCode(
                keyboardType: TextInputType.number,
                underlineColor: Colors.black,
                fullBorder: true,
                length:6 ,
                cursorColor: Colors.black,

                clearAll: Padding(
                  padding: const EdgeInsets.only(top: 20),

                  child: Column(
                    children: [
                      Text(
                        'Havent recived the Verification Code',
                        style: TextStyle(fontSize: 14.0,
                            decoration: TextDecoration.underline, color: Colors.black),
                      ),
                      Text(
                        'Resend OTP',
                        style: TextStyle(fontSize: 14.0,
                            decoration: TextDecoration.underline, color: Colors.blue[700]),
                      ),
                    ],
                  ),


                ), onCompleted: (String value) {
                     setState(() {
                      _code = value as bool;
                       });
              }, onEditing: (bool value) {
                  setState(() {
                    _onEditing = value;
                       });
              },

              ),
            ),
            SizedBox(
              height: 90,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: CustomLoadingButton(
                  isLoading: false, title: "Verify", onPress: () {}
              ),
            ),

          ],
        ),
    );
  }
}

