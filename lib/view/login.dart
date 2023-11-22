import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frutter/bloc/login/login_bloc.dart';
import 'package:frutter/view/home_page.dart';
import 'package:frutter/view/widget/appbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginBloc _loginBloc = LoginBloc();

  bool _obSecure = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _passController.dispose();
    _loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Login"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //############################# TITLE
            Text(
              "Frutter",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            //############################# INPUT SECTION
            BlocConsumer(
              bloc: _loginBloc,
              buildWhen: (previous, current) => current is! LoginActionState,
              listenWhen: (previous, current) => current is LoginActionState,
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  //route and pass data to home page
                  Navigator.of(context).pushReplacementNamed(HomePage.pageName, arguments: state.formModel);
                }
              },
              builder: (context, state) {
                if (state is LoginFailedState) {
                  //clear both field if uname or pass is wrong
                  if (state.nameErrorMsg != null && state.passErrorMsg != null) {
                    _nameController.clear();
                    _passController.clear();
                  }

                  return Column(
                    children: [
                      _usernameInupt(state.nameErrorMsg),
                      const SizedBox(height: 20),
                      _passInput(state.passErrorMsg),
                    ],
                  );
                } else
                //  if (state is LoginPassVisibleHiddenState)
                {
                  return Column(
                    children: [
                      _usernameInupt(null),
                      const SizedBox(height: 20),
                      _passInput(null),
                    ],
                  );
                }
                // else {
                //   return const Text("err");
                // }
              },
            ),

            //############################# SUBMIT
            BlocBuilder(
              bloc: _loginBloc,
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return const CircularProgressIndicator();
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      //#############################
                      FocusScope.of(context).unfocus();
                      _loginBloc.add(LoginSubmitEvent(_nameController.text, _passController.text));
                    },
                    child: const Text("Login"),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _usernameInupt(String? err) {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: "Username",
        errorText: err,
        prefixIcon: const Icon(Icons.person),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: TextInputType.name,
    );
  }

  Widget _passInput(String? err) {
    return TextField(
      controller: _passController,
      obscureText: _obSecure,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: err,
        prefixIcon: const Icon(Icons.password),
        suffixIcon: IconButton(
          onPressed: () {
            _obSecure = !_obSecure;
            _loginBloc.add(LoginPassVisibleHiddenEvent());
          },
          icon: _obSecure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
