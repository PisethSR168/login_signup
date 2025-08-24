import 'package:cloud_firestore/cloud_firestore.dart';

class Class {
  final String? id;
  final String courseId;
  final String className;
  final String teacherId;
  final String schedule;
  final DateTime startDate;
  final DateTime endDate;
  final int maxStudents;

  Class({
    this.id,
    required this.courseId,
    required this.className,
    required this.teacherId,
    required this.schedule,
    required this.startDate,
    required this.endDate,
    required this.maxStudents,
  });

  factory Class.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Class(
      id: doc.id,
      courseId: data['courseId'] ?? '',
      className: data['className'] ?? '',
      teacherId: data['teacherId'] ?? '',
      schedule: data['schedule'] ?? '',
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      maxStudents: data['maxStudents'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'className': className,
      'teacherId': teacherId,
      'schedule': schedule,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'maxStudents': maxStudents,
    };
  }
}
