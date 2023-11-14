import 'dart:convert';
import '../../libOussama/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../core/AppColor.dart';
import 'login_screen.dart';

class ChangePasswordPage extends StatefulWidget {
  final String? userEmail;

  ChangePasswordPage({required this.userEmail});
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isOldPasswordVisible = false; // Par défaut, le mot de passe est masqué

  String? _errorMessage;

  Future<void> _submitForm() async {
    final url = Uri.parse('http://10.0.2.2:3000/user/changePasswordProfile');
    final body = {
      'email': widget.userEmail,
      'password': _oldPasswordController.text,
      'newPassword': _newPasswordController.text,
    };

    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      final responseData = json.decode(response.body);
      setState(() {
        _errorMessage = responseData['error'];
      });
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
          backgroundColor: Color(0xFF107873),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("image/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                Text(
                  'enter your old Password:',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors
                        .white, // Changer la couleur du texte en blanc ici
                  ),
                ),
                SizedBox(height: 16.0),
               TextField(
  controller: _oldPasswordController,
  obscureText: !isOldPasswordVisible, // Inverser la visibilité du mot de passe
  decoration: InputDecoration(
    hintText: 'Enter your old password',
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    suffixIcon: IconButton(
      icon: Icon(
        isOldPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
      ),
      onPressed: () {
        setState(() {
          isOldPasswordVisible = !isOldPasswordVisible;
        });
      },
    ),
    // Autres paramètres de décoration
  ),
  style: TextStyle(color: Colors.white),
),
                SizedBox(height: 16.0),
                Text(
                  'enter your new Password:',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 255, 255, 255), // Changer la couleur du texte en blanc ici
                  ),
                ),
                SizedBox(height: 16.0),
                // Par défaut, le mot de passe est masqué

                TextField(
                  //bool isPasswordVisible = false,
                  controller: _newPasswordController,
                  obscureText:
                      !isPasswordVisible, // Inverser la visibilité du mot de passe
                  decoration: InputDecoration(
                    hintText: 'Enter your new password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey, // Couleur de l'icône
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    // Autres paramètres de décoration
                  ),
                  style: TextStyle(color: Colors.white),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _submitForm,
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: BorderSide(
                              color: AppColor.secondary.withOpacity(0.5),
                              width: 1),
                          backgroundColor: Color(0xFF107873),
                        ),
                        child: Text('Confirm',
                            style: TextStyle(
                                color: AppColor.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
