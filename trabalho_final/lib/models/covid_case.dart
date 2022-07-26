import 'dart:convert';

import 'package:intl/intl.dart';

class CovidCase {
  DateTime date;
  String state;
  String placeType;
  String? city;
  int confirmed;
  int deaths;
  bool isLast;

  CovidCase({
    required this.date,
    required this.state,
    required this.placeType,
    this.city,
    required this.confirmed,
    required this.deaths,
    required this.isLast,
  });

  CovidCase.fromJson(Map json)
      : date = DateTime.parse(json['date']),
        state = json['state'],
        placeType = json['place_type'],
        city = json['city'],
        confirmed = json['confirmed'],
        deaths = json['deaths'],
        isLast = json['is_last'];

  Map toJson() => {
        'date': DateFormat('yyyy-MM-dd').format(date),
        'state': state,
        'placeType': placeType,
        'city': city,
        'confirmed': confirmed,
        'deaths': deaths,
        'isLast': isLast,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
