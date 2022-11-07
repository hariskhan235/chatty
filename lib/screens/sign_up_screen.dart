import 'package:chatty/utils/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObsecure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    bool isObsecure = true;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: UpperClippath(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      //Color.fromARGB(255, 40, 39, 39),
                      Color.fromRGBO(255, 169, 132, 1),
                      Color.fromARGB(255, 139, 56, 20),
                      //Color.fromARGB(255, 27, 18, 1),
                    ],
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.28,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Spacer(),
                      Text(
                        "Create Account",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Name cannot be empty";
                          }
                          return null;
                        },
                        controller: _nameController,
                        cursorColor: const Color.fromRGBO(255, 121, 63, 1),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            hintText: "Enter your name",
                            labelStyle: TextStyle(color: Color(0xFF424242))),
                      ),
                    ),
                    const Text(
                      "Email Address",
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        validator: (val) {
                          if (!emailRegex.hasMatch(val!)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        controller: _emailController,
                        cursorColor: const Color.fromRGBO(255, 121, 63, 1),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            hintText: "Enter your email",
                            labelStyle: TextStyle(color: Color(0xFF424242))),
                      ),
                    ),
                    const Text(
                      "Password",
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password too short!";
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: isObsecure,
                        cursorColor: const Color.fromRGBO(255, 121, 63, 1),
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          hintText: "Enter your Password",
                          labelStyle: const TextStyle(color: Color(0xFF424242)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  isObsecure = !isObsecure;
                                },
                              );
                            },
                            icon: Icon(
                              isObsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: isObsecure
                                  ? const Color(0xFF424242)
                                  : const Color.fromRGBO(255, 121, 63, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(255, 121, 63, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<AuthNotifier>(context, listen: false)
                              .register(context,
                                  name: _nameController.text.trim(),
                                  email: _emailController.text,
                                  password: _passwordController.text);
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipPath(
              clipper: LowerClippath(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 169, 132, 60),
                      Color.fromRGBO(255, 121, 63, 60),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteNames.loginScreen, (route) => false);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 121, 63, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpperClippath extends CustomClipper<Path> {
  final double borderRadius = 0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 40);

    Offset firstControlPoint = Offset(size.width / 4, size.height);
    Offset firstPoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    Offset secondControlPoint = Offset(size.width / 4 * 3, size.height);
    Offset secondPoint = Offset(size.width, size.height);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class LowerClippath extends CustomClipper<Path> {
  final double borderRadius = 0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);

    Offset firstControlPoint = Offset(size.width / 4, size.height);
    Offset firstPoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    Offset secondControlPoint = Offset(size.width / 4 * 3, size.height);
    Offset secondPoint = Offset(size.width, size.height);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, size.height - 120);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
