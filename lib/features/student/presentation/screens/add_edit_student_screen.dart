import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_signup/features/student/data/models/student_model.dart';
import 'package:login_signup/features/student/data/repositories/student_repository.dart';

class AddEditStudentScreen extends StatefulWidget {
  final Student? student;

  const AddEditStudentScreen({super.key, this.student});

  @override
  State<AddEditStudentScreen> createState() => _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final StudentRepository _studentRepository = StudentRepository();

  late String _firstName;
  late String _lastName;
  late String _gender;
  late DateTime _dateOfBirth;
  late String _phoneNumber;
  late String _email;
  late String _address;

  final TextEditingController _dateOfBirthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstName = widget.student?.firstName ?? '';
    _lastName = widget.student?.lastName ?? '';
    _gender = widget.student?.gender ?? 'Male';
    _dateOfBirth = widget.student?.dateOfBirth ?? DateTime.now();
    _phoneNumber = widget.student?.phoneNumber ?? '';
    _email = widget.student?.email ?? '';
    _address = widget.student?.address ?? '';

    _dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(_dateOfBirth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
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
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _gender = newValue!;
                  });
                },
              ),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                readOnly: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dateOfBirth,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateOfBirth = pickedDate;
                      _dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(_dateOfBirth);
                    });
                  }
                },
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
                initialValue: _address,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final student = Student(
                      id: widget.student?.id,
                      firstName: _firstName,
                      lastName: _lastName,
                      gender: _gender,
                      dateOfBirth: _dateOfBirth,
                      phoneNumber: _phoneNumber,
                      email: _email,
                      address: _address,
                    );
                    if (widget.student == null) {
                      _studentRepository.addStudent(student);
                    } else {
                      _studentRepository.updateStudent(student);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.student == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
