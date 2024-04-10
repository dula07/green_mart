// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  FocusNode myFocusNode = FocusNode();

  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible1 = false;
    _passwordVisible2 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: Get.width * 0.5,
                child: Image.asset("assets/images/greemart_logo.png"),
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          cursorColor: const Color(0xFF124819),
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'Enter your email address',
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF124819), width: 2.0),
                            ),
                            labelStyle: TextStyle(color: myFocusNode.hasFocus ? const Color(0xFF124819) : Colors.black),
                          ),
                          controller: emailController,
                          validator: emailValidator,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          obscureText: !_passwordVisible1,
                          cursorColor: const Color(0xFF124819),
                          decoration: InputDecoration(
                            labelText: 'New Password',
                            hintText: 'Enter a new password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible1 ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible1 = !_passwordVisible1;
                                });
                              },
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF124819), width: 2.0),
                            ),
                            labelStyle: TextStyle(color: myFocusNode.hasFocus ? const Color(0xFF124819) : Colors.black),
                          ),
                          controller: passwordController,
                          validator: passwordValidator,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          obscureText: !_passwordVisible2,
                          cursorColor: const Color(0xFF124819),
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Re enter the same password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible2 ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible2 = !_passwordVisible2;
                                });
                              },
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF124819), width: 2.0),
                            ),
                            labelStyle: TextStyle(color: myFocusNode.hasFocus ? const Color(0xFF124819) : Colors.black),
                          ),
                          controller: confirmPasswordController,
                          validator: confirmPasswordValidator,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFFFFFFF),
                            backgroundColor: const Color(0xFF124819),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              registration();
                            }
                          },
                          child: const Text("Register"),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Color(0xFF124819), fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginScreen();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              ' Login.',
                              style: TextStyle(
                                color: Color(0xFF50B221),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String? emailValidator(value) {
    if (value!.isEmpty) {
      return 'Phone cannot be empty';
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value!.isEmpty) {
      return 'Phone cannot be empty';
    }
    return null;
  }

  String? confirmPasswordValidator(value) {
    if (value!.isEmpty) {
      return 'Confirm password cannot be empty';
    }
    if (passwordController.text != confirmPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future registration() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();

      final snackBar = SnackBar(content: Text(e.message ?? "An error occurred during registration."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
