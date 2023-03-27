import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ticket_agent/business_logic/busroute/bus_route_bloc.dart';
import 'package:ticket_agent/presentation/screen/multi_passanger_form_widget.dart';
import 'package:ticket_agent/utils/LangConstants.dart';

import '../../MyController.dart';
import '../../components/button_loading_view.dart';
import '../../data/model/BordingPointsResponce.dart';
import '../../data/repos/BusRouteRepository.dart';
import '../../utils/shared_pref_utils.dart';

class BordingDropingPage extends StatefulWidget {
  const BordingDropingPage({Key? key}) : super(key: key);

  @override
  State<BordingDropingPage> createState() => _BordingDropingPageState();
}

class _BordingDropingPageState extends State<BordingDropingPage> {
  BusRouteBloc bloc = BusRouteBloc(BusRouteRepository());
  MyController myController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bording/Droping'),
      ),
      body: BlocBuilder<BusRouteBloc, BusRouteState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is BoardingLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BoardingSuccessState) {
              BoardingPointsResponse boardingpoints = state.value;
              print(boardingpoints.responseMessage);

              myController.selectedBoardingPoint =
                  boardingpoints.boardingPoint[0];
              myController.selectedDroppingPoint =
                  boardingpoints.droppingPoint[0];

              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Boarding From",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: DropdownButton(
                              underline: SizedBox.shrink(),
                              // Initial Value
                              value: myController.selectedBoardingPoint,
                              // Array list of items
                              icon: Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              items: boardingpoints.boardingPoint
                                  .map((IngPoint item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(item.location),
                                  ),
                                );
                              }).toList(),
                              onChanged: (dynamic newValue) {
                                setState(() {
                                  myController.selectedBoardingPoint = newValue;
                                });
                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Icon(Icons.keyboard_arrow_down)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Dropping To",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: DropdownButton(
                              underline: SizedBox.shrink(),
                              // Initial Value
                              value: myController.selectedDroppingPoint,
                              // Array list of items
                              icon: Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              items: boardingpoints.droppingPoint
                                  .map((IngPoint items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(items.location),
                                  ),
                                );
                              }).toList(),
                              onChanged: (dynamic? newValue) {
                                setState(() {
                                  myController.selectedDroppingPoint =
                                      newValue!;
                                });
                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Icon(Icons.keyboard_arrow_down)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text("Something went wrong");
            }
          }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: CustomLoadingButton(
            isLoading: false,
            title: LangConstants.kin_title.tr,
            onPress: () {
              Get.to(MultiPassangerFormWidget());
            }),
      ),
    );
  }

  @override
  void initState() {
    bloc.add(GetBoardingData(
      myController.selectedBus!.routeId.toString(),
      myController.source!.cityId.toString(),
      myController.destination!.cityId.toString(),
    ));

    super.initState();
  }
}
