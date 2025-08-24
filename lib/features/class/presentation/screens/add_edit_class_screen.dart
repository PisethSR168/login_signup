import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_signup/features/class/data/models/class_model.dart';
import 'package:login_signup/features/class/data/repositories/class_repository.dart';

class AddEditClassScreen extends StatefulWidget {
  final Class? classModel;

  const AddEditClassScreen({super.key, this.classModel});

  @override
  State<AddEditClassScreen> createState() => _AddEditClassScreenState();
}

class _AddEditClassScreenState extends State<AddEditClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final ClassRepository _classRepository = ClassRepository();

  late String _courseId;
  late String _className;
  late String _teacherId;
  late String _schedule;
  late DateTime _startDate;
  late DateTime _endDate;
  late int _maxStudents;

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _courseId = widget.classModel?.courseId ?? '';
    _className = widget.classModel?.className ?? '';
    _teacherId = widget.classModel?.teacherId ?? '';
    _schedule = widget.classModel?.schedule ?? '';
    _startDate = widget.classModel?.startDate ?? DateTime.now();
    _endDate = widget.classModel?.endDate ?? DateTime.now();
    _maxStudents = widget.classModel?.maxStudents ?? 0;

    _startDateController.text = DateFormat('yyyy-MM-dd').format(_startDate);
    _endDateController.text = DateFormat('yyyy-MM-dd').format(_endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classModel == null ? 'Add Class' : 'Edit Class'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _courseId,
                decoration: const InputDecoration(labelText: 'Course ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a course ID';
                  }
                  return null;
                },
                onSaved: (value) => _courseId = value!,
              ),
              TextFormField(
                initialValue: _className,
                decoration: const InputDecoration(labelText: 'Class Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a class name';
                  }
                  return null;
                },
                onSaved: (value) => _className = value!,
              ),
              TextFormField(
                initialValue: _teacherId,
                decoration: const InputDecoration(labelText: 'Teacher ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a teacher ID';
                  }
                  return null;
                },
                onSaved: (value) => _teacherId = value!,
              ),
              TextFormField(
                initialValue: _schedule,
                decoration: const InputDecoration(labelText: 'Schedule'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a schedule';
                  }
                  return null;
                },
                onSaved: (value) => _schedule = value!,
              ),
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: 'Start Date'),
                readOnly: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _startDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _startDate = pickedDate;
                      _startDateController.text = DateFormat('yyyy-MM-dd').format(_startDate);
                    });
                  }
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(labelText: 'End Date'),
                readOnly: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _endDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _endDate = pickedDate;
                      _endDateController.text = DateFormat('yyyy-MM-dd').format(_endDate);
                    });
                  }
                },
              ),
              TextFormField(
                initialValue: _maxStudents.toString(),
                decoration: const InputDecoration(labelText: 'Max Students'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid number of students';
                  }
                  return null;
                },
                onSaved: (value) => _maxStudents = int.parse(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final classModel = Class(
                      id: widget.classModel?.id,
                      courseId: _courseId,
                      className: _className,
                      teacherId: _teacherId,
                      schedule: _schedule,
                      startDate: _startDate,
                      endDate: _endDate,
                      maxStudents: _maxStudents,
                    );
                    if (widget.classModel == null) {
                      _classRepository.addClass(classModel);
                    } else {
                      _classRepository.updateClass(classModel);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.classModel == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
