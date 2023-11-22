import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<Map> nameAndId;
  final String labelText;
  final String hintText;
  final Function fnc;

  const CustomDropdown({super.key, required this.labelText, required this.hintText, required this.nameAndId, required this.fnc});

  @override
  State<CustomDropdown> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<CustomDropdown> {
  List<DropdownMenuItem<int>> selectItem = [];

  @override
  void initState() {
    super.initState();

    for (var element in widget.nameAndId) {
      selectItem.add(
        DropdownMenuItem(
          value: element['value'],
          child: Text(element['name'].toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.centerRight,
      child: DropdownButtonFormField<int>(
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              widget.hintText.toString(),
              // style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          decoration: InputDecoration(
            labelText: widget.labelText.toString(),

            //border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: (value) {
            for (Map mp in widget.nameAndId) {
              if (mp['value'].toString() == value.toString()) {
                widget.fnc(mp['name']);
              }
            }
          },
          items: selectItem),
    );
  }
}
