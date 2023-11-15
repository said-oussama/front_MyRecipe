import 'dart:convert';
import '../../libOussama/screens/code_otp.dart';
import '../../libOussama/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../core/AppColor.dart';

class resetCode extends StatefulWidget {
  @override
  _ResetCodePageState createState() => _ResetCodePageState();
}

class _ResetCodePageState extends State<resetCode> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://10.0.2.2:3000/user/reset');
    final body = {'email': _emailController.text};

    final response = await http.post(url, body: body);

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final code = responseData['code'];
      final userEmail = _emailController.text; // Récupérez l'e-mail ici

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MonNouveauPasswordPagee(userEmail: _emailController.text),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email'),
          duration: Duration(seconds: 2),
        ),
      );
      print('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Get Your Code'),
          backgroundColor:
              Color(0xFF107873), // Changer la couleur de l'AppBar ici
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Enter Your Email:',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors
                        .white, // Changer la couleur du texte en blanc ici
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .white), // Couleur du contour lorsque le champ n'est pas en focus
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .white), // Couleur du contour lorsque le champ est en focus
                    ),
                  ),
                  style: TextStyle(
                      color: Colors.white), // Couleur du texte de l'entrée
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _fetchData,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side: BorderSide(
                        color: AppColor.secondary.withOpacity(0.5), width: 1),
                    backgroundColor: Color(0xFF107873),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'Confirm',
                          style: TextStyle(
                              color: AppColor.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily:
                                  'inter'), // Couleur du texte du bouton
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}

class MonNouveauPasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<MonNouveauPasswordPage> {
  final String userEmail = UserData().userEmail;

  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordControllerr = TextEditingController();
  bool _showRepeatPassword = false; // Par défaut, le texte est masqué
  bool _showRepeatPasswordd = false; // Par défaut, le texte est masqué

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = Uri.parse('http://10.0.2.2:3000/user/changePassword');
    final body = {
      'email': userEmail,
      //"erfan@example.com",
      //userEmail,
      //'code': _codeController.text,
      'newPassword': _newPasswordController.text,
      'repeterVotreNewPassword': _newPasswordControllerr.text,
    };

    final response = await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
      //Navigator.pushNamed(context, '/oussama');
    } else {
      setState(() {
        _errorMessage = 'Failed to change password: ${response.statusCode}';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _newPasswordControllerr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
          backgroundColor:
              Color(0xFF107873), // Changer la couleur de l'AppBar ici
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                Text(
                  'enter your new Password:',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors
                        .white, // Changer la couleur du texte en blanc ici
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _newPasswordController,
                  obscureText:
                      !_showRepeatPassword, // Utilisez la variable pour contrôler l'obfuscation
                  decoration: InputDecoration(
                    hintText: 'enter your new password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showRepeatPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _showRepeatPassword = !_showRepeatPassword;
                        });
                      },
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Repet your new Password:',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors
                        .white, // Changer la couleur du texte en blanc ici
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
  controller: _newPasswordControllerr,
  obscureText: !_showRepeatPasswordd, // Toggle repeat password visibility
  decoration: InputDecoration(
    hintText: 'Repeat your new password',
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    suffixIcon: IconButton(
      icon: Icon(
        _showRepeatPasswordd
            ? Icons.visibility
            : Icons.visibility_off,
        color: Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _showRepeatPasswordd = !_showRepeatPasswordd;
        });
      },
    ),
  ),
  style: TextStyle(color: Colors.white),
),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _changePassword,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side: BorderSide(
                        color: AppColor.secondary.withOpacity(0.5), width: 1),
                    backgroundColor: Color(0xFF107873),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'Confirm',
                          style: TextStyle(
                              color: AppColor.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily:
                                  'inter'), // Couleur du texte du bouton
                        ),
                ),
                SizedBox(height: 8.0),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ));
  }
}
