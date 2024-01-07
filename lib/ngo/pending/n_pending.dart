import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:feed_food/ngo/models/n_home_model.dart';
import 'package:feed_food/utils/globals.dart';
import 'package:feed_food/utils/strings.dart';
import 'package:feed_food/widgets/cards.dart';

class nPendingRequest extends StatefulWidget {
  const nPendingRequest({super.key});

  @override
  State<nPendingRequest> createState() => _nPendingRequestState();
}

class _nPendingRequestState extends State<nPendingRequest> {
  bool isLoading = true; // Indicates if you're currently fetching data
  List<NgoFoodRequestModel> requestList = []; // Holds the list of requests

  @override
  void initState() {
    super.initState();
    _getPending();
  }

  _getPending() async {
    var url = FeedFoodStrings.ngo_food_pending_url;

    try {
      var response = await http
          .post(Uri.parse(url), body: {'FoodRequestPending': UserAccountNo});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var productsData = data['request'];

        if (productsData != false && productsData is List) {
          List<NgoFoodRequestModel> tempList = [];

          for (var item in productsData) {
            tempList.add(NgoFoodRequestModel.fromMap(item));
          }

          setState(() {
            requestList = tempList; // Update the list
            isLoading = false; // Data fetching is complete
          });
        } else {
          setState(() {
            isLoading = false; // Data fetched but list might be empty
          });
        }
      } else {
        print("not connected");
        setState(() {
          isLoading = false; // Ensure that even on error, loading stops
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false; // Ensure that even on error, loading stops
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Pending",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : requestList.isEmpty
              ? const Center(child: Text("Nothing is pending")) // No data view
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    itemCount: requestList.length,
                    itemBuilder: ((context, index) {
                      return NPendingCard(foodRequest: requestList[index]);
                    }),
                  ),
                ),
    );
  }
}
