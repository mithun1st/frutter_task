part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginFailedState extends LoginState {
  final String? nameErrorMsg;
  final String? passErrorMsg;
  LoginFailedState(this.nameErrorMsg, this.passErrorMsg);
}
final class LoginPassVisibleHiddenState extends LoginState {}


//action state
final class LoginSuccessState extends LoginActionState {
  final FormModel formModel;
  LoginSuccessState(this.formModel);
}

