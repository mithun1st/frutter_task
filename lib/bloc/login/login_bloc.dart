import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frutter/controller/repository.dart';
import 'package:frutter/model/form.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {


    on<LoginSubmitEvent>((event, emit) async {
      if (event.userName == "") {
        emit(LoginFailedState("Username Field Can't be Epmty", null));
      } else if (event.password == "") {
        emit(LoginFailedState(null, "Password Field Can't be Epmty"));
      } else if (event.userName == "esssumon@gmail.com" && event.password == "admin") {
        emit(LoginLoadingState());
        final FormModel formModel = await Repository().getFrom();
        emit(LoginSuccessState(formModel));
      } else {
        emit(LoginFailedState("Username Incorrect", "Password Incorrect"));
      }
    });
    on<LoginPassVisibleHiddenEvent>((event, emit){
      emit(LoginPassVisibleHiddenState());
    });
  }
}
