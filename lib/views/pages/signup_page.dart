import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_test/utils/app_colors.dart';
import 'package:project_test/utils/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:project_test/config.dart';
import 'package:project_test/views/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailControler;
  late final TextEditingController _passwordControler;
  late final TextEditingController _userName;
  late FocusNode _emailFocusNode, _passwordFocusNode,_userNameFocusNode;
  String? _email, _password,_name;
  bool visibility = false;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailControler = TextEditingController();
    _passwordControler = TextEditingController();
    _userName = TextEditingController();
    _userNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordControler.dispose();
    _userName.dispose();
    super.dispose();
  }

  void signup() async {
    if (_formKey.currentState!.validate()) {

      debugPrint("$_name  $_email   $_password");
       var regBody = {
        "username":_name,
        "email":_email,
        "password":_password
      };
      var response = await http.post(Uri.parse(registeration),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(regBody)
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if(jsonResponse['status']){
        Navigator.pushNamed(context, AppRoutes.login);
      }else{
        print("SomeThing Went Wrong");
      }
    }

}
  

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.arrowBack,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        shadowColor: AppColors.shadowColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                          'assets/images/logo.png',
                          width: MediaQuery.sizeOf(context).width*0.4,
                        ),
                  const Text(
                    "Let's Get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary, 
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "Create an account with email to login from anywhere.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    controller: _userName,
                        onChanged: (value) => _name = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else {
                            return null;
                          }
                        },
                        focusNode: _userNameFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          _userNameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        decoration: InputDecoration(
                          hintText: 'Username',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20, right:5 ),
                            child: Icon(Icons.person, color: AppColors.grey4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color:AppColors.grey4, width: 1.0),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color:AppColors.primary, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.red),
                          borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:const BorderSide(color: AppColors.red),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailControler,
                        onChanged: (value) => _email = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          _emailFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(_passwordFocusNode);
                        },
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20, right:5 ),
                            child: Icon(Icons.email, color: AppColors.grey4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color:AppColors.grey4, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color:AppColors.primary, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.red),
                          borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:const BorderSide(color: AppColors.red),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordControler,
                        onChanged: (value) => _password = value,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          _passwordFocusNode.unfocus();
                          signup();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                        obscureText: !visibility,

                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right:5 ),
                        child: Icon(Icons.lock, color: AppColors.grey4),
                      ),
                      suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                visibility = !visibility;
                              });
                            },
                            child: Icon(visibility
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          suffixIconColor: AppColors.grey,

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color:AppColors.grey4, width: 1.0),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color:AppColors.primary, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.red),
                          borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:const BorderSide(color: AppColors.red),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                    ),
                  ),
                    const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        signup();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                   const SizedBox(height: 16.0),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.grey,
                          
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.primary,
                           
                          ),
                        ),
                      ),
                    ],
                  ),
                 const SizedBox(height: 16.0),
                   ],
              ),
            ),
          ),
        ),
      ),
    );
  
  }
}
