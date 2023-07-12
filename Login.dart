// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manager_app/theme/AppColors.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var Name;
  var Password;
  bool passwordObscured = true;
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.backColor,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //! left
            Expanded(
              flex: 7,
              child: Container(
                height: double.infinity,
                color: AppColor.mainColor,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Center(
                  child: Text(
                    'Manage your\nbusiness\nanytime,anywhere',
                    style: TextStyle(
                      wordSpacing: 1.0,
                      fontSize: 48.0,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            //!right
            Expanded(
              flex: 12,
              child: Container(
                padding: const EdgeInsets.only(top: 145.0, left: 95.0),
                color: AppColor.backColor,
                margin: const EdgeInsets.only(right: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Login',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800,
                            color: AppColor.blackColor)),
                    const SizedBox(height: 12.0),
                    const Text(
                      ' Hey, Enter your details to get log in \n to your account.',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grayColor,
                      ),
                    ),
                    const SizedBox(height: 45.0),
                    //!name
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      height: 50.0,
                      width: 750,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: AppColor.whiteColor,
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          Name = value;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Name",
                          contentPadding: EdgeInsets.only(top: 15.0),
                          hintMaxLines: 2,
                          hintStyle: TextStyle(fontSize: 13),
                          prefixIcon: Icon(
                            Icons.person_2_outlined,
                            color: AppColor.redColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 45.0),
                    //!password
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'password',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      height: 50.0,
                      width: 750,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: AppColor.whiteColor,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passwordObscured,
                        onChanged: (value) {
                          Password = value;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordObscured = !passwordObscured;
                              });
                            },
                            icon: Icon(
                              passwordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColor.redColor,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: "Enter Password",
                          hintStyle: const TextStyle(fontSize: 13),
                          contentPadding: const EdgeInsets.only(top: 15.0),
                          hintMaxLines: 2,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: AppColor.redColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/Forget');
                          },
                          child: const Text(
                            'Forget The Password?',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Color.fromARGB(255, 22, 26, 63),
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ),
                    //!login button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          print(Name);
                          print(Password);
                          login(Name, Password);
                          Navigator.pushNamed(context, '/Reservations');
                        },
                        borderRadius: BorderRadius.circular(16.0),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70.0, vertical: 18.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: AppColor.mainColor,
                          ),
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColor.whiteColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

login(Name, Password) async {
  var url = "http://127.0.0.1:3000";
  final response = await http.post(
    url as Uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'Password': Password, "Name": Name}),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
