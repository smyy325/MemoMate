import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
class Note{
  String id;
  String title;
  String note;
  int color;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note(
      {required this.id,
        required this.title,
        required this.note,
        this.color=0xFFFFFFFF,
        required this.createdAt,
        required this.updatedAt});
}


int generateRandomLightColor() {
  Random random = Random();
  int red = 230 + random.nextInt(25);
  int green = 230 + random.nextInt(25);
  int blue = 240 + random.nextInt(15);
  return (0xFF << 24) | (red << 16) | (green << 8) | blue;
}
