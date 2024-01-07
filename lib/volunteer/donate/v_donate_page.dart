import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:feed_food/utils/globals.dart'; // Ensure this contains UserAccountNo
import 'package:feed_food/utils/strings.dart'; // Ensure this contains the URLs

class VDonatePage extends StatefulWidget {
  const VDonatePage({Key? key}) : super(key: key);

  @override
  _VDonatePageState createState() => _VDonatePageState();
}

class _VDonatePageState extends State<VDonatePage> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> _dropdownValues = []; // Changed to a list of maps
  Map<String, dynamic>? _selectedValue; // To hold the selected item

  @override
  void initState() {
    super.initState();
    _fetchDropdownValues();
  }

  Future<void> _fetchDropdownValues() async {
    var url = Uri.parse(FeedFoodStrings.dropdown);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          _dropdownValues = jsonResponse.map((item) {
            return {
              "id": item['foodId'], // Capture both id and details
              "details": item['foodDetails'],
            };
          }).toList();
        });
      } else {
        log('Failed to load dropdown values');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF0B6D3E), width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Map<String, dynamic>>(
          value: _selectedValue,
          hint: const Text('Select Package'),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down_circle,
              color: Color(0xFF0B6D3E)),
          onChanged: (newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
          items: _dropdownValues.map((Map<String, dynamic> item) {
            return DropdownMenuItem<Map<String, dynamic>>(
              value: item,
              child: Text(item["details"]), // Displaying the food details
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> sendPostRequest() async {
    if (_selectedValue == null) {
      print('No food package selected.');
      return; // Optionally, show an alert/dialog that no option was selected
    }
    String foodId = _selectedValue!["id"]; // Extract just the ID

    String apiURL = FeedFoodStrings.volunteer_request;

    try {
      final response = await http.post(
        Uri.parse(apiURL),
        body: {
          'volunteerId':
              UserAccountNo, // Assuming UserAccountNo is a global variable containing the user's account number
          'foodId': foodId, // The selected food package ID (only the ID)
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          print('Data inserted successfully');
          // Handle successful response
        } else {
          print('Failed to insert data');
          // Handle failure response
        }
      } else {
        print('Failed to insert data. Status code: ${response.statusCode}');
        // Handle HTTP error response
      }
    } catch (e) {
      print(e.toString());
      // Handle network/error exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Donation'),
        backgroundColor: Color(0xFF0B6D3E),
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
                  sendPostRequest();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF0B6D3E),
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
