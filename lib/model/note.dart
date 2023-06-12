import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String description;

  Note({
    required this.id,
    required this.title,
    required this.description,
  });

  Color get noteColor {
    if (description.trim().length < 10) {
      return Colors.grey;
    } else if (description.trim().length < 20) {
      return Colors.blue;
    } else if (description.trim().length < 20) {
      return Colors.purple;
    } else {
      return Colors.orange;
    }
  }
}
