import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../utils/globals.dart';
import '../../utils/strings.dart';
import '../../widgets/dialogue_box.dart';

class NProfile extends StatefulWidget {
  const NProfile({super.key});

  @override
  State<NProfile> createState() => _NProfileState();
}

class _NProfileState extends State<NProfile> {
  String? name;
  String? email;
  String? address;
  String? phoneNo;
  bool data = false;

  @override
  void initState() {
    userProfile();
    super.initState();
  }

  Future userProfile() async {
    String uri = FeedFoodStrings.ngo_profile_url;

    try {
      http.Response res =
          await http.post(Uri.parse(uri), body: {'accountNo': UserAccountNo});
      var response = jsonDecode(res.body);

      setState(() {
        if (response['fname'] != null) {
          name = response['fname'] + " " + response['lname'];
        }
        address = response['address'] != null
            ? response['address'] + " " + response['pincode']
            : null;
        email = response['email'] ?? '';
        phoneNo = response['phone'] ?? '';
        data = true;
      });
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: !data
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                          "assets/images/ngo_profile.png"), // Replace with your asset image
                    ),
                    const SizedBox(height: 20),
                    Text(name ?? "NGO Name",
                        style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 10),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.account_circle,
                          color: Theme.of(context).primaryColor),
                      title: Text(name ?? "NGO Name"),
                    ),
                    ListTile(
                      leading: Icon(Icons.email,
                          color: Theme.of(context).primaryColor),
                      title: Text(email ?? "Email Address"),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone,
                          color: Theme.of(context).primaryColor),
                      title: Text(phoneNo ?? "Phone Number"),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on,
                          color: Theme.of(context).primaryColor),
                      title: Text(address ?? "Address"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                MyDialogue().logotDialogue(context));
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18, // Specify the font size if you want
                          color: Colors.white, // Setting text color to white
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
