import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ticket_agent/business_logic/operators/operator_bloc.dart';
import 'package:ticket_agent/components/button_loading_view.dart';
import 'package:ticket_agent/data/model/BusRoute.dart';
import 'package:ticket_agent/data/model/OperatorResponse.dart';
import 'package:ticket_agent/data/model/city_response.dart';
import 'package:ticket_agent/presentation/screen/BusListingPage.dart';
import 'package:ticket_agent/presentation/screen/CalenderBottomSheet.dart';
import 'package:ticket_agent/utils/LangConstants.dart';
import 'package:ticket_agent/utils/color_utils.dart';
import 'package:ticket_agent/utils/date_utils.dart';
import 'package:ticket_agent/utils/shared_pref_utils.dart';

import '../../MyController.dart';
import '../../business_logic/sharebloc/shared_bloc.dart';
import '../../data/model/bus_layout_filter_response.dart';
import '../../data/model/login_response.dart';
import '../../data/repos/SharedRepository.dart';
import '../../utils/MyThemes.dart';
import '../../utils/string_utils.dart';
import 'city_search.dart';

class BusSearchpage extends StatefulWidget {
  const BusSearchpage({Key? key}) : super(key: key);

  @override
  State<BusSearchpage> createState() => _BusSearchpageState();
}

OperatorList? selectedOperator;
BusTypeList? selectedBusTypeValue;

