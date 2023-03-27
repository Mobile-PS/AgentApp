import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_agent/MyController.dart';
import 'package:ticket_agent/data/model/PassangerInfoModel.dart';
import 'package:ticket_agent/data/model/booking_req.dart';
import 'package:ticket_agent/presentation/screen/ticket_details.dart';
import 'package:ticket_agent/utils/LangConstants.dart';
import 'package:ticket_agent/utils/MyThemes.dart';

import '../../components/button_loading_view.dart';

class PassengerDetailPage extends StatefulWidget {
  PassengerList formsdetails;
  var index;

  PassengerDetailPage(
      {Key? key, required this.formsdetails, required this.index})
      : super(key: key);

  @override
  State<PassengerDetailPage> createState() => _PassengerDetailPageState();

  final state = _PassengerDetailPageState();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController kinNameController = TextEditingController();
  TextEditingController kinMobileController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  SingingCharacter? _character = SingingCharacter.Male;
  String gender = "Male";
  bool isVoterId = false;
  bool isDrivingLicense = false;
  bool isOtherId = false;
  bool isPassport = false;
}

enum SingingCharacter { Male, Female }

class _PassengerDetailPageState extends State<PassengerDetailPage> {
  final _formKey = GlobalKey<FormState>();

  MyController controller =
      Get.isRegistered() ? Get.find() : Get.put(MyController());
  bool isVisible = false;
  int tempIndex = 0;
  final formKey = GlobalKey<FormState>();

  bool validate() {
    //Validate Form Fields
    bool validate = formKey.currentState!.validate();
    if (validate) formKey.currentState!.save();
    return validate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.index == 0 ? "Primary Passenger" : "Co-Passenger"}",
                      style: AppStyle.customTextTheme(
                          Colors.black, FontWeight.bold, 15),
                    ),
                    Text(
                      "Seat No :${(controller.selectedSeats.toList()[widget.index].colI + 1) * (controller.selectedSeats.toList()[widget.index].rowI + 1)}",
                      style: AppStyle.customTextTheme(
                          Colors.black, FontWeight.bold, 15),
                    )
                  ],
                ),
              ),
              Container(
                height: 20,
              ),
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          controller: widget.firstNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide()),
                              hintText: " First Name"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          controller: widget.lastNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide()),
                              hintText: LangConstants.ac_sv_ps_det_lst_name.tr),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ]),
              Container(
                height: 20,
              ),
              Container(
                height: 50,
                child: TextFormField(
                  controller: widget.mobileController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide()),
                      hintText: LangConstants.ac_sv_ps_det_mobl_no.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return value;
                  },
                ),
              ),
              Container(
                height: 20,
              ),
              Container(
                height: 50,
                child: TextFormField(
                  controller: widget.emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide()),
                      hintText: LangConstants.ac_tic_pay_eml.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<SingingCharacter>(
                      title: Text(LangConstants.str_male.tr),
                      value: SingingCharacter.Male,
                      groupValue: widget._character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          widget._character = value;
                          widget.gender = value.toString();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<SingingCharacter>(
                      title: Text(LangConstants.str_female.tr),
                      value: SingingCharacter.Female,
                      groupValue: widget._character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          widget._character = value;
                          widget.gender = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              controller.response.value.insuranceAmount! > 0
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Next of Kin Details",
                                    style: AppStyle.customTextTheme(
                                        Colors.black, FontWeight.bold, 15),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          child: TextFormField(
                            controller: widget.kinNameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide()),
                                hintText: " Kin Name"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: TextFormField(
                            controller: widget.kinMobileController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide()),
                                hintText: " Kin Mobile"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Selected ID Type",
                            style: AppStyle.customTextTheme(
                                Colors.black, FontWeight.bold, 15),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          clearselection();
                          widget.isVoterId = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            LangConstants.ac_sv_ps_det_vtr_card_1.tr,
                            style: AppStyle.customTextTheme(
                                Colors.black, FontWeight.w400, 15),
                          ),
                          Text(
                            LangConstants.ac_sv_ps_det_vtr_card_2.tr,
                            style: AppStyle.customTextTheme(
                                Colors.black, FontWeight.w400, 15),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          clearselection();
                          widget.isPassport = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            LangConstants.ac_sv_ps_det_passport_1.tr,
                            style: AppStyle.customTextTheme(
                                Colors.black, FontWeight.w400, 15),
                          ),
                          Text(
                            LangConstants.ac_sv_ps_det_other_id_2.tr,
                            style: AppStyle.customTextTheme(
                                Colors.black, FontWeight.w400, 15),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          clearselection();
                          widget.isOtherId = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            LangConstants.ac_sv_ps_det_other_id_1.tr,
                            style: AppStyle.customTextTheme(
                                Colors.black, FontWeight.w400, 15),
                          ),
                          Text(
                            LangConstants.ac_sv_ps_det_other_id_2.tr,
                            style: AppStyle.customTextTheme(
                                Colors.black, FontWeight.w400, 15),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          clearselection();
                          widget.isDrivingLicense = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            LangConstants.ac_sv_ps_det_drv_lic_1.tr,
                            style: AppStyle.customTextTheme(
                                Colors.black, FontWeight.w400, 15),
                          ),
                          Text(
                            LangConstants.ac_sv_ps_det_drv_lic_2.tr,
                            style: AppStyle.customTextTheme(
                                Colors.black, FontWeight.w400, 15),
                          ),
                          Text(
                            LangConstants.ac_sv_ps_det_other_id_2.tr,
                            style: AppStyle.customTextTheme(
                                Colors.black, FontWeight.w400, 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget.isVoterId ||
                      widget.isDrivingLicense ||
                      widget.isOtherId ||
                      widget.isPassport
                  ? Container(
                      height: 50,
                      child: TextFormField(
                        controller: widget.idCardController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide()),
                            hintText: widget.isVoterId
                                ? "Enter voter id"
                                : widget.isDrivingLicense
                                    ? "Enter driving license"
                                    : widget.isOtherId
                                        ? "Enter other id"
                                        : widget.isPassport
                                            ? "Enter passport"
                                            : " "),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  clearselection() {
    widget.isVoterId = false;
    widget.isDrivingLicense = false;
    widget.isOtherId = false;
    widget.isPassport = false;
  }
}
