import 'dart:convert';

import 'package:frutter/controller/apis.dart';
import 'package:frutter/model/form.dart';
import 'package:http/http.dart';

class Repository extends Apis {
  Future<FormModel> getFrom() async {
    try {
      final Response response = await get(Uri.parse(form));
      if (response.statusCode == 200) {
        return formModelFromJson(response.body);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    //in case get error then, fetch static data
    return formModelFromJson(jsonEncode(_backupData));
  }

  //############################# IN CASE API FAILD THEN WORK WITH THIS JSON
  final Map<String, dynamic> _backupData = {
    "formName": "Order collection form. ",
    "sections": [
      {
        "name": "Details section",
        "key": "section_1",
        "fields": [
          {
            "id": 1,
            "key": "text_1",
            "properties": {"type": "text", "defaultValue": "", "hintText": "ex : Puran dhaka", "minLength": 0, "maxLength": 150, "label": "Write your address"}
          },
          {
            "id": 7,
            "key": "text_3",
            "properties": {"type": "text", "defaultValue": "", "hintText": "ex : 01XXXXXXXX", "minLength": 0, "maxLength": 11, "label": "Phone number"}
          },
          {
            "id": 2,
            "key": "list_1",
            "properties": {"type": "dropDownList", "defaultValue": "2022", "hintText": "Select one from the list", "label": "Your fav food", "listItems": "[{\"name\":\"Apples\",\"value\":1},{\"name\":\"Bananas\",\"value\":9},{\"name\":\"Blackberries\",\"value\":11},{\"name\":\"Cherries\",\"value\":16},{\"name\":\"Dates\",\"value\":20},{\"name\":\"Grapes\",\"value\":26}]"}
          },
          {
            "id": 3,
            "key": "viewText_1",
            "properties": {"type": "viewText", "defaultValue": "", "label": "Retail Price unit"}
          },
          {
            "id": 4,
            "key": "viewText_2",
            "properties": {"type": "viewText", "defaultValue": "", "label": "Cup Equivalent Unit"}
          },
          {
            "id": 5,
            "key": "image_1",
            "properties": {"type": "imageView", "defaultValue": "https://static.vecteezy.com/system/resources/previews/011/307/643/original/avocado-slice-with-avatar-png.png", "label": "Upload your image"}
          },
          {
            "id": 6,
            "key": "text_2",
            "properties": {"type": "numberText", "defaultValue": 1, "hintText": "ex : 1", "label": "How much unit you want to buy"}
          }
        ]
      },
      {
        "name": "Details section 2",
        "key": "section_2",
        "fields": [
          {
            "id": 1,
            "key": "text_1",
            "properties": {"type": "text", "defaultValue": "", "hintText": "ex : Puran dhaka", "minLength": 0, "maxLength": 150, "label": "Write your address"}
          },
          {
            "id": 7,
            "key": "text_3",
            "properties": {"type": "text", "defaultValue": "", "hintText": "ex : 01XXXXXXXX", "minLength": 0, "maxLength": 11, "label": "Phone number"}
          },
          {
            "id": 2,
            "key": "list_2",
            "properties": {"type": "dropDownList", "defaultValue": "2022", "hintText": "Select one from the list", "label": "Your fav food", "listItems": "[{\"name\":\"Apples\",\"value\":1},{\"name\":\"Bananas\",\"value\":9},{\"name\":\"Blackberries\",\"value\":11},{\"name\":\"Cherries\",\"value\":16},{\"name\":\"Dates\",\"value\":20},{\"name\":\"Grapes\",\"value\":26}]"}
          },
          {
            "id": 3,
            "key": "viewText_1",
            "properties": {"type": "viewText", "defaultValue": "", "label": "Retail Price unit"}
          },
          {
            "id": 4,
            "key": "viewText_2",
            "properties": {"type": "viewText", "defaultValue": "", "label": "Cup Equivalent Unit"}
          },
          {
            "id": 5,
            "key": "image_1",
            "properties": {"type": "imageView", "defaultValue": "https://static.vecteezy.com/system/resources/previews/011/307/643/original/avocado-slice-with-avatar-png.png", "label": "Upload your image"}
          },
          {
            "id": 6,
            "key": "list_1",
            "properties": {"type": "dropDownList", "defaultValue": "2022", "hintText": "Select one from the list", "label": "Your fav food", "listItems": "[{\"name\":\"Apples\",\"value\":1},{\"name\":\"Bananas\",\"value\":9},{\"name\":\"Blackberries\",\"value\":11},{\"name\":\"Cherries\",\"value\":16},{\"name\":\"Dates\",\"value\":20},{\"name\":\"Grapes\",\"value\":26}]"}
          },
        ]
      }
    ],
    "valueMapping": [
      {
        "searchList": [
          {"fieldKey": "list_1", "dataColumn": "ProductCode"}
        ],
        "displayList": [
          {
            "fieldKey": "viewText_1",
            "dataColumn": "RetailPriceUnit",
          },
          {
            "fieldKey": "viewText_2",
            "dataColumn": "CupEquivalentUnit",
          },
          {
            "fieldKey": "image_1",
            "dataColumn": "ProductImage",
          }
        ]
      },
      {
        "searchList": [
          {"fieldKey": "list_2", "dataColumn": "ProductCode"}
        ],
        "displayList": [
          {
            "fieldKey": "viewText_1",
            "dataColumn": "RetailPriceUnit",
          },
          {
            "fieldKey": "image_1",
            "dataColumn": "ProductImage",
          }
        ]
      }
    ]
  };
}