class _BusSearchpageState extends State<BusSearchpage>
    with TickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  String from = "Select source";
  String to = "Select destination";
  String switchName = "";
  bool isBusDropDownActive = false;
  bool isBusTypeDropDownActive = false;
  double angle = 0;
  bool _expanded = false;
  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      upperBound: 0.5); //..repeat();
  // List of items in our dropdown menu

  MyController myController = Get.find();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SharedRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SharedBloc(
                  sharedRepository:
                      RepositoryProvider.of<SharedRepository>(context))
                ..add(SuccessEvent())),
          BlocProvider(
              create: (context) => OperatorBloc(
                  sharedRepository:
                      RepositoryProvider.of<SharedRepository>(context))
                ..add(GetOperatorList(SharedPrefUtils.getAgentId()))),
        ],
        child: Scaffold(
            appBar: AppBar(
              title: Text(LangConstants.ac_sr_bs_act_name.tr),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  searchBusUi(context),
                  dateUI(context),
                  SelectBusUI(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: CustomLoadingButton(
                        isLoading: false,
                        title: LangConstants.ac_sr_bs_search.tr,
                        onPress: () {
                          if (myController.source != null &&
                              myController.destination != null) {
                            myController.operatorId = selectedOperator == null
                                ? 0
                                : selectedOperator!.operatorId!;
                            myController.selectedDate =
                                MyDateUtils.getSelectedYYYYDDMM(selectedDate);
                            myController.busType = selectedBusTypeValue == null
                                ? "all"
                                : selectedBusTypeValue!.busType!;
                            Get.to(BusListingPage(
                                operatorId: selectedOperator == null
                                    ? 0
                                    : selectedOperator!.operatorId!,
                                busType: selectedBusTypeValue == null
                                    ? LangConstants.ac_sr_bs_all.tr
                                    : selectedBusTypeValue!.busType!,
                                sourceId: myController.source != null
                                    ? myController.source!.cityId!
                                    : 0,
                                destId: myController.destination != null
                                    ? myController.destination!.cityId!
                                    : 0,
                                lang: 'eg',
                                date: MyDateUtils.getSelectedYYYYDDMM(
                                    selectedDate)));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please fill the details...",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Container searchBusUi(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Card(
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
              child: Column(
                children: [
                  SvgPicture.asset("${StringUtils.imageBasePath}dot.svg",
                      width: 15, height: 15),
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                  SvgPicture.asset("${StringUtils.imageBasePath}dot.svg",
                      width: 15, height: 15),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Text(LangConstants.ac_sr_bs_from.tr,
                      style: AppStyle.customTextTheme(
                          ColorUtils.grey, FontWeight.w500, 16)),
                  InkWell(
                      onTap: () async {
                        CityItem from = await Get.to(SearchCityPage());
                        setState(() {
                          myController.source = from;
                          this.from = myController.source?.cityName ?? "";
                        });
                      },
                      child: Text("$from",
                          style: AppStyle.customTextTheme(
                              ColorUtils.black, FontWeight.w600, 18))),
                  Divider(
                    thickness: 1,
                  ),
                  Text(LangConstants.ac_sr_bs_to.tr,
                      style: AppStyle.customTextTheme(
                          ColorUtils.grey, FontWeight.w500, 16)),
                  InkWell(
                      onTap: () async {
                        CityItem to = await Get.to(SearchCityPage());
                        setState(() {
                          myController.destination = to;
                          this.to = myController.destination!.cityName!;
                        });
                      },
                      child: Text("$to",
                          style: AppStyle.customTextTheme(
                              ColorUtils.black, FontWeight.w600, 18))),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(width: 10),
            /*  InkWell(
              onTap: ()
              {
                setState((){
                  angle = 180 * math.pi / 180;
                });

              },
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(angle: angle,child: child,);
                },
                child: SvgPicture.asset("${StringUtils.imageBasePath}route_icon.svg",width: 40,height: 40,),
              ),
            ),*/
            SizedBox(
              width: 90,
              height: 90,
              child: RotationTransition(
                turns:
                    Tween(begin: 0.0, end: 1.0).animate(_animationController),
                child: IconButton(
                  icon: SvgPicture.asset(
                    "${StringUtils.imageBasePath}route_icon.svg",
                    // width: 40,
                    // height: 40,
                  ),
                  onPressed: () {
                    if (!from.contains("Select") && !to.contains("Select")) {
                      setState(() {
                        if (_expanded) {
                          _animationController.reverse(from: 0.5);
                        } else {
                          _animationController..forward(from: 0.0);
                        }

                        switchName = from;
                        from = to;
                        to = switchName;

                        _expanded = !_expanded;
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(width: 2),
          ],
        ),
      ),
    );
  }

  Container dateUI(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset("${StringUtils.imageBasePath}dot.svg",
                          width: 20, height: 15),
                      SizedBox(width: 10),
                      Text(LangConstants.ac_tic_pay_dt.tr,
                          style: AppStyle.customTextTheme(
                              ColorUtils.grey, FontWeight.w500, 16)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          CalenderBottomSheet(callback: (dateTime) {
                        setState(() {
                          selectedDate = dateTime;
                        });
                        Get.back();
                      }),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text("${MyDateUtils.getFormatterDate(selectedDate)}",
                        style: AppStyle.customTextTheme(
                            ColorUtils.black, FontWeight.w600, 18)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            selectedDate = DateTime.now();
                          });
                        },
                        child: Text("Today",
                            style: AppStyle.customTextTheme(
                              ColorUtils.primary,
                              FontWeight.w500,
                              16,
                            ))),
                    Text("/",
                        style: AppStyle.customTextTheme(
                          ColorUtils.black,
                          FontWeight.w500,
                          16,
                        )),
                    InkWell(
                        onTap: () {
                          setState(() {
                            selectedDate =
                                DateTime.now().add(Duration(days: 1));
                          });
                        },
                        child: Text("Tomorrow",
                            style: AppStyle.customTextTheme(
                              ColorUtils.primary,
                              FontWeight.w500,
                              16,
                            ))),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Container SelectBusUI(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<OperatorBloc, OperatorState>(
                builder: (context, state) {
                  if (state is LoadingOperatorState) {
                    return Container(
                      height: 100,
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is OperatorSuccessState) {
                    if (state.value.operatorList.length == 1) {
                      selectedOperator = state.value.operatorList[0];
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(LangConstants.ac_sr_bs_etr_bus.tr,
                                  style: AppStyle.customTextTheme(
                                      ColorUtils.grey, FontWeight.bold, 16)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      // SvgPicture.asset(
                                      //     "${StringUtils.imageBasePath}bus.svg",
                                      //     width: 25,
                                      //     height: 25),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        LangConstants.ac_sr_bs_etr_bus.tr,
                                        style: AppStyle.customTextTheme(
                                            ColorUtils.grey,
                                            FontWeight.w600,
                                            16),
                                      ),
                                    ],
                                  ),
                                  items: state.value.operatorList
                                      ?.map((item) =>
                                          DropdownMenuItem<OperatorList>(
                                            value: item != null ? item : null,
                                            child: Row(
                                              children: [
                                                // SvgPicture.asset(
                                                //     "${StringUtils
                                                //         .imageBasePath}bus.svg",
                                                //     width: 25,
                                                //     height: 25),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${item.operatorName}",
                                                  style:
                                                      AppStyle.customTextTheme(
                                                          ColorUtils.black,
                                                          FontWeight.w600,
                                                          16),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedOperator,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOperator = value as OperatorList;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.expand_more,
                                  ),
                                  iconSize: 30,
                                  iconEnabledColor: Colors.black,
                                  iconDisabledColor: Colors.grey,
                                  buttonHeight: 50,
                                  buttonWidth: double.infinity,
                                  buttonPadding: const EdgeInsets.all(10),
                                  /*buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.pink,
                        ),
                        color: Colors.white,
                      ),*/
                                  itemHeight: 50,
                                  dropdownMaxHeight: 300,
                                  dropdownWidth:
                                      MediaQuery.of(context).size.width * 0.90,
                                  //  dropdownPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                                  /* dropdownDecoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: ColorUtils.green, width: 1),
                      ),*/
                                  dropdownElevation: 5,
                                  scrollbarRadius: const Radius.circular(2),
                                  scrollbarThickness: 6,
                                  scrollbarAlwaysShow: true,
                                  offset: const Offset(-8, -2))),
                        )
                      ],
                    );
                  } else {
                    return Text("Something went wrong");
                  }
                },
              ),
              Divider(thickness: 2),
              BlocBuilder<SharedBloc, SharedState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Container(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ));
                  } else if (state is SuccessState) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(LangConstants.ac_sr_bs_sel_bs_ty.tr,
                                  style: AppStyle.customTextTheme(
                                      ColorUtils.grey, FontWeight.bold, 16)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      // SvgPicture.asset(
                                      //     "${StringUtils.imageBasePath}bus.svg",
                                      //     width: 25,
                                      //     height: 25),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        LangConstants.ac_sr_bs_sel_bs_ty.tr,
                                        style: AppStyle.customTextTheme(
                                            ColorUtils.grey,
                                            FontWeight.w600,
                                            16),
                                      ),
                                    ],
                                  ),
                                  items: state.value.busTypeList
                                      ?.map((item) =>
                                          DropdownMenuItem<BusTypeList>(
                                            value: item != null ? item : null,
                                            child: Row(
                                              children: [
                                                // SvgPicture.asset(
                                                //     "${StringUtils
                                                //         .imageBasePath}bus.svg",
                                                //     width: 25,
                                                //     height: 25),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${item.busType}",
                                                  style:
                                                      AppStyle.customTextTheme(
                                                          ColorUtils.black,
                                                          FontWeight.w600,
                                                          16),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedBusTypeValue =
                                          value as BusTypeList;
                                    });
                                  },
                                  value: selectedBusTypeValue == null
                                      ? null
                                      : selectedBusTypeValue,
                                  icon: const Icon(
                                    Icons.expand_more,
                                  ),
                                  iconSize: 30,
                                  iconEnabledColor: Colors.black,
                                  iconDisabledColor: Colors.grey,
                                  buttonHeight: 50,
                                  buttonWidth: double.infinity,
                                  buttonPadding: const EdgeInsets.all(10),
                                  /*buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.pink,
                        ),
                        color: Colors.white,
                      ),*/
                                  itemHeight: 50,
                                  dropdownMaxHeight: 300,
                                  dropdownWidth:
                                      MediaQuery.of(context).size.width * 0.90,
                                  //  dropdownPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                                  /* dropdownDecoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: ColorUtils.green, width: 1),
                      ),*/
                                  dropdownElevation: 5,
                                  scrollbarRadius: const Radius.circular(2),
                                  scrollbarThickness: 6,
                                  scrollbarAlwaysShow: true,
                                  offset: const Offset(-8, -2))),
                        )
                      ],
                    );
                  } else {
                    return Text("Something went wrong");
                  }
                },
              )
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
