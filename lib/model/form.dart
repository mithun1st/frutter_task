

import 'dart:convert';

FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));

String formModelToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
    String formName;
    List<Section> sections;
    List<ValueMapping> valueMapping;

    FormModel({
        required this.formName,
        required this.sections,
        required this.valueMapping,
    });

    factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        formName: json["formName"],
        sections: List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
        valueMapping: List<ValueMapping>.from(json["valueMapping"].map((x) => ValueMapping.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "formName": formName,
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
        "valueMapping": List<dynamic>.from(valueMapping.map((x) => x.toJson())),
    };
}

class Section {
    String name;
    String key;
    List<Field> fields;

    Section({
        required this.name,
        required this.key,
        required this.fields,
    });

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        name: json["name"],
        key: json["key"],
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
    };
}

class Field {
    int id;
    String key;
    Properties properties;

    Field({
        required this.id,
        required this.key,
        required this.properties,
    });

    factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        key: json["key"],
        properties: Properties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "properties": properties.toJson(),
    };
}

class Properties {
    String type;
    dynamic defaultValue;
    String? hintText;
    int? minLength;
    int? maxLength;
    String label;
    String? listItems;

    Properties({
        required this.type,
        required this.defaultValue,
        this.hintText,
        this.minLength,
        this.maxLength,
        required this.label,
        this.listItems,
    });

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        type: json["type"],
        defaultValue: json["defaultValue"],
        hintText: json["hintText"],
        minLength: json["minLength"],
        maxLength: json["maxLength"],
        label: json["label"],
        listItems: json["listItems"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "defaultValue": defaultValue,
        "hintText": hintText,
        "minLength": minLength,
        "maxLength": maxLength,
        "label": label,
        "listItems": listItems,
    };
}

class ValueMapping {
    List<DisplayListElement> searchList;
    List<DisplayListElement> displayList;

    ValueMapping({
        required this.searchList,
        required this.displayList,
    });

    factory ValueMapping.fromJson(Map<String, dynamic> json) => ValueMapping(
        searchList: List<DisplayListElement>.from(json["searchList"].map((x) => DisplayListElement.fromJson(x))),
        displayList: List<DisplayListElement>.from(json["displayList"].map((x) => DisplayListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "searchList": List<dynamic>.from(searchList.map((x) => x.toJson())),
        "displayList": List<dynamic>.from(displayList.map((x) => x.toJson())),
    };
}

class DisplayListElement {
    String fieldKey;
    String dataColumn;

    DisplayListElement({
        required this.fieldKey,
        required this.dataColumn,
    });

    factory DisplayListElement.fromJson(Map<String, dynamic> json) => DisplayListElement(
        fieldKey: json["fieldKey"],
        dataColumn: json["dataColumn"],
    );

    Map<String, dynamic> toJson() => {
        "fieldKey": fieldKey,
        "dataColumn": dataColumn,
    };
}
