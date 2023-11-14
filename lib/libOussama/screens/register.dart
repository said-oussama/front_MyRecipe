import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../libOussama/core/api_client.dart';
import '../../libOussama/screens/login_screen.dart';
import '../../libOussama/utils/validator.dart';

import '../core/AppColor.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "register_screen";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //final TextEditingController publicKeyController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  bool _showPassword = false;
  final dio = Dio();
  Future<void> registerUsers() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Color.fromARGB(255, 168, 239, 170),
      ));

      Map<String, String> userData = {
        "email": emailController.text,
        "password": passwordController.text,
        "username": usernamecontroller.text,
        //"publickey": publicKeyController.text,
      };

      dynamic res = await _apiClient.registerUser(userData);
      //ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res[0] == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Couldnt create user'),
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
                  "image/bg.jpg"), // Remplacez "votre_image.png" par le chemin de votre image
              fit: BoxFit.cover, // Pour que l'image couvre tout l'écran
            ),
          ),
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width * 0.85,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //   SizedBox(height: size.height * 0.08),
                        const Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF107873),
                              //  backgroundColor: Color(0xFF107873),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),

                        SizedBox(height: size.height * 0.03),
                        TextFormField(
                          controller: usernamecontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "username",
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextFormField(
                          validator: (value) =>
                              Validator.validateEmail(value ?? ""),
                          controller: emailController,
                          keyboardType: TextInputType.text,
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
                          validator: (value) =>
                              Validator.validatePassword(value ?? ""),
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        // SizedBox(height: size.height * 0.05),

                        // SizedBox(height: size.height * 0.03),
                        // TextFormField(
                        //   controller: publicKeyController,
                        //   decoration: InputDecoration(
                        //     hintText: "public Key",
                        //     isDense: true,
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: size.height * 0.06),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: registerUsers,
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              side: BorderSide(
                                  color: AppColor.secondary.withOpacity(0.5),
                                  width: 1),
                              backgroundColor: Color(0xFF107873),
                            ),
                            child: Text('Register',
                                style: TextStyle(
                                    color: AppColor.secondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'inter')),
                          ),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            // style: TextButton.styleFrom(
                            //   primary: Colors
                            //       .red, // Changer la couleur du texte "Login" ici
                            // ),
                            child: const Text('Login',
                                style: TextStyle(color: Color(0xFF107873))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
