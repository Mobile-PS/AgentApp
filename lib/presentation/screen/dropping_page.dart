import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ticket_agent/data/model/city_response.dart';
import 'package:ticket_agent/utils/MyThemes.dart';

import '../../MyController.dart';
import '../../business_logic/sharebloc/shared_bloc.dart';
import '../../data/model/BordingPointsResponce.dart';
import '../../data/repos/SharedRepository.dart';
import '../../utils/color_utils.dart';

class DroppingPage extends StatefulWidget {
  List<IngPoint> ingPoint;
   DroppingPage({Key? key ,required this.ingPoint}) : super(key: key);

  @override
  State<DroppingPage> createState() => _DroppingPageState();
}

class _DroppingPageState extends State<DroppingPage> {

  MyController myController = Get.find();
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
                margin: EdgeInsets.only(left:10,bottom:30,right: 10,top: 10),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: widget.ingPoint.length,
                    itemBuilder: (contextx, index) {
                      return
                        InkWell(
                        onTap: () {
                          setState(() {
                            if(myController.droppingItemSelected != index)
                            {
                              myController.droppingItemSelected = index;
                            }
                            else
                            {
                              myController.droppingItemSelected = -1;
                            }
                            myController.selectedDroppingPoint = widget.ingPoint[index];

                          });

                        },
                        child: Card(
                          color:   myController.droppingItemSelected  == index ? ColorUtils.primary : null,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                              color: ColorUtils.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.near_me),
                                    SizedBox(width: 20,),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(widget.ingPoint[index].location
                                              .toString(),
                                            style: AppStyle.customTextTheme(
                                                myController.droppingItemSelected  == index?Colors.white:Colors.black, FontWeight.w500, 16),),
                                          Text(widget.ingPoint[index].address
                                              .toString(), style: AppStyle.customTextTheme(
                                              myController.droppingItemSelected  == index?Colors.white54:ColorUtils.grey, FontWeight.w500, 16),),
                                        ]
                                    ),
                                  ],
                                ),

                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("",
                                        style: AppStyle.customTextTheme(
                                            Colors.black, FontWeight.w500, 16),),
                                      Text(widget.ingPoint[index].arrivalTime
                                          .toString(), style: AppStyle.customTextTheme(
                                          ColorUtils.black, FontWeight.w500, 16),),
                                    ]
                                ),

                              ],
                            ),
                          ),)
                      );
                    }),
              )
      );

  }

  @override
  void initState() {
    super.initState();
  }
}
