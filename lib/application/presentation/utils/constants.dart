import 'package:flutter/material.dart';

/// Asset Paths
const appLogo = 'assets/images/kathalan_logo.png';

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
