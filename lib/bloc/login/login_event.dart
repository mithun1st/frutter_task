part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  final String userName;
  final String password;
  LoginSubmitEvent(this.userName, this.password);
}
class LoginPassVisibleHiddenEvent extends LoginEvent{}