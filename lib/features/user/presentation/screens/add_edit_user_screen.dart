import 'package:flutter/material.dart';
import 'package:login_signup/features/user/data/models/user_model.dart';
import 'package:login_signup/features/user/data/repositories/user_repository.dart';

class AddEditUserScreen extends StatefulWidget {
  final AppUser? user;

  const AddEditUserScreen({super.key, this.user});

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserRepository _userRepository = UserRepository();

  late String _email;
  late String _role;
  late String _relatedId;

  @override
  void initState() {
    super.initState();
    _email = widget.user?.email ?? '';
    _role = widget.user?.role ?? 'Student';
    _relatedId = widget.user?.relatedId ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Add User' : 'Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
              DropdownButtonFormField<String>(
                value: _role,
                decoration: const InputDecoration(labelText: 'Role'),
                items: ['Admin', 'Teacher', 'Student'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _role = newValue!;
                  });
                },
              ),
              TextFormField(
                initialValue: _relatedId,
                decoration: const InputDecoration(labelText: 'Related ID'),
                onSaved: (value) => _relatedId = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final user = AppUser(
                      id: widget.user?.id,
                      email: _email,
                      role: _role,
                      relatedId: _relatedId,
                    );
                    if (widget.user == null) {
                      _userRepository.addUser(user);
                    } else {
                      _userRepository.updateUser(user);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.user == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
