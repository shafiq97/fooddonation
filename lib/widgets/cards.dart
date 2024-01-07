// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use

import 'package:feed_food/ngo/home/food_detail.dart';
import 'package:feed_food/ngo/models/n_home_model.dart';
import 'package:feed_food/ngo/pending/n_pending_detail.dart';
import 'package:feed_food/volunteer/donate/v_donate_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'package:feed_food/models/news_model.dart';

class VHomeCard extends StatelessWidget {
  const VHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Food Aid Catalogue",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green[700]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildPackageCard("RM 30 Package - Budget Snack Pack", [
              "Mixed Nuts (150g)",
              "Dried Fruits (100g)",
              "Energy Bars (1)"
            ]),
            const SizedBox(height: 20),
            _buildPackageCard("RM 50 Package - Nutritious Snack Pack", [
              "Mixed Nuts (200g)",
              "Dried Fruits (150g)",
              "Energy Bars (2)"
            ]),
            const SizedBox(height: 20),
            _buildPackageCard("RM 100 Package - Balanced Breakfast Bundle", [
              "Oatmeal Packets (4)",
              "Whole Grain Cereal (250g)",
              "Nut Butter (e.g., almond or peanut butter - 200g)",
              "Honey (100g)",
              "Fruit Preserves (100g)"
            ]),
            const SizedBox(height: 20),
            _buildPackageCard("RM 130 Package - Superfood Mix", [
              "Chia Seeds (150g)",
              "Quinoa (250g)",
              "Mixed Berries (dried or freeze-dried - 150g)",
              "Green Tea (1 box)"
            ]),
            const SizedBox(height: 20),
            _buildPackageCard("RM 150 Package - Protein Power Pack", [
              "Protein Bars (4)",
              "Trail Mix with Seeds (200g)",
              "Greek Yogurt (3 small cups)",
              "Protein Powder (single-serving - 4)"
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(String title, List<String> items) {
    return Container(
      width: double.infinity, // Ensures the container fills the width
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[600],
                ),
              ),
              const SizedBox(height: 10),
              ...items
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(item),
                      ))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}

class TileCrad extends StatelessWidget {
  final String title_text;
  final String image_url;
  final String openUrl;
  const TileCrad(
      {super.key,
      required this.title_text,
      required this.image_url,
      required this.openUrl});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Volunteer home page card
class NewsCards extends StatelessWidget {
  // we need list of articles
  final Articles articles;
  String str = "";
  NewsCards({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              FadeInImage(
                placeholder: const AssetImage("assets/images/news_default.jpg"),
                image: NetworkImage(
                  articles.urlToImage,
                ),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: const Text(
                      'Whoops!',
                      style: TextStyle(fontSize: 30),
                    ),
                  );
                },
              ),
              // Image.network(
              //   articles.urlToImage,
              //   errorBuilder: (context, error, stackTrace) {
              //     return Text("can't load image");
              //   },
              // ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: Color(0xFF0B6D3E),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      articles.author,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      articles.title,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              TextButton(
                  onPressed: (() async {
                    await FlutterWebBrowser.openWebPage(
                      url: articles.url,
                      customTabsOptions: const CustomTabsOptions(
                        colorScheme: CustomTabsColorScheme.dark,
                        // ignore: deprecated_member_use
                        toolbarColor: Color(0xFF0B6D3E),
                        secondaryToolbarColor: Colors.green,
                        navigationBarColor: Colors.amber,
                        shareState: CustomTabsShareState.on,
                        instantAppsEnabled: true,
                        showTitle: true,
                        urlBarHidingEnabled: true,
                      ),
                    );
                  }),
                  child: const Text(
                    "read more",
                    style: TextStyle(),
                  )),
            ],
          ),
        ));
  }

  // strConvert() {
  //   str = articles.title;
  //   return str.substring(0, 90) + "...";
  // }
}

class NRequestCards extends StatelessWidget {
  // we need list of articles
  final NgoFoodRequestModel foodRequest;

  NRequestCards({super.key, required this.foodRequest});

  String str = "";

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

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NFoodDetail(
                senderId: foodRequest.SenderAccountNo,
                foodId: foodRequest.id,
                imgUrl: imagePath.toString(),
              ),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath!),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodRequest.FoodDetails,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                  Text(
                    "Food for ${foodRequest.FoodQuantity} peoples",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w300),
                  ),
                  // Text(
                  //   "Cooking Time ${foodRequest.CookingTime}",
                  //   style: const TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 10,
                  //       fontWeight: FontWeight.w300),
                  // ),
                  Text(
                    "Location : ${"${foodRequest.Address}, ${foodRequest.ZipCode}"}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NPendingCard extends StatelessWidget {
  // we need list of articles
  final NgoFoodRequestModel foodRequest;

  NPendingCard({super.key, required this.foodRequest});

  String str = "";

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

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NPendingDetail(
                senderId: foodRequest.SenderAccountNo,
                foodId: foodRequest.id,
                imgUrl: imagePath.toString(),
                donationId: foodRequest.donationId,
              ),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath!),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodRequest.FoodDetails,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                  Text(
                    "Food for ${foodRequest.FoodQuantity} peoples",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w300),
                  ),
                  // Text(
                  //   "Cooking Time ${foodRequest.CookingTime}",
                  //   style: const TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 10,
                  //       fontWeight: FontWeight.w300),
                  // ),
                  Text(
                    "Location : ${"${foodRequest.Address}, ${foodRequest.ZipCode}"}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        color: const Color(0xFF0B6D3E),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          child: Text(
                            "pending",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NCompleteCard extends StatelessWidget {
  // we need list of articles
  final NgoFoodRequestModel foodRequest;

  NCompleteCard({super.key, required this.foodRequest});

  String str = "";

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

    return Card(
      child: InkWell(
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath!),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodRequest.FoodDetails,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                  Text(
                    "Food for ${foodRequest.FoodQuantity} peoples",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w300),
                  ),
                  // Text(
                  //   "Cooking Time ${foodRequest.CookingTime}",
                  //   style: const TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 10,
                  //       fontWeight: FontWeight.w300),
                  // ),
                  Text(
                    "Location : ${"${foodRequest.Address}, ${foodRequest.ZipCode}"}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(20),
                  //   child: Container(
                  //       color: Colors.green[400],
                  //       child: const Padding(
                  //         padding:
                  //             EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  //         child: Text(
                  //           "Completed",
                  //           style: TextStyle(fontSize: 12, color: Colors.white),
                  //         ),
                  //       )),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VProfilNumberData extends StatefulWidget {
  String title_text;
  String number_text;
  VProfilNumberData({
    super.key,
    required this.title_text,
    required this.number_text,
  });

  @override
  State<VProfilNumberData> createState() => _VProfilNumberDataState();
}

class _VProfilNumberDataState extends State<VProfilNumberData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.number_text,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        Text(widget.title_text,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class ReqCards extends StatelessWidget {
  final String title1;
  final String title2;

  const ReqCards({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 85,
          width: 85,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title1,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(title2, style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
