import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frutter/bloc/fruit/fruit_bloc.dart';
import 'package:frutter/model/field_enum.dart';
import 'package:frutter/model/form.dart';
import 'package:frutter/view/pages/invoice.dart';
import 'package:frutter/view/widget/appbar.dart';
import 'package:frutter/view/widget/confirm_pop_up.dart';
import 'package:frutter/view/widget/dropdown.dart';
import 'package:frutter/view/widget/image_view.dart';
import 'package:frutter/view/widget/name_text_field.dart';
import 'package:frutter/view/widget/num_text_field.dart';

class OrderForm extends StatefulWidget {
  static const String pageName = "/orderForm";

  const OrderForm({super.key});

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  late FormModel _formModel;
  final FruitBloc _fruitBloc = FruitBloc();

  late Map<String, dynamic> _sectionsResult = {};
  late List<List<String>> _showColumnOfFruit = [];

  Map<String, dynamic> _insFieldKey() {
    Map<String, dynamic> sectionResult = {};
    for (Section section in _formModel.sections) {
      Map<String, dynamic> listField = {};
      sectionResult[section.key] = listField;
    }
    return sectionResult;
  }

  List<List<String>> _insColmnForShow() {
    List<List<String>> list = [];
    for (var vp in _formModel.valueMapping) {
      List<String> display = [];
      for (var dis in vp.displayList) {
        display.add(dis.dataColumn);
      }
      list.add(display);
    }
    return list;
  }

  bool _isUserStarterFillField() {
    for (Map value in _sectionsResult.values) {
      if ((value).isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    // 
    super.initState();
    _fruitBloc.add(FruitLoadedEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _formModel = ModalRoute.of(context)!.settings.arguments as FormModel;

    _sectionsResult = _insFieldKey();
    _showColumnOfFruit = _insColmnForShow();
  }

  @override
  void dispose() {
    super.dispose();
    _fruitBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_isUserStarterFillField()) {
          return true;
        }
        return confirm(context);
      },
      child: Scaffold(
        appBar: appBar("Order Form Page"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //############################# SECTION AND FIELD
              ..._formModel.sections.map((s) {
                return Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _sectionBuild(s),
                );
              }).toList(),

              //############################# ORDER BUTTON
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Invoice.pageName,
                    arguments: _sectionsResult,
                  );
                },
                icon: const Icon(Icons.inventory_outlined),
                label: const Text("ORDER"),
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 40),
              //############################# FRUITS TABLE
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._showColumnOfFruit.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NameTextField(
                            fnc: (k) => _fruitBloc.add(FruitSearchingEvent(k)),
                            label: "Search Fruits",
                            hint: "search by product code",
                            minLen: 1,
                            maxLen: 1,
                            defaultValue: "",
                          ),
                          BlocBuilder(
                            bloc: _fruitBloc,
                            builder: (context, state) {
                              if (state is FruitLoadingState) {
                                return const CircularProgressIndicator();
                              } else if (state is FruitLoadedState) {
                                return _fruitItemList(state.fruit, e);
                              } else {
                                return const Text("error");
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),

              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  //widget function
  //section widget
  Widget _sectionBuild(Section section) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //section name
        Text(
          section.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Divider(
          thickness: 2,
          indent: 30,
          endIndent: 30,
          height: 20,
          color: Colors.black,
        ),
        //filds
        ...section.fields.map((element) {
          final Properties p = element.properties;
          if (p.type == FieldType.viewText.value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Card(
                elevation: 8,
                child: Text(
                  p.label,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          } else if (p.type == FieldType.imageView.value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ImageView(
                  fnc: (v) {
                    _sectionsResult[section.key][element.key] = v;
                  },
                  label: p.label,
                  defaultUrl: p.defaultValue),
            );
          } else if (p.type == FieldType.text.value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: NameTextField(
                fnc: (v) {
                  _sectionsResult[section.key][element.key] = v;
                },
                label: p.label,
                hint: p.hintText.toString(),
                minLen: (p.minLength == null || p.minLength! <= 0) ? 1 : p.minLength!,
                maxLen: p.maxLength!,
                defaultValue: p.defaultValue,
              ),
            );
          } else if (p.type == FieldType.numberText.value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: NumTextField(
                fnc: (v) {
                  _sectionsResult[section.key][element.key] = v;
                },
                label: p.label,
                hint: p.hintText.toString(),
                defaultValue: p.defaultValue.toString(),
              ),
            );
          } else if (p.type == FieldType.dropDownList.value) {
            List<Map<String, dynamic>> items = [];
            for (var element in (jsonDecode(p.listItems!) as List)) {
              Map<String, dynamic> map = {
                "name": element["name"],
                "value": element["value"],
              };
              items.add(map);
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomDropdown(
                labelText: p.label,
                hintText: p.hintText.toString(),
                nameAndId: items,
                fnc: (v) {
                  _sectionsResult[section.key][element.key] = v;
                },
              ),
            );
          } else {
            return const Text("Unknown Field");
          }
        }).toList(),
      ],
    );
  }

  Widget _fruitItemList(List<Map<String, dynamic>> fruit, List<String> haveToShow) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(visible: haveToShow.contains("ProductCode"), child: const Text("ProductCode")),
              Visibility(visible: haveToShow.contains("Fruit"), child: const Text("Fruit")),
              Visibility(visible: haveToShow.contains("Form"), child: const Text("Form")),
              Visibility(visible: haveToShow.contains("RetailPrice"), child: const Text("RetailPrice")),
              Visibility(visible: haveToShow.contains("RetailPriceUnit"), child: const Text("RetailPriceUnit")),
              Visibility(visible: haveToShow.contains("Yield"), child: const Text("Yield")),
              Visibility(visible: haveToShow.contains("CupEquivalentSize"), child: const Text("CupEquivalentSize")),
              Visibility(visible: haveToShow.contains("CupEquivalentUnit"), child: const Text("CupEquivalentUnit")),
              Visibility(visible: haveToShow.contains("CupEquivalentPrice"), child: const Text("CupEquivalentPrice")),
              Visibility(visible: haveToShow.contains("ProductImage"), child: const Text("ProductImage")),
            ],
          ),
        ),
        ...fruit.map((e) {
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(visible: haveToShow.contains("ProductCode"), child: Text(e["ProductCode"].toString())),
                Visibility(visible: haveToShow.contains("Fruit"), child: Text(e["Fruit"].toString())),
                Visibility(visible: haveToShow.contains("Form"), child: Text(e["Form"].toString())),
                Visibility(visible: haveToShow.contains("RetailPrice"), child: Text(e["RetailPrice"].toString())),
                Visibility(visible: haveToShow.contains("RetailPriceUnit"), child: Text(e["RetailPriceUnit"].toString())),
                Visibility(visible: haveToShow.contains("Yield"), child: Text(e["Yield"].toString())),
                Visibility(visible: haveToShow.contains("CupEquivalentSize"), child: Text(e["CupEquivalentSize"].toString())),
                Visibility(visible: haveToShow.contains("CupEquivalentUnit"), child: Text(e["CupEquivalentUnit"].toString())),
                Visibility(visible: haveToShow.contains("CupEquivalentPrice"), child: Text(e["CupEquivalentPrice"].toString())),
                Visibility(
                  visible: haveToShow.contains("ProductImage"),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.network(e["ProductImage"].toString()),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 40),
      ],
    );
  }
}
