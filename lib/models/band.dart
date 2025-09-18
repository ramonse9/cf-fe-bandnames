//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';

class Band {
  String id;
  String name;
  int votes;

  Band({required this.id, required this.name, required this.votes});

  factory Band.fromMap(Map<String, dynamic> obj) {
    return Band(
      id    : obj.containsKey('id') ? obj['id'] : 'no-id',
      name  : obj.containsKey('name') ? obj['name'] : 'no-name',
      votes : obj.containsKey('votes') ? obj['votes'] : 'no-votes',
    );

    /*return Band(
      id: obj['id'] as String,
      name: obj['name'] as String,
      votes: obj['votes'] as int,
    );*/
  }
}
