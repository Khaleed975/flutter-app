import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_app/screens/Home.dart';
import 'package:graduation_app/screens/sign%20up.dart';
import 'package:graduation_app/screens/widgets/nav_bar.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  bool passToggel = true;
  void login() {
    String email = _emailController.text;
    String password = _passController.text;

    if (email.isEmpty || password.isEmpty) {
      // Show an error message or perform another action
      print("Email and password are required");
      return;
    }

    if (_formKey.currentState!.validate()) {
      // Perform the login action
      print("Successful login");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NavBarRoots(),
        ),
      );
    } else {
      print("Unsuccessful login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Transform.translate(
                      offset: const Offset(31.0, 0.0),
                      child: Image.asset(
                        'assets/images/brain.png',
                        height: 180,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(' Email'),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: validateEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: _passController,
                      obscureText: passToggel ? true : false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text(' Password'),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (passToggel == true) {
                              passToggel = false;
                            } else {
                              passToggel = true;
                            }
                            setState(() {});
                          },
                          child: passToggel
                              ? const Icon(CupertinoIcons.eye_slash)
                              : const Icon(CupertinoIcons.eye_fill),
                        ),
                      ),
                      validator: (password) => password!.length < 6
                          ? 'Password should ba at least 6 characters'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Material(
                    color: const Color(0xff150A28),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: login,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have any account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ));
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff150A28),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
