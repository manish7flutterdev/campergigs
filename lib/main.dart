
import 'package:campergigs/src/ui/activities.dart';
import 'package:campergigs/src/ui/activte_account.dart';
import 'package:campergigs/src/ui/contact.dart';
import 'package:campergigs/src/ui/destination.dart';
import 'package:campergigs/src/ui/destination_detail_logged_in.dart';
import 'package:campergigs/src/ui/discover.dart';
import 'package:campergigs/src/ui/reset_password.dart';
import 'package:campergigs/src/ui/search_result.dart';
import 'package:campergigs/src/ui/signin.dart';
import 'package:campergigs/src/ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campergigs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Signin(),
    );
  }
}
