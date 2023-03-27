part of 'savenewpassword_bloc.dart';

@immutable
abstract class saveNewPasswordEvent extends Equatable{

}

 class SaveNewPasswordCall extends saveNewPasswordEvent
{
  late final String username;
  late final int agentId;
  late final String newPassword;
  late final String confirmPassword;
  late final String otp;

  SaveNewPasswordCall(this.username,this.agentId,this.newPassword,this.confirmPassword,this.otp);

  @override
  List<Object?> get props => [];

}


