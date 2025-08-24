import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/enrollment_model.dart';

class EnrollmentRepository {
  final CollectionReference _enrollmentsCollection = FirebaseFirestore.instance.collection('enrollments');

  Future<void> addEnrollment(Enrollment enrollment) {
    return _enrollmentsCollection.add(enrollment.toMap());
  }

  Stream<List<Enrollment>> getEnrollments() {
    return _enrollmentsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Enrollment.fromFirestore(doc)).toList();
    });
  }

  Future<void> updateEnrollment(Enrollment enrollment) {
    return _enrollmentsCollection.doc(enrollment.id).update(enrollment.toMap());
  }

  Future<void> deleteEnrollment(String enrollmentId) {
    return _enrollmentsCollection.doc(enrollmentId).delete();
  }
}
