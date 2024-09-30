import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/ad.dart';
import 'add_post_bloc.dart';
import 'add_post_event.dart';
import 'add_post_state.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _shiftController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _additionalInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Post'),
        ),
        body: BlocListener<AddPostBloc, AddPostState>(
          listener: (context, state) {
            if (state is AddPostSuccess) {
              // Create a new Ad object with the entered information
              final newAd = Ad(
                id: DateTime.now().toString(),
                userName: 'New User',
                profilePic: 'https://example.com/new_profile.jpg',
                address: _districtController.text,
                price: _salaryController.text,
                date: '2024-09-30',
                shift: _shiftController.text,
                additionalInfo: _additionalInfoController.text,
              );

              // Pass the new ad back to HomeScreen
              Navigator.pop(context, newAd);
            } else if (state is AddPostFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<AddPostBloc, AddPostState>(
            builder: (context, state) {
              if (state is AddPostLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(_schoolController, 'School'),
                      _buildTextField(_districtController, 'District'),
                      _buildTextField(_shiftController, 'Shift (Morning/Day)'),
                      _buildTextField(_timeController, 'Time'),
                      _buildTextField(_salaryController, 'Salary'),
                      _buildTextField(_additionalInfoController, 'Additional Info'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Accessing the AddPostBloc and adding the SubmitPostEvent
                            BlocProvider.of<AddPostBloc>(context).add(
                              SubmitPostEvent(
                                school: _schoolController.text,
                                district: _districtController.text,
                                shift: _shiftController.text,
                                time: _timeController.text,
                                salary: _salaryController.text,
                                additionalInfo: _additionalInfoController.text,
                              ),
                            );
                          }
                        },
                        child: Text('Add Post'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}

