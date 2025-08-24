import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String? id;
  final String courseName;
  final String description;
  final int durationInMonths;
  final double fee;

  Course({
    this.id,
    required this.courseName,
    required this.description,
    required this.durationInMonths,
    required this.fee,
  });

  factory Course.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Course(
      id: doc.id,
      courseName: data['courseName'] ?? '',
      description: data['description'] ?? '',
      durationInMonths: data['durationInMonths'] ?? 0,
      fee: (data['fee'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'description': description,
      'durationInMonths': durationInMonths,
      'fee': fee,
    };
  }
}
