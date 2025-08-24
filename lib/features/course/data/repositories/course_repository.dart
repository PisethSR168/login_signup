import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course_model.dart';

class CourseRepository {
  final CollectionReference _coursesCollection = FirebaseFirestore.instance.collection('courses');

  Future<void> addCourse(Course course) {
    return _coursesCollection.add(course.toMap());
  }

  Stream<List<Course>> getCourses() {
    return _coursesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Course.fromFirestore(doc)).toList();
    });
  }

  Future<void> updateCourse(Course course) {
    return _coursesCollection.doc(course.id).update(course.toMap());
  }

  Future<void> deleteCourse(String courseId) {
    return _coursesCollection.doc(courseId).delete();
  }
}
