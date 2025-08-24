import 'package:flutter/material.dart';
import 'package:login_signup/features/enrollment/data/models/enrollment_model.dart';
import 'package:login_signup/features/enrollment/data/repositories/enrollment_repository.dart';
import 'add_edit_enrollment_screen.dart';

class EnrollmentListScreen extends StatefulWidget {
  const EnrollmentListScreen({super.key});

  @override
  State<EnrollmentListScreen> createState() => _EnrollmentListScreenState();
}

class _EnrollmentListScreenState extends State<EnrollmentListScreen> {
  final EnrollmentRepository _enrollmentRepository = EnrollmentRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrollments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddEditEnrollmentScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Enrollment>>(
        stream: _enrollmentRepository.getEnrollments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final enrollments = snapshot.data ?? [];
          return ListView.builder(
            itemCount: enrollments.length,
            itemBuilder: (context, index) {
              final enrollment = enrollments[index];
              return ListTile(
                title: Text('Student: ${enrollment.studentId}'),
                subtitle: Text('Class: ${enrollment.classId}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditEnrollmentScreen(enrollment: enrollment),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _enrollmentRepository.deleteEnrollment(enrollment.id!);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
