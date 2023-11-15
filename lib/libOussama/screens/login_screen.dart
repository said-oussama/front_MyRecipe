import 'dart:ui';
import '../../libOussama/screens/recevoir_code.dart';
import 'package:flutter/material.dart';
import '../../libOussama/core/api_client.dart';
import '../../libOussama/screens/home.dart';
import '../../libOussama/utils/validator.dart';
import '../../libOussama/utils/code_refector.dart';
import '../../libOussama/screens/register.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../core/AppColor.dart';
import 'home2.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  bool _showPassword = false;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      dynamic res = await _apiClient.login(
        emailController.text,
        passwordController.text,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res[0] == null) {
        String accessToken = res['user']['_id'];
        print(accessToken);

        String token = res['token'];
    print(token);
        
        //print(accessToken);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(accesstoken: accessToken,token:token)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Error: Please verify mail / password'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors
            .transparent, // Définissez la couleur de fond du Scaffold comme transparente
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/bg.jpg"), // Remplacez "votre_image.png" par le chemin de votre image
                fit: BoxFit.cover, // Pour que l'image couvre tout l'écran
              ),
            ),
            child: Form(
              key: _formKey,
              child: Stack(children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: size.width * 0.85,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 233, 236, 233),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: size.height * 0.08),
                              const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF107873),
                                    //  backgroundColor: Color(0xFF107873),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.06),
                              TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  return Validator.validateEmail(value ?? "");
                                },
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              TextFormField(
                                obscureText: !_showPassword,
                                controller: passwordController,
                                validator: (value) {
                                  return Validator.validatePassword(
                                      value ?? "");
                                },
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(
                                          () => _showPassword = !_showPassword);
                                    },
                                    child: Icon(
                                      _showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: "Password",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: login,
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            side: BorderSide(
                                                color: AppColor.secondary
                                                    .withOpacity(0.5),
                                                width: 1),
                                            backgroundColor: Color(0xFF107873),
                                          ),
                                          child: Text('Log in',
                                              style: TextStyle(
                                                  color: AppColor.secondary,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'inter')),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: Text.rich(
                                      TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Don’t have an account ? ",
                                          ),
                                          TextSpan(
                                            text: "Sign Up",
                                            style: TextStyle(
                                              color: Color(
                                                  0xFF107873), // Changer la couleur du texte "Sign Up" ici
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ///////////
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => resetCode(),
                                        ),
                                      );
                                    },
                                    child: Text.rich(
                                      TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                "Do you forget your password ? ",
                                          ),
                                          TextSpan(
                                            text: "forget password",
                                            style: TextStyle(
                                              color: Color(
                                                  0xFF107873), // Changer la couleur du texte "forget password" ici
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              /////////
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )));
  }
}
