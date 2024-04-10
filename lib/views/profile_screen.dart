import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    String displayName = user?.displayName ?? "No name given";
    String email = user?.email ?? "N/A";
    bool isEmailVerified = user?.emailVerified ?? false;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.15),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFFC2F3A8),
                  Color(0xFFC1E0C8),
                ],
              ),
            ),
            child: SizedBox(
              height: Get.height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAndToNamed(Routes.getHomeScreen());
                    },
                    child: SizedBox(
                      width: Get.width * 0.1,
                      child: Image.asset(
                        "assets/images/back_icon.png",
                      ),
                    ),
                  ),
                  const Text(
                    "User Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF124819),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: Get.height / 2.5,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        child: user != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset("assets/images/user_icon.png"),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Display Name: ${displayName == "" ? "Not Set" : displayName}',
                  ),
                  Text(
                    'Email: $email',
                  ),
                  Text(
                    'Account Status: ${isEmailVerified ? "verified" : "unverified"}',
                  ),
                ],
              )
            : const Center(child: Text('Something went wrong')),
      ),
    );
  }
}
