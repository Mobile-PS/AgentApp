import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
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
import 'SeatLayoutPage.dart';
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
          BlocProvider(create: (context) =>
          SharedBloc(sharedRepository: RepositoryProvider.of<SharedRepository>(
              context))
            ..add(SuccessEvent())),
          BlocProvider(create: (context) =>
          OperatorBloc(
              sharedRepository: RepositoryProvider.of<SharedRepository>(
                  context))
            ..add(GetOperatorList(SharedPrefUtils.getAgentId()))),
        ],
        child: Scaffold(
            appBar: AppBar(
              title: Text("Search Bus"),
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
                        title: "Search",
                        onPress: () {

                          if(selectedOperator!=null && selectedBusTypeValue!=null && myController.source!=null && myController.destination!=null) {

                            Get.to(BusListingPage(
                                operatorId: selectedOperator == null
                                    ? 0
                                    : selectedOperator!.operatorId!,
                                busType: selectedBusTypeValue == null
                                    ? "all"
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
                          }
                          else
                          {
                            Fluttertoast.showToast(
                                msg: "Please fill the details...",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
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
      width: MediaQuery
          .of(context)
          .size
          .width,
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
                  Text("From",
                      style: AppStyle.customTextTheme(
                          ColorUtils.grey, FontWeight.w500, 16)),
                  InkWell(
                      onTap: () async {
                        CityItem from = await Get.to(SearchCityPage());
                        setState(() {
                          myController.source = from;
                          this.from =  myController.source!.cityName!;
                        });
                      },
                      child: Text("$from",
                          style: AppStyle.customTextTheme(
                              ColorUtils.black, FontWeight.w600, 18))),
                  Divider(
                    thickness: 1,
                  ),
                  Text("To",
                      style: AppStyle.customTextTheme(
                          ColorUtils.grey, FontWeight.w500, 16)),
                  InkWell(
                      onTap: () async {
                        CityItem to = await Get.to(SearchCityPage());
                        setState(() {
                          myController.destination = to;
                          this.to =  myController.destination!.cityName!;
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
                    if(!from.contains("Select") && !to.contains("Select")) {
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
      width: MediaQuery
          .of(context)
          .size
          .width,
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
                      Text("Date",
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
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              BlocBuilder<OperatorBloc, OperatorState>(
                builder: (context, state) {
                  if(state is LoadingOperatorState)
                  {
                    return Container(
                      height: 100,
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(),),
                    );
                  }
                  else if(state is OperatorSuccessState)
                  {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Select Bus",
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
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'SELECT BUS (Optional)',
                                        style: AppStyle.customTextTheme(
                                            ColorUtils.grey, FontWeight.w600, 16),
                                      ),
                                    ],
                                  ),
                                  items: state.value.operatorList
                                      ?.map((item) =>
                                      DropdownMenuItem<OperatorList>(
                                        value: item!=null?item:null,
                                        child: Row(
                                          children: [


                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${item.operatorName}",
                                              style: AppStyle.customTextTheme(
                                                  ColorUtils.black,
                                                  FontWeight.w600,
                                                  16),
                                              overflow: TextOverflow.ellipsis,
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

                                  itemHeight: 50,
                                  dropdownMaxHeight: 300,
                                  dropdownWidth:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.90,



                                  dropdownElevation: 5,
                                  scrollbarRadius: const Radius.circular(2),
                                  scrollbarThickness: 6,
                                  scrollbarAlwaysShow: true,
                                  offset: const Offset(-8, -2))),
                        )
                      ],
                    );
                  }
                  else
                  {
                    return Text("Something went wrong");
                  }
                },
              ),
            ],
          )
      ),
    );
  }

  Widget childUI(BuildContext context, BusRoute busRoute) {
    return InkWell(
      onTap: () {
        myController.selectedBus= busRoute;
        Get.to(SeatLayoutPage());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text("${busRoute.operatorName}",
                      style: AppStyle.customTextTheme(
                          ColorUtils.black, FontWeight.w600, 20))),
              Center(
                  child: Text("(${busRoute.routeName})",
                      style: AppStyle.customTextTheme(
                          ColorUtils.grey, FontWeight.w500, 16))),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Departure On",
                            style: AppStyle.customTextTheme(
                                ColorUtils.grey, FontWeight.w500, 16)),
                        Text("${busRoute.departureTime}",
                            style: AppStyle.customTextTheme(
                                ColorUtils.black, FontWeight.w500, 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Total Travel Time",
                            style: AppStyle.customTextTheme(
                                ColorUtils.grey, FontWeight.w500, 16)),
                        Text("${busRoute.departureTime}",
                            style: AppStyle.customTextTheme(
                                ColorUtils.black, FontWeight.w500, 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Seat",
                            style: AppStyle.customTextTheme(
                                ColorUtils.grey, FontWeight.w500, 16)),
                        Text("${busRoute.totalSeat}",
                            style: AppStyle.customTextTheme(
                                ColorUtils.black, FontWeight.w500, 16)),
                      ],
                    ),
                  ],
                ),
              ),

              // Column(

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
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
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              children: [
                                Text("${busRoute.sourceName}",
                                    style: AppStyle.customTextTheme(
                                        ColorUtils.black, FontWeight.w600, 18)),
                                Text("${busRoute.departureTime}",
                                    style: AppStyle.customTextTheme(
                                        ColorUtils.grey, FontWeight.w500, 16)),
                              ],
                            ),
                            Dash(
                                direction: Axis.horizontal,
                                length: 90,
                                dashLength: 30,
                                dashThickness: 0.9,
                                dashColor: Colors.black),


                            Padding(
                              padding: const EdgeInsets.only(right:20),
                              child: Column(
                                children: [
                                  Text("${busRoute.destinationName}",
                                      style: AppStyle.customTextTheme(
                                          ColorUtils.black, FontWeight.w600, 18)),
                                  Text("${busRoute.arrivalTime}",
                                      style: AppStyle.customTextTheme(
                                          ColorUtils.grey, FontWeight.w500, 16)),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: ColorUtils.lightGrey,
                            border: Border.all(
                              color: ColorUtils.grey,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5.0),
                          child: Text("${busRoute.busType}",
                              style: AppStyle.customTextTheme(
                                  ColorUtils.black, FontWeight.w500, 16)),
                        )),
                    Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: ColorUtils.lightGrey,
                            border: Border.all(
                              color: ColorUtils.grey,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5.0),
                          child: Text("T250 DKI",
                              style: AppStyle.customTextTheme(
                                  ColorUtils.black, FontWeight.w500, 16)),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text("TZS. ${busRoute.fare}",
                          style: AppStyle.customTextTheme(
                              ColorUtils.black, FontWeight.w500, 16)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
