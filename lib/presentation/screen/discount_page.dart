import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_agent/utils/MyThemes.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({Key? key}) : super(key: key);

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 10,top:50,bottom: 10),
        child: Column(
          children: [
            Text("Tegeta to posta via Mwenge",style: AppStyle.customTextTheme(Colors.white, FontWeight.w400, 15),),
            Text("Fare TZS .850",style: AppStyle.customTextTheme(Colors.white, FontWeight.w400, 15),),
          ],
        ),

      ),



    );


  }
}
