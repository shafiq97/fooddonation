// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:feed_food/utils/globals.dart';
import 'package:feed_food/volunteer/donate/payment.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:maps_launcher/maps_launcher.dart';

import '../../utils/routes.dart';
import '../../utils/strings.dart';

class VPendingDetail extends StatefulWidget {
  String senderId;
  String foodId;
  String imgUrl;
  String donationId;

  VPendingDetail(
      {Key? key,
      required this.senderId,
      required this.foodId,
      required this.imgUrl,
      required this.donationId})
      : super(key: key);

  @override
  State<VPendingDetail> createState() => _VPendingDetailState();
}

class _VPendingDetailState extends State<VPendingDetail> {
  String? title;
  String? name;
  String? fname;
  String? accountNo;
  String? cookingTime;
  String? quantity;
  String? address;
  String? phone;
  String? zip;
  String? lat;
  String? long;
  String? mobileNo;

  String status = "0";

  @override
  void initState() {
    // TODO: implement initState
    getFood();
    super.initState();
  }

  // get food details

  Future getFood() async {
    String uri = FeedFoodStrings.ngo_food_details_url;

    try {
      http.Response res = await http.post(Uri.parse(uri), body: {
        'AccountNo': widget.senderId,
        'id': widget.foodId,
      });

      var response = jsonDecode(res.body);

      if (response['success'] == false) {
        // no data in database error 1
        status = "1";
      } else if (response != null) {
        setState(() {
          title = response['food_details'];
          fname = response['fname'];
          name = "${response['fname']} ${response['lname']}";
          cookingTime = response['cooking_time'];
          quantity = response['food_quantity'];
          accountNo = response['sender_account_no'];
          address = "${response['address']} , ${response['zip_code']}";
          lat = response['latitude'];
          long = response['longitude'];
          mobileNo = response['phone'];

          // data in database
          status = "2";
        });
      }
    } catch (e) {
      print(e);

      Navigator.pop(context);
      return false;
    }
  }

  // Accept Food Request
  Future updateFoodStatus(String selectedPackage) async {
    String uri = FeedFoodStrings.volunteer_request;

    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }));

      http.Response res = await http.post(Uri.parse(uri), body: {
        'volunteerId': UserAccountNo,
        'selectedPackage': selectedPackage,
        'foodId': widget.foodId
      });

      var response = jsonDecode(res.body);

      if (response['success'] == true) {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: 'Thank you for your donation',
          desc: 'We appreciate it!',
          btnOkOnPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentPage(),
              ),
            );
          },
        ).show();
      } else {}
    } catch (e) {
      print(e);

      Navigator.pop(context);
      return false;
    }
  }

  void _showDonationPackageModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select a package',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // List of packages
                ListTile(
                  title: const Text('RM 50 - Package A'),
                  onTap: () {
                    // handle package A selected
                    Navigator.pop(context); // Close the modal
                    updateFoodStatus('A'); // Pass the selected package
                  },
                ),
                ListTile(
                  title: const Text('RM 100 - Package B'),
                  onTap: () {
                    // handle package B selected
                    Navigator.pop(context); // Close the modal
                    updateFoodStatus('B'); // Pass the selected package
                  },
                ),
                ListTile(
                  title: const Text('RM 500 - Package C'),
                  onTap: () {
                    // handle package C selected
                    Navigator.pop(context); // Close the modal
                    updateFoodStatus('C'); // Pass the selected package
                  },
                ),
                ListTile(
                  title: const Text('RM 1000 - Package D'),
                  onTap: () {
                    // handle package D selected
                    Navigator.pop(context); // Close the modal
                    updateFoodStatus('D'); // Pass the selected package
                  },
                ),
                ListTile(
                  title: const Text('RM 1000 - Package E'),
                  onTap: () {
                    // handle package E selected
                    Navigator.pop(context); // Close the modal
                    updateFoodStatus('E'); // Pass the selected package
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.light));
    return status == "0"
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Container(
                alignment: Alignment.centerLeft,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Family Detail",
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
            body: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(widget.imgUrl, fit: BoxFit.fill),
                ),
                scroll(),
              ],
            ),
            bottomNavigationBar: SizedBox(
              height: 60,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  _showDonationPackageModal(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B6D3E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    )),
                child: const Text(
                  "Donate",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          );
  }

  scroll() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, ScrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: ScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    title ?? "null",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      // For NGO Profile
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage("assets/images/Profile Pic.png"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      fname == null
                          ? Text(
                              accountNo ?? "",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              name ?? "",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 8,
                    ),
                  ),
                  const Text(
                    "Cooking Time",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    cookingTime ?? "",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Quantity",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "For $quantity People",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 8,
                    ),
                  ),
                  const Text(
                    "Address",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    address ?? "",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Mobile No: $mobileNo',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 6,
                    ),
                  ),
                  lat == null || lat == "null"
                      ? const SizedBox(
                          height: 10,
                        )
                      : TextButton(
                          onPressed: (() {
                            MapsLauncher.launchCoordinates(
                                double.parse(lat!), double.parse(long!));
                          }),
                          child: const Text("open location in map"),
                        ),
                ],
              ),
            ),
          );
        });
  }
}
