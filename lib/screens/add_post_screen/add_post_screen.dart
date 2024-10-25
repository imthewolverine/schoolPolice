import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_post_bloc.dart';
import 'add_post_event.dart';
import 'add_post_state.dart';

class AddPostScreen extends StatelessWidget {
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostBloc(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text('Зар оруулах', style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: BlocListener<AddPostBloc, AddPostState>(
          listener: (context, state) {
            if (state is AddPostSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Post submitted successfully!')),
              );
              Navigator.pop(context);
            } else if (state is AddPostFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(_schoolController, 'Сургууль',
                        'Сургуулийн нэр оруулна уу.'),
                    _buildDropdownField(context, 'Дүүрэг'),
                    _buildShiftToggle(),
                    _buildSalarySlider(),
                    _buildTextField(
                        _additionalInfoController,
                        'Нэмэлт мэдээлэл',
                        'Энд дарж нэмэлт мэдээллийг оруулна уу.'),
                    Spacer(),
                    _buildSubmitButton(context),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildDropdownField(BuildContext context, String label) {
    // Dropdown widget for District selection
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: null,
            hint: Text('Дүүрэг сонгох'),
            items: <String>['Дүүрэг 1', 'Дүүрэг 2', 'Дүүрэг 3']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              // Handle district selection
            },
          ),
        ),
      ),
    );
  }

  Widget _buildShiftToggle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ээлж', style: TextStyle(fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // Handle morning shift selection
                  },
                  child: Column(
                    children: [
                      Text('Өглөө'),
                      Text('07:30-12:30', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // Handle day shift selection
                  },
                  child: Column(
                    children: [
                      Text('Өдөр'),
                      Text('12:30-18:30', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalarySlider() {
    double minSalary = 50000;
    double maxSalary = 120000;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Цалин', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 2.0,
                    activeTrackColor: Colors.black,
                    inactiveTrackColor: Colors.grey[300],
                    thumbColor: Colors.black,
                  ),
                  child: RangeSlider(
                    values: RangeValues(minSalary, maxSalary),
                    min: 50000,
                    max: 120000,
                    divisions: 14,
                    labels: RangeLabels('50K', '120K'),
                    onChanged: (RangeValues values) {
                      minSalary = values.start;
                      maxSalary = values.end;
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text('${minSalary.toInt()}K - ${maxSalary.toInt()}K'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<AddPostBloc>(context).add(
            SubmitPostEvent(
              school: _schoolController.text,
              district: _districtController.text,
              shift: 'Өглөө', // Example shift value
              time: '07:30-12:30', // Example time
              salary: '50000-120000', // Example salary
              additionalInfo: _additionalInfoController.text,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          backgroundColor: Colors.red, // Submit button color
        ),
        child: Text('Нийтлэх', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
