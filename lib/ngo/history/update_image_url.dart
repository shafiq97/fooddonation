// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:feed_food/models/food_post_model.dart';
import 'package:feed_food/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

class UpdateImageModal extends StatefulWidget {
  final FoodPostHistoryModel foodPostHistory;

  UpdateImageModal({Key? key, required this.foodPostHistory}) : super(key: key);

  @override
  _UpdateImageModalState createState() => _UpdateImageModalState();
}

class _UpdateImageModalState extends State<UpdateImageModal> {
  final TextEditingController _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text field with the current image URL if needed
    _imageController.text = widget.foodPostHistory.ImgUrl ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Image URL'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _imageController,
            decoration: const InputDecoration(labelText: 'Enter new Image URL'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement the update logic
              _updateImageURL();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _updateImageURL() async {
    String apiUrl =
        FeedFoodStrings.ngo_update_image; // Replace with your API endpoint
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'donationId':
              widget.foodPostHistory.DonationId, // Use the correct identifier
          'newImageUrl': _imageController.text,
        },
      );

      if (response.statusCode == 200) {
        await _sendEmail(
            widget.foodPostHistory.DonorEmail, _imageController.text);

        // Handle successful update
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Image URL updated successfully!"),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        // Handle failure
      }
    } catch (e) {
      // Handle any errors here
    }
  }

  Future<void> _sendEmail(String recipient, String imageUrl) async {
    String emailApiUrl =
        FeedFoodStrings.send_email; // Replace with your actual PHP API endpoint
    try {
      var response = await http.post(
        Uri.parse(emailApiUrl),
        body: {
          'recipient': recipient,
          'imageUrl': imageUrl,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful email sending
        log('Email sent successfully via PHP backend');
      } else {
        // Handle failure
        log('Failed to send email via PHP backend: ${response.body}');
      }
    } catch (e) {
      log('Error sending email via PHP backend: $e');
    }
  }
}
