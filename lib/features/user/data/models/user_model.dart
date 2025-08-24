import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String? id;
  final String email;
  final String role;
  final String relatedId;

  AppUser({
    this.id,
    required this.email,
    required this.role,
    required this.relatedId,
  });

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return AppUser(
      id: doc.id,
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      relatedId: data['relatedId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
      'relatedId': relatedId,
    };
  }
}
