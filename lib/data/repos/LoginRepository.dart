

import 'package:ticket_agent/data/model/SaveTicketResponse.dart';
import 'package:ticket_agent/data/model/agentProfileRequest.dart';
import 'package:ticket_agent/data/model/agentProfileResponse.dart';
import 'package:ticket_agent/data/model/changePasswordRequest.dart';
import 'package:ticket_agent/data/model/saveNewPasswordRequest.dart';
import 'package:ticket_agent/data/model/saveNewPasswordResponse.dart';
import 'package:ticket_agent/data/services/ApiClient.dart';
import 'package:ticket_agent/data/model/login_response.dart';
import 'package:ticket_agent/data/services/ApiClient.dart';

import '../model/changePasswordResponse.dart';
import '../model/forgotPasswordResponse.dart';

class LoginRepository {

  final _client = ApiClient();

  Future<LoginResponse?> loginUser(final String username, final String password) {
    return _client.loginApi(username, password);
  }



  Future<ChangePasswordResponse?> changepasswordUser( String agentId,
  String username,
  String oldPassword,
  String newPassword,) {
    return _client.changepasswordApi(agentId ,username, oldPassword,newPassword);
  }


  Future<ForgotPasswordResponse?>forgotpasswordUser(String username) {
    return _client.ForgotPasswordApi(username);
  }


  Future<AgentProfileResponse?>getAgentProfile(int agentId) {
    return _client.getAgentProfile(agentId);
  }

  Future<SaveNewPasswordResponse>getSavePasswordApi(
    String username,
      int agentId,
      String newPassword,
      String confirmPassword,
      String otp) {
    return _client.getSavePasswordApi( username, agentId, newPassword, confirmPassword, otp);
  }

}
