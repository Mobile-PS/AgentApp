import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_agent/presentation/screen/home_page.dart';
import 'package:ticket_agent/utils/LangConstants.dart';

import '../../utils/MyThemes.dart';
import '../../utils/color_utils.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language",style:TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/3),
           Text(LangConstants.app_name.tr,style: TextStyle(fontSize: 30),),
           Text(LangConstants.ac_ag_dash_settings.tr,style: TextStyle(fontSize: 20),),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    Get.updateLocale( Locale('en', 'US'));
                    Get.offAll(HomePage());
                  },
                  child: Expanded(
                    flex: 1,
                    child: Container(
                        width: 150,
                        color: Colors.grey,
                        padding: EdgeInsets.all(30),
                        child: Center(child: Text(LangConstants.ac_sel_lang_eng.tr,style: AppStyle.customTextTheme(Colors.white,FontWeight.w500,20),))),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: ()
                  {
                    Get.updateLocale(const Locale('hi', 'IN'));
                    Get.offAll(HomePage());
                  },
                  child: Expanded(
                    flex: 1,
                      child: Container(
                          color: Colors.grey,
                          width: 150,
                          padding: EdgeInsets.all(30),
                          child: Center(child: Text(LangConstants.ac_sel_lang_swa.tr,style: AppStyle.customTextTheme(Colors.white,FontWeight.w500,20),))),

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
