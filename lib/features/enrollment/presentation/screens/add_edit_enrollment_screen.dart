import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_signup/features/enrollment/data/models/enrollment_model.dart';
import 'package:login_signup/features/enrollment/data/repositories/enrollment_repository.dart';

class AddEditEnrollmentScreen extends StatefulWidget {
  final Enrollment? enrollment;

  const AddEditEnrollmentScreen({super.key, this.enrollment});

  @override
  State<AddEditEnrollmentScreen> createState() => _AddEditEnrollmentScreenState();
}

class _AddEditEnrollmentScreenState extends State<AddEditEnrollmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final EnrollmentRepository _enrollmentRepository = EnrollmentRepository();

  late String _studentId;
  late String _classId;
  late DateTime _enrollmentDate;
  late String _status;
  late String _paymentStatus;

  final TextEditingController _enrollmentDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _studentId = widget.enrollment?.studentId ?? '';
    _classId = widget.enrollment?.classId ?? '';
    _enrollmentDate = widget.enrollment?.enrollmentDate ?? DateTime.now();
    _status = widget.enrollment?.status ?? 'Active';
    _paymentStatus = widget.enrollment?.paymentStatus ?? 'Paid';

    _enrollmentDateController.text = DateFormat('yyyy-MM-dd').format(_enrollmentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.enrollment == null ? 'Add Enrollment' : 'Edit Enrollment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _studentId,
                decoration: const InputDecoration(labelText: 'Student ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a student ID';
                  }
                  return null;
                },
                onSaved: (value) => _studentId = value!,
              ),
              TextFormField(
                initialValue: _classId,
                decoration: const InputDecoration(labelText: 'Class ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a class ID';
                  }
                  return null;
                },
                onSaved: (value) => _classId = value!,
              ),
              TextFormField(
                controller: _enrollmentDateController,
                decoration: const InputDecoration(labelText: 'Enrollment Date'),
                readOnly: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _enrollmentDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _enrollmentDate = pickedDate;
                      _enrollmentDateController.text = DateFormat('yyyy-MM-dd').format(_enrollmentDate);
                    });
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Active', 'Completed', 'Dropped'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _paymentStatus,
                decoration: const InputDecoration(labelText: 'Payment Status'),
                items: ['Paid', 'Unpaid'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _paymentStatus = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final enrollment = Enrollment(
                      id: widget.enrollment?.id,
                      studentId: _studentId,
                      classId: _classId,
                      enrollmentDate: _enrollmentDate,
                      status: _status,
                      paymentStatus: _paymentStatus,
                    );
                    if (widget.enrollment == null) {
                      _enrollmentRepository.addEnrollment(enrollment);
                    } else {
                      _enrollmentRepository.updateEnrollment(enrollment);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.enrollment == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
