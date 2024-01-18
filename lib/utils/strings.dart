// Author: Prachi Nathjogi
// Author: Digambar Chaudhari

// ignore_for_file: constant_identifier_names

class FeedFoodStrings {
  // Network
  // web
  // static const url = "http://localhost/feedfood";
  // phone
  static const url = "http://10.0.2.2/feedfood";

  static const register_url_volunteer = "$url/app/authentication/register.php";

  static const register_url_ngo = "$url/app/authentication/register_ngo.php";
  static const dropdown = "$url/app/package_dropdown.php";

  static const register_vaildate_url =
      "$url/app/authentication/user_email_check.php";

  static const login_url = "$url/app/authentication/login.php";

  static const forgot_pass_url = "$url/app/authentication/forgotpass.php";

  static const volunteer_post_url = "$url/app/volunteer/request2.php";

  static const volunteer_history_url = "$url/app/volunteer/history.php";
  static const volunteer_profile_url = "$url/app/volunteer/profile.php";
  static const volunteer_update_profile_url = "$url/app/volunteer/profile.php";

  static const volunteer_stat_profile_url = "$url/app/volunteer/stat.php";
  static const volunteer_request = "$url/app/volunteer/request.php";
  static const volunteer_update_complete_food_url =
      "$url/app/volunteer/update_complete.php";

  // NGO
  static const ngo_food_request_url = "$url/app/ngo/food_request.php";
  static const ngo_food_pending_url = "$url/app/ngo/food_pending.php";
  static const ngo_food_complete_url = "$url/app/ngo/food_complete.php";
  static const ngo_food_details_url = "$url/app/ngo/food_details.php";
  static const ngo_stat_url = "$url/app/ngo/stat.php";
  static const ngo_update_food_url = "$url/app/ngo/update.php";
  static const ngo_update_complete_food_url =
      "$url/app/ngo/update_complete.php";
  static const ngo_profile_url = "$url/app/ngo/profile.php";
  static const ngo_history_url = "$url/app/ngo/history.php";
  static const ngo_update_image = "$url/app/ngo/update_image.php";

  // Other NGO Information
  static const ngo_url1 = "https://foodaidfoundation.org/";
  static const ngo_url2 = "https://www.yfbm.org/";

  static const ngo_url3 = "https://www.wateraid.org/";
  static const ngo_url4 = "https://.org/";

  // walkthrough
  static const Whead1 = "No Food Waste";
  static const Whead2 = "We're in it together.";
  static const Whead3 = "Just one tap.";

  static const subtittle1 =
      "One third of all food produced is lost or wasted around 1.3 billion tonnes of food.";
  static const subtittle2 = "We can be the generation that ends hunger.";
  static const subtittle3 =
      "Make a difference in people's lives with just one tap.";

  // Pages
  static const BrandName = "GIVE'M";
}
