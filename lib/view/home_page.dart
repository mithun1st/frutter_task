import 'package:flutter/material.dart';
import 'package:frutter/model/form.dart';
import 'package:frutter/view/pages/order_form.dart';
import 'package:frutter/view/pages/user_feedback.dart';
import 'package:frutter/view/widget/appbar.dart';

class HomePage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomePage({super.key});
  static const String pageName = '/homePage';

  late final FormModel _formModel;

  @override
  Widget build(BuildContext context) {
    _formModel = ModalRoute.of(context)!.settings.arguments as FormModel;

    return Scaffold(
      appBar: appBar('Home Page'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //############################# ORDER
            InkWell(
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(999)),
                child: Text("Custom Order", style: Theme.of(context).textTheme.titleLarge),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(OrderForm.pageName, arguments: _formModel);
              },
            ),

            //############################# FEEDBACK
            InkWell(
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(999)),
                child: Text("Feedback", style: Theme.of(context).textTheme.titleLarge),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(UserFeedback.pageName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
