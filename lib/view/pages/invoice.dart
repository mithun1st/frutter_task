import 'package:flutter/material.dart';
import 'package:frutter/controller/service.dart';
import 'package:frutter/view/widget/appbar.dart';
import 'package:hive_flutter/adapters.dart';

class Invoice extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Invoice({super.key});
  static const String pageName = '/invoicePage';

  late final Map<String, dynamic> _result;

  @override
  Widget build(BuildContext context) {
    _result = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: appBar('Invoice'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //############################# SHOW INPUTS
              ..._result.keys.map((sectionKey) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      color: Colors.blue,
                      child: Text(
                        sectionKey,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...(_result[sectionKey] as Map).keys.map((fieldKey) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                tileColor: Colors.grey.shade300,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                title: Text(fieldKey),
                                subtitle: Text(_result[sectionKey][fieldKey].toString()),
                              ),
                              const SizedBox(height: 10)
                            ],
                          );
                        }).toList(),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ],
                );
              }).toList(),

              //############################# SAVE DATA
              ElevatedButton(
                onPressed: () async {
                  Box box = Hive.box('myBox');
                  await box.add(_result);
                  // ignore: use_build_context_synchronously
                  AllServices.showSuccessMsg(context, "Saved");
                },
                child: const Text('Save To File'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
