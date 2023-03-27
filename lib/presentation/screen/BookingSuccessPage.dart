

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_agent/presentation/screen/home_page.dart';
import 'package:ticket_agent/utils/MyThemes.dart';

import '../../components/button_loading_view.dart';

class BookingSuccessPage extends StatefulWidget {
  const BookingSuccessPage({Key? key}) : super(key: key);

  @override
  State<BookingSuccessPage> createState() => _BookingSuccessPageState();
}

class _BookingSuccessPageState extends State<BookingSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Confirmed"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Selected seat(s) are reserved. Reservation details has been sent to you via email and sms.."),
           SizedBox(
             height: 10,
           ),
            Text("Use details and below,",style: AppStyle.customTextTheme(Colors.black, FontWeight.w700, 15),),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Ref No:",style: AppStyle.customTextTheme(Colors.black, FontWeight.w700, 15)),
                Text(" 9052299202",style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15)),

              ],
            ), SizedBox(
              height: 10,
            ),
                Row(
                  children: [
                    Text("Total Fare:",style: AppStyle.customTextTheme(Colors.black, FontWeight.w700, 15)),
                    Text("1450",style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15)),

                  ],
                ),

            SizedBox(
              height: 10,
            ),
            Text("Instructions",style: AppStyle.customTextTheme(Colors.black, FontWeight.w700, 15)),
            SizedBox(
              height: 10,
            ),
            Text("1.Dial *150*00#",style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15)),

            SizedBox(
              height: 10,
            ),
            Text("2.Select 4 pay By M-pesa",style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15)),
            SizedBox(
              height: 10,
            ),
            Text("3.Select 4 Enter Business Number",style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15)),
            SizedBox(
              height: 10,
            ),
            Text("4.Enter Company Number - 009009",style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15)),
            SizedBox(
              height: 10,
            ),
            Text("5.Enter Reference Number",style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15)),
            SizedBox(
              height: 10,
            ),
            Text("6.Enter Amount",style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15)),
            SizedBox(
              height: 10,
            ),
            Text("7.Enter PIN",style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15)),
            SizedBox(
              height: 10,
            ),
            Text("8.Enter 1 to confirm",style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 15)),

            SizedBox(
              height: 20,
            ),

            CustomLoadingButton(
            isLoading: false,
            title: "Close",
            onPress: () {
              Get.to(HomePage());
            }
            ),
          ],
        ),
      ),

    );


  }
}
