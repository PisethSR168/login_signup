import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_model.dart';

class StudentRepository {
  final CollectionReference _studentsCollection = FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(Student student) {
    return _studentsCollection.add(student.toMap());
  }

  Stream<List<Student>> getStudents() {
    return _studentsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Student.fromFirestore(doc)).toList();
    });
  }

  Future<void> updateStudent(Student student) {
    return _studentsCollection.doc(student.id).update(student.toMap());
  }

  Future<void> deleteStudent(String studentId) {
    return _studentsCollection.doc(studentId).delete();
  }
}
