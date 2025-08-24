import 'package:flutter/material.dart';
import 'package:login_signup/features/teacher/data/models/teacher_model.dart';
import 'package:login_signup/features/teacher/data/repositories/teacher_repository.dart';

class AddEditTeacherScreen extends StatefulWidget {
  final Teacher? teacher;

  const AddEditTeacherScreen({super.key, this.teacher});

  @override
  State<AddEditTeacherScreen> createState() => _AddEditTeacherScreenState();
}

class _AddEditTeacherScreenState extends State<AddEditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  final TeacherRepository _teacherRepository = TeacherRepository();

  late String _firstName;
  late String _lastName;
  late String _phoneNumber;
  late String _email;
  late List<String> _specialization;

  final TextEditingController _specializationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstName = widget.teacher?.firstName ?? '';
    _lastName = widget.teacher?.lastName ?? '';
    _phoneNumber = widget.teacher?.phoneNumber ?? '';
    _email = widget.teacher?.email ?? '';
    _specialization = widget.teacher?.specialization ?? [];

    _specializationController.text = _specialization.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teacher == null ? 'Add Teacher' : 'Edit Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _firstName,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
                onSaved: (value) => _firstName = value!,
              ),
              TextFormField(
                initialValue: _lastName,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
                onSaved: (value) => _lastName = value!,
              ),
              TextFormField(
                initialValue: _phoneNumber,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
                onSaved: (value) => _phoneNumber = value!,
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                controller: _specializationController,
                decoration: const InputDecoration(labelText: 'Specialization (comma-separated)'),
                onSaved: (value) => _specialization = value!.split(',').map((s) => s.trim()).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final teacher = Teacher(
                      id: widget.teacher?.id,
                      firstName: _firstName,
                      lastName: _lastName,
                      phoneNumber: _phoneNumber,
                      email: _email,
                      specialization: _specialization,
                    );
                    if (widget.teacher == null) {
                      _teacherRepository.addTeacher(teacher);
                    } else {
                      _teacherRepository.updateTeacher(teacher);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.teacher == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
