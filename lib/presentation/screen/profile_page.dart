
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ticket_agent/business_logic/agentprofile/agentprofile_bloc.dart';
import 'package:ticket_agent/data/model/agentProfileResponse.dart';
import 'package:ticket_agent/utils/MyThemes.dart';

import '../../data/repos/LoginRepository.dart';
import '../../utils/LangConstants.dart';
import '../../utils/shared_pref_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  AgentProfileBloc bloc = AgentProfileBloc(loginRepository: LoginRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LangConstants.ac_ag_dash_profile.tr),
      ),
      body: BlocBuilder<AgentProfileBloc, AgentProfileState>(
        bloc: bloc,
        builder: (context, state) {

          if(state is LoadingAgentProfileState)
            {
              return Center(child: CircularProgressIndicator());
            }
          else if(state is AgentProfileSuccessState)
            {
              AgentProfileResponse agentProfileResponse = state.value;
              return Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Color(0xffE6E6E6),
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            color: Color(0xffCCCCCC),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(child: Text('${agentProfileResponse.firstName} ${agentProfileResponse.lastName}', style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 18))),
                      SizedBox(
                        height: 10,
                      ),
                      Center(child: Text(agentProfileResponse.agentType,style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 18))),
                      SizedBox(
                        height: 10,
                      ),


                      Divider(
                        height: 50,
                        thickness: 1,
                        color: Colors.grey,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email', style: AppStyle.customTextTheme(Colors.grey, FontWeight.w500, 18)),
                            Text('${agentProfileResponse.email}',style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 18)),
                            SizedBox(
                              height: 13,
                            ),
                            Text('Phone', style: AppStyle.customTextTheme(Colors.grey, FontWeight.w500, 18)),
                            Text('${agentProfileResponse.contactNo}', style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 18)),
                            SizedBox(
                              height: 13,
                            ),
                            Text('Address',style: AppStyle.customTextTheme(Colors.grey, FontWeight.w500, 18)),
                            Text('${agentProfileResponse.address}',style: AppStyle.customTextTheme(Colors.black, FontWeight.w400, 18)),
                            SizedBox(
                              height: 15,
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Icon(Icons.lock,
                            //           color: Colors.blue,
                            //           size: 20),
                            //       Text("Change Password",
                            //           style: TextStyle(fontSize: 15))
                            //
                            //     ],
                            //   ),
                            // ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),


              );
            }
          else
            {
            return  Center(child: Text("Something went wrong"));
            }

        },
      ),
    );
  }

  @override
  void initState() {
    bloc.add(AgentProfileCall(SharedPrefUtils.getAgentId()));
    super.initState();
  }
}
