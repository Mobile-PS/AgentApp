import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ticket_agent/MyController.dart';
import 'package:ticket_agent/presentation/screen/BusSearchPage.dart';
import 'package:ticket_agent/presentation/screen/language.dart';
import 'package:ticket_agent/presentation/screen/login_page.dart';
import 'package:ticket_agent/presentation/screen/print_ticket_page.dart';
import 'package:ticket_agent/presentation/screen/profile_page.dart';
import 'package:ticket_agent/utils/LangConstants.dart';
import 'package:ticket_agent/utils/shared_pref_utils.dart';
import 'package:ticket_agent/utils/string_utils.dart';


import '../../utils/MyThemes.dart';
import 'cancle ticket.dart';
import 'change_password.dart';
import 'manifest_print_ticket.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LangConstants.app_name.tr),

        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                InkWell(
                  onTap: (){
                    myController.isManifest = false;
                    Get.to(BusSearchpage());
                  },
                    child: buildBox(context,LangConstants.ac_ag_dash_bk_tic.tr,"book_ticket.svg")),
                InkWell(onTap: (){
                  myController.isManifest = true;
                  Get.to(BusSearchpage());
                },

                    child: buildBox(context,LangConstants.ac_ag_dash_resrv.tr,"manifest.svg")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                InkWell(onTap: (){
                  Get.to(PrintTicketPage());
                },
                child: buildBox(context,LangConstants.ac_ag_dash_tic_prt.tr,"print.svg")),
                InkWell(onTap: (){
                  Get.to(CancleTicket());
                },
                    child: buildBox(context,LangConstants.ac_ag_dash_cancel_tic.tr,"cancel_ticket.svg")),
              ],
            )
          ],
        ),


        drawer:Drawer(backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(LangConstants.app_name.tr,style: TextStyle(fontSize: 20),),
              ),
              ListTile(
                leading:  Icon(Icons.person),
                title:  Text(LangConstants.ac_ag_dash_profile.tr),
                onTap: () {
                  Get.to(ProfilePage());
                },
              ),
              ListTile(
                leading:  Icon(Icons.book),
                title:  Text(LangConstants.ac_ag_dash_bk_tic.tr),
                onTap: () {

                   Get.to(BusSearchpage());
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title:  Text(LangConstants.ac_ag_dash_settings.tr),
                onTap: () {

                  Get.to(Language());
                },
              ),ListTile(
                leading:  Icon(Icons.settings),
                title:  Text(LangConstants.ag_cg_pwd.tr),
                onTap: () {

                  Get.to(ChangePasswordPage());
                },
              ),ListTile(
                leading:  Icon(Icons.logout),
                title:  Text(LangConstants.ac_ag_dash_logout.tr),
                onTap: () {
                    SharedPrefUtils.clearData();
                  Get.offAll(LoginPage());
                },
              ),
            ],


          ),
        ),
      ),
    );

  }

  Container buildBox(BuildContext context,title,iconName) {
    return Container(
                width: MediaQuery.of(context).size.width/2.5,
                margin: EdgeInsets.only(left: 5,right: 5,top: 10),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(StringUtils.imageBasePath+iconName,width: 80,height: 80,),
                      ),
                      SizedBox(height: 10),
                      Text(title,style: AppStyle.normalHeading20),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              );
  }
}
