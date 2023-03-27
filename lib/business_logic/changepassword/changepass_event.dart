part of 'changepass_bloc.dart';

@immutable
abstract class ChangePassEvent extends Equatable {}

class ChangePasswordCall extends ChangePassEvent {
  final int agentId;
  final String username;
  final String oldPassword;
  final String newPassword;
  ChangePasswordCall(
      this.agentId, this.username, this.oldPassword, this.newPassword);

  @override
  List<Object?> get props => [];
}
