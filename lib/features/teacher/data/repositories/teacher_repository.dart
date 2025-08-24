import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/teacher_model.dart';

class TeacherRepository {
  final CollectionReference _teachersCollection = FirebaseFirestore.instance.collection('teachers');

  Future<void> addTeacher(Teacher teacher) {
    return _teachersCollection.add(teacher.toMap());
  }

  Stream<List<Teacher>> getTeachers() {
    return _teachersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Teacher.fromFirestore(doc)).toList();
    });
  }

  Future<void> updateTeacher(Teacher teacher) {
    return _teachersCollection.doc(teacher.id).update(teacher.toMap());
  }

  Future<void> deleteTeacher(String teacherId) {
    return _teachersCollection.doc(teacherId).delete();
  }
}
