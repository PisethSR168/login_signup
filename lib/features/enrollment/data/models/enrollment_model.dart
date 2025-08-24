import 'package:cloud_firestore/cloud_firestore.dart';

class Enrollment {
  final String? id;
  final String studentId;
  final String classId;
  final DateTime enrollmentDate;
  final String status;
  final String paymentStatus;

  Enrollment({
    this.id,
    required this.studentId,
    required this.classId,
    required this.enrollmentDate,
    required this.status,
    required this.paymentStatus,
  });

  factory Enrollment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Enrollment(
      id: doc.id,
      studentId: data['studentId'] ?? '',
      classId: data['classId'] ?? '',
      enrollmentDate: (data['enrollmentDate'] as Timestamp).toDate(),
      status: data['status'] ?? '',
      paymentStatus: data['paymentStatus'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'classId': classId,
      'enrollmentDate': Timestamp.fromDate(enrollmentDate),
      'status': status,
      'paymentStatus': paymentStatus,
    };
  }
}
