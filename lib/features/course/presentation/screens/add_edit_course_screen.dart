import 'package:flutter/material.dart';
import 'package:login_signup/features/course/data/models/course_model.dart';
import 'package:login_signup/features/course/data/repositories/course_repository.dart';

class AddEditCourseScreen extends StatefulWidget {
  final Course? course;

  const AddEditCourseScreen({super.key, this.course});

  @override
  State<AddEditCourseScreen> createState() => _AddEditCourseScreenState();
}

class _AddEditCourseScreenState extends State<AddEditCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final CourseRepository _courseRepository = CourseRepository();

  late String _courseName;
  late String _description;
  late int _durationInMonths;
  late double _fee;

  @override
  void initState() {
    super.initState();
    _courseName = widget.course?.courseName ?? '';
    _description = widget.course?.description ?? '';
    _durationInMonths = widget.course?.durationInMonths ?? 0;
    _fee = widget.course?.fee ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? 'Add Course' : 'Edit Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _courseName,
                decoration: const InputDecoration(labelText: 'Course Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a course name';
                  }
                  return null;
                },
                onSaved: (value) => _courseName = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _durationInMonths.toString(),
                decoration: const InputDecoration(labelText: 'Duration (Months)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid duration';
                  }
                  return null;
                },
                onSaved: (value) => _durationInMonths = int.parse(value!),
              ),
              TextFormField(
                initialValue: _fee.toString(),
                decoration: InputDecoration(labelText: 'Fee (\$)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Please enter a valid fee';
                  }
                  return null;
                },
                onSaved: (value) => _fee = double.parse(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final course = Course(
                      id: widget.course?.id,
                      courseName: _courseName,
                      description: _description,
                      durationInMonths: _durationInMonths,
                      fee: _fee,
                    );
                    if (widget.course == null) {
                      _courseRepository.addCourse(course);
                    } else {
                      _courseRepository.updateCourse(course);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.course == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}