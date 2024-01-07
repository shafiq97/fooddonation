import 'dart:convert';

import 'package:feed_food/ngo/models/n_home_model.dart';
import 'package:feed_food/utils/globals.dart';
import 'package:feed_food/volunteer/donate/v_pending_detail.dart';
import 'package:feed_food/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../utils/strings.dart';

class VDonatePage extends StatefulWidget {
  const VDonatePage({super.key});

  @override
  State<VDonatePage> createState() => _VDonatePageState();
}

class _VDonatePageState extends State<VDonatePage> {
  bool foodlist = true;
  bool foodData = false;

  @override
  void initState() {
    // TODO: implement initState
    _getCompleted();
    super.initState();
  }

  _getCompleted() async {
    var url = FeedFoodStrings.ngo_food_complete_url;

    try {
      // Make a GET request to the API endpoint
      var response = await http.post(Uri.parse(url),
          body: ({'FoodRequestComplete': UserAccountNo}));

      if (response.statusCode == 200) {
        // Decode the JSON data from the response
        var data = jsonDecode(response.body);
        // Return the list of articles from the API
        var products_data = data['request'];

        if (products_data == false) {
          setState(() {
            foodlist = false;
          });
        } else {
          setState(() {
            foodData = true;
          });
          NgoFoodRequest.requestList = List.from(products_data)
              .map<NgoFoodRequestModel>(
                  (item) => NgoFoodRequestModel.fromMap(item))
              .toList();
        }
      } else {
        // If the response was not successful, throw an error
        print("not connectd");
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  List<String> randomImages = [
    "assets/images/nHome1.png",
    "assets/images/nHome2.png",
    "assets/images/nHome3.png",
    "assets/images/nHome4.jpg",
    "assets/images/nHome5.jpg",
    "assets/images/nHome6.jpg",
    "assets/images/nHome7.jpg",
    "assets/images/nHome8.jpg",
    "assets/images/nHome9.jpg",
    "assets/images/nHome10.jpg",
  ];
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    randomImages.shuffle();
    imagePath = randomImages[0];
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Container(
          alignment: Alignment.centerLeft,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Family Details",
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
      body: foodlist == true && foodData == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : foodlist == false
              ? const SizedBox(
                  height: 300,
                  child: Center(
                    child: Text("You didn't complete any food request"),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    itemCount: NgoFoodRequest.requestList.length,
                    itemBuilder: (context, index) {
                      // Accessing individual item from the list
                      var foodRequestItem = NgoFoodRequest.requestList[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VPendingDetail(
                                senderId: foodRequestItem.SenderAccountNo,
                                foodId: foodRequestItem.id,
                                imgUrl: imagePath.toString(),
                                donationId: foodRequestItem.donationId,
                              ),
                            ),
                          );
                        },
                        child: NCompleteCard(
                          foodRequest:
                              foodRequestItem, // Passing the individual food request to the card
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
