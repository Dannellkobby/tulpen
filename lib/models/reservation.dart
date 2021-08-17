import 'package:tulpen/statics/strings.dart';

class Reservation {
  int? people;
  int dateCreated;
  // int? dateTime;
  bool confirmed = false;
  String key = '';

  Map<String, dynamic> toJson() => {
        Strings.people: people,
        Strings.dateCreated: dateCreated,
        // Strings.dateTime: dateTime,
        Strings.confirmed: confirmed,
        Strings.key: key,
      }..removeWhere((k, v) => (v == null || v.toString().isEmpty));

  Reservation.fromJson(Map<String, dynamic> json)
      : people = json[Strings.people],
        dateCreated = json[Strings.dateCreated],
        // dateTime = json[Strings.dateTime] ?? 0,
        confirmed = json[Strings.confirmed],
        key = json[Strings.key];
}
