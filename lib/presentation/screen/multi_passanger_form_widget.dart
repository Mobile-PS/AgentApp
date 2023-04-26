import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_agent/MyController.dart';
import 'package:ticket_agent/data/model/PassangerInfoModel.dart';
import 'package:ticket_agent/data/model/booking_req.dart';
import 'package:ticket_agent/presentation/screen/passenger_details.dart';
import 'package:ticket_agent/presentation/screen/ticket_details.dart';

class MultiPassangerFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MultiPassangerFormWidgetState();
  }
}

class _MultiPassangerFormWidgetState extends State<MultiPassangerFormWidget> {
  List<PassengerDetailPage> contactForms = List.empty(growable: true);
  MyController controller =
      Get.isRegistered() ? Get.find() : Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add passanger details"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              print('testData 123');
              onSave();
            },
            child: Text("Save"),
          ),
        ),
        body: ListView.builder(
            itemCount: contactForms.length,
            itemBuilder: (_, index) {
              return contactForms[index];
            }));
  }

  onSave() {
    print('testData 223');
    bool allValid = true;
    controller.passangerList.clear();
    //If any form validation function returns false means all forms are not valid
    contactForms.forEach((element) =>
    allValid = (allValid && element.valid));

    if (allValid) {
    //  var selectedSeats = controller.selectedSeats.toList();

      for (int i = 0; i < contactForms.length; i++) {
        String seatType = "";
        String seatNo = "";
        int seatFare = 0;

        PassengerDetailPage item = contactForms[i];

        /* for (int j = 0; j < controller.selectedList.length; j++) {
        if (controller.response.value.busLayout![j].rowNo ==
                selectedSeats[i].rowI.toString() &&
            controller.response.value.busLayout![j].colNo ==
                selectedSeats[i].colI.toString()) {
          seatNo = controller.response.value.busLayout![j].seatNo.toString();
          seatType =
              controller.response.value.busLayout![j].seatType.toString();
          seatFare = controller.response.value.busLayout![j].seatFare!.toInt();
        }
      }*/
        seatNo = controller.selectedList[i].seatNo.toString();
        seatType = controller.selectedList[i].seatType.toString();
        seatFare = controller.selectedList[i].seatFare!.toInt();

        PassengerList passangerInfoModel = PassengerList(
            email: item.emailController.text,
            firstName: item.firstNameController.text,
            idProofType: item.idCardController.text,
            lastName: item.lastNameController.text,
            mobileNo: item.mobileController.text,
            seatType: seatType,
            seatNo: seatNo,
            gender: item.gender,
            type: "adult",
            seatFare: seatFare,
            insurance: "no",
            insuranceAmount: 0);

        controller.passangerList.add(passangerInfoModel);
      }
      Get.to(TicketDetails());
      //Submit Form Here
      // } else {
      //    debugPrint("Form is Not Valid");
      // }
    }
  }

  @override
  void initState() {
    setState(() {
      for (int a = 0; a < controller.selectedList.length; a++) {
        contactForms.add(PassengerDetailPage(
            formsdetails: PassengerList.param(a), index: a,valid:false));
      }
    });

    String bseatList = "";
    for (int i = 0; i < controller.selectedList.length; i++) {

      bseatList = bseatList + controller
          .selectedList[i].seatNo
          .toString() + ',';

    }

    bseatList = bseatList.substring(0, bseatList.length - 1);
    print(bseatList);
    controller.seatno = bseatList;

    super.initState();
  }

  onAdd() {
    print("listing ${contactForms.length}");

    print("listing22 ${contactForms.length}");
  }
}
