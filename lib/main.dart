import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frutter/bloc/feedback/feedback_bloc.dart';
import 'package:frutter/bloc/fruit/fruit_bloc.dart';
import 'package:frutter/bloc/login/login_bloc.dart';
import 'package:frutter/view/pages/invoice.dart';
import 'package:frutter/view/pages/order_form.dart';
import 'package:frutter/view/pages/user_feedback.dart';
import 'package:frutter/view/home_page.dart';
import 'package:frutter/view/login.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //############################# Hive init
  await Hive.initFlutter();
  await Hive.openBox<dynamic>('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //############################# BLOC
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => FeedbackBloc()),
        BlocProvider(create: (context) => FruitBloc()),
      ],
      child: MaterialApp(
        //############################# THEME
        theme: ThemeData(
          useMaterial3: false,
          //color define
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          //text style define
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        routes: {
          //############################# PAGES
          "/": (context) => const Login(),
          HomePage.pageName: (context) => HomePage(),
          OrderForm.pageName: (context) => const OrderForm(),
          UserFeedback.pageName: (context) => const UserFeedback(),
          Invoice.pageName: (context) => Invoice(),
        },
      ),
    );
  }
}
