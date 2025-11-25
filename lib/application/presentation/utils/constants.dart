import 'package:flutter/material.dart';

/// Asset Paths
const onboardingBgImg = 'assets/images/bg_onbarding_image.png';
const screenBgImage = 'assets/images/bg_screen_img.png';
const applogo = 'assets/images/app_logo.png';

// Onboarding Asset Paths

// Floating illustrations
const String imgStopWatch = "assets/images/Blue stopwatch with pink arrow.png";
const String imgPieChart = "assets/images/pie chart.png";
const String imgGirlLaptop =
    "assets/images/female sitting on the floor with cup in hand and laptop on leg.png";
const String imgDeskCal = "assets/images/Blue desk calendar.png";
const String imgVase = "assets/images/vase with tulips, glasses and pencil.png";
const String imgPinkCup = "assets/images/close up of pink coffee cup.png";
const String imgNotifications =
    "assets/images/multicolored smartphone notifications.png";

/// Error Message
const errorMessage = 'Something went wrong. Please try again.';

///  Reusable Spacing Widgets
adjustWidth(double width) {
  return SizedBox(width: width);
}

adjustHieght(double height) {
  return SizedBox(height: height);
}

///  Border Radius Constants
BorderRadius kBorderRadius6 = BorderRadius.circular(6);
BorderRadius kBorderRadius5 = BorderRadius.circular(5);
BorderRadius kBorderRadius8 = BorderRadius.circular(8);
BorderRadius kBorderRadius12 = BorderRadius.circular(12);
BorderRadius kBorderRadius16 = BorderRadius.circular(16);
BorderRadius kBorderRadius20 = BorderRadius.circular(20);
BorderRadius kBorderRadius24 = BorderRadius.circular(24);
BorderRadius kBorderRadius50 = BorderRadius.circular(50);
BorderRadius kBorderRadius10 = BorderRadius.circular(10);

enum Validate {
  phone,
  mobOrLandline,
  email,
  password,
  none,
  rePassword,
  adminEmail,
  notNull,
  territory,
  ifsc,
  upi,
  gst,
  website,
  ifValidnumber,
  ifValidWebsite,
  ifValidEmail,
  emailOrPhone,
  pincode,
  panNumber,
  dateOfBirth,
  accountHolderName,
  accountNumber,
}
