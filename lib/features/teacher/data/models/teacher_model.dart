import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  final String? id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final List<String> specialization;

  Teacher({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.specialization,
  });

  factory Teacher.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Teacher(
      id: doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'] ?? '',
      specialization: List<String>.from(data['specialization'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'specialization': specialization,
    };
  }
}
