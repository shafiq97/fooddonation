import 'dart:convert';
import 'package:feed_food/ngo/models/n_home_model.dart';
import 'package:feed_food/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../utils/strings.dart';
import '../../widgets/cards.dart';

class NHomePage extends StatefulWidget {
  const NHomePage({super.key});

  @override
  State<NHomePage> createState() => _NHomePageState();
}

class _NHomePageState extends State<NHomePage> {
  String? newStat = "";
  String? pendingStat = "";
  String? completedStat = "";
  List<dynamic> foodRequests = []; // Store the JSON data directly

  @override
  void initState() {
    getFoodRequest();
    super.initState();
  }

  Future<void> getFoodRequest() async {
    var url = FeedFoodStrings.ngo_food_request_url;
    var url2 = FeedFoodStrings.ngo_stat_url;

    try {
      var response =
          await http.post(Uri.parse(url2), body: {"getStat": UserAccountNo});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          newStat = data['new'].toString();
          pendingStat = data['pending'].toString();
          completedStat = data['completed'].toString();
        });
      }
    } catch (e) {
      print("Error fetching statistics: $e");
    }

    try {
      var response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var productsData = data['request'];

        setState(() {
          if (productsData != false) {
            foodRequests = productsData;
          }
        });
      }
    } catch (e) {
      print("Error fetching food requests: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 155, 110, 246),
        statusBarBrightness: Brightness.light));

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 3, 157, 90),
              Color.fromARGB(255, 101, 229, 163)
            ],
          )),
        ),
        title: Text(
          FeedFoodStrings.BrandName,
          style: GoogleFonts.dancingScript(
              fontWeight: FontWeight.w900, fontSize: 28, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: getFoodRequest,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeaderSection(),
              buildFoodRequestSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderSection() {
    return Container(
      height: 25,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 3, 157, 90),
          Color.fromARGB(255, 101, 229, 163)
        ],
      )),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // const SizedBox(height: 5),
            // const Text(
            //   "Request Status",
            //   style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w600,
            //       decoration: TextDecoration.underline),
            // ),
            // const SizedBox(height: 30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     ReqCards(title1: newStat!, title2: "New"),
            //     ReqCards(title1: pendingStat!, title2: "Pending"),
            //     ReqCards(title1: completedStat!, title2: "Completed"),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildFoodRequestSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Family Data",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(height: 20),
            foodRequests.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: foodRequests.length,
                    itemBuilder: (context, index) {
                      var foodRequest = foodRequests[index];
                      return buildFoodRequestItem(foodRequest);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildFoodRequestItem(dynamic foodRequest) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ID: ${foodRequest['id']}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text("Food Details: ${foodRequest['food_details']}"),
          Text("Food Quantity: ${foodRequest['food_quantity']}"),
          Text("Cooking Time: ${foodRequest['cooking_time']}"),
        ],
      ),
    );
  }
}
