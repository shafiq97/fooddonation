import 'dart:convert';
import 'package:feed_food/ngo/models/n_home_model.dart';
import 'package:feed_food/utils/globals.dart';
import 'package:feed_food/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../utils/strings.dart';

class nPendingRequest extends StatefulWidget {
  const nPendingRequest({super.key});

  @override
  State<nPendingRequest> createState() => _nPendingRequestState();
}

class _nPendingRequestState extends State<nPendingRequest> {
  bool foodlist = true;
  bool foodData = false;

  @override
  void initState() {
    // TODO: implement initState
    _getPending();
    super.initState();
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
            NgoFoodRequest.requestList = tempList;
            foodlist = true; // Indicates that the list has items
            foodData = true; // Indicates that data has been fetched
          });
        } else {
          setState(() {
            foodlist = false;
            foodData = true; // Data fetched but list might be empty
          });
        }
      } else {
        print("not connected");
      }
    } catch (e) {
      print(e);
      setState(() {
        foodData = true; // Ensure that even on error, loading stops
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Container(
          alignment: Alignment.centerLeft,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pending",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      body: !foodlist
          ? const Center(child: Text("Nothing is pending"))
          : foodData &&
                  NgoFoodRequest.requestList
                      .isNotEmpty // Check if data is loaded and list is not empty
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    itemCount: NgoFoodRequest.requestList.length,
                    itemBuilder: ((context, index) {
                      return NPendingCard(
                          foodRequest: NgoFoodRequest.requestList[index]);
                    }),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
