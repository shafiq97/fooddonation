import 'dart:developer';
import 'package:feed_food/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VDonatePage extends StatefulWidget {
  const VDonatePage({Key? key}) : super(key: key);

  @override
  _VDonatePageState createState() => _VDonatePageState();
}

class _VDonatePageState extends State<VDonatePage> {
  final _formKey = GlobalKey<FormState>();

  List<String> _dropdownValues = [];
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _fetchDropdownValues();
  }

  Future<void> _fetchDropdownValues() async {
    var url = Uri.parse(FeedFoodStrings.dropdown);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        _dropdownValues = List<String>.from(jsonResponse);
      });
    } else {
      log('Failed to load dropdown values');
    }
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepPurple, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedValue,
          hint: const Text('Select Package'),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down_circle,
              color: Colors.deepPurple),
          onChanged: (newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
          items: _dropdownValues.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Donation'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Select a food package to donate:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              _buildDropdown(),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Submit donation package
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Donate Now',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              // Add more widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}
