import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thelostlane/authentication/facebook_authentication.dart';
import 'package:thelostlane/authentication/google_authentication.dart';
import 'package:thelostlane/views/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Log in or Sign up",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                color: Colors.black12,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to The Lost Lanes",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    // For Phone number field
                    phoneNumberField(size),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: const TextSpan(
                        text:
                            "We'll call or text you to confirm your number. Standard message and data rates may apply. ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.pink,
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.026,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.black26,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "or",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.black26,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    // OAUTH Logins
                    InkWell(
                      onTap: () async {
                        await FacebookAuthenticationService()
                            .signInWithFacebook()
                            .then(
                              (value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppMainScreen(),
                                ),
                              ),
                            );
                      },
                      child: socialIcons(size, Icons.facebook,
                          "Continue with Facebook", Colors.blueAccent, 30),
                    ),

                    //TODO:: GOOGLE AUTHENTICATION PART FROM VIDEO: 23:31
                    // TODO: Handle Errors from failed sign in
                    InkWell(
                        onTap: () async {
                          await GoogleAuthenticationService()
                              .signInWithGoogle()
                              .then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AppMainScreen(),
                                    ),
                                  ));
                        },
                        child: socialIcons(size, FontAwesomeIcons.google,
                            "Continue with Google", Colors.pink, 27)),
                    socialIcons(size, Icons.apple, "Continue with Apple",
                        Colors.black, 30),
                    socialIcons(size, Icons.email_outlined,
                        "Continue with Email", Colors.black, 30),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Need Help?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding socialIcons(Size size, icon, name, color, double iconSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(),
        ),
        child: Row(
          children: [
            SizedBox(
              width: size.height * 0.05,
            ),
            Icon(
              icon,
              color: color,
              size: iconSize,
            ),
            SizedBox(
              width: size.width * 0.18,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  Container phoneNumberField(Size size) {
    return Container(
      width: size.width,
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: 10,
              left: 10,
              top: 8,
            ),
            child: Column(
              children: [
                Text(
                  "Country/Region",
                  style: TextStyle(color: Colors.black45),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "United States(+1)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Phone number",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black45,
                  ),
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
