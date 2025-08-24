import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/class_model.dart';

class ClassRepository {
  final CollectionReference _classesCollection = FirebaseFirestore.instance.collection('classes');

  Future<void> addClass(Class classModel) {
    return _classesCollection.add(classModel.toMap());
  }

  Stream<List<Class>> getClasses() {
    return _classesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Class.fromFirestore(doc)).toList();
    });
  }

  Future<void> updateClass(Class classModel) {
    return _classesCollection.doc(classModel.id).update(classModel.toMap());
  }

  Future<void> deleteClass(String classId) {
    return _classesCollection.doc(classId).delete();
  }
}
