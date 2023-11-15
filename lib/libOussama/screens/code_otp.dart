import 'dart:convert';
import '../../libOussama/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../core/AppColor.dart';
import 'recevoir_code.dart';

class MonNouveauPasswordPagee extends StatefulWidget {
  final String userEmail;

 MonNouveauPasswordPagee({required this.userEmail});

 


  @override
  _ChangePasswordPageStatee createState() => _ChangePasswordPageStatee();
}

class _ChangePasswordPageStatee extends State<MonNouveauPasswordPagee> {
  final _emailController = TextEditingController();
  final _codeControllers = List.generate(4, (index) => TextEditingController());
  final _newPasswordController = TextEditingController();

  List<FocusNode> _codeFocusNodes = List.generate(4, (index) => FocusNode());

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = Uri.parse('http://10.0.2.2:3000/user/validateCode');
    final body = {
      'email': widget.userEmail,
      //"erfan@example.com",
      // _emailController.text,
      'code': _codeControllers.map((controller) => controller.text).join(),
      //'newPassword': "123456789"
      //_newPasswordController.text,
    };

    if (_codeControllers.every((controller) => controller.text.isNotEmpty) &&
        _codeControllers.length == 4) {
      final response = await http.post(url, body: json.encode(body), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
          UserData().userEmail = widget.userEmail;

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MonNouveauPasswordPage(
              //userEmail: widget.userEmail
                 
                )));
      } else {
        setState(() {
          _errorMessage = 'Failed to change password: ${response.statusCode}';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Invalid OTP code';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeControllers.forEach((controller) => controller.dispose());
    _newPasswordController.dispose();
    _codeFocusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
        backgroundColor: Color(0xFF107873),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
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
                'Enter 4-digit OTP Code:',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center, // Ajout de cette ligne
  children: [
    for (int i = 0; i < 4; i++)
      Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          controller: _codeControllers[i],
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: "",
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
          focusNode: _codeFocusNodes[i],
          onChanged: (text) {
            if (text.isNotEmpty) {
              if (i < 3) {
                _codeFocusNodes[i].unfocus();
                _codeFocusNodes[i + 1].requestFocus();
              }
            }
          },
        ),
      ),
  ],
),

              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _changePassword,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF107873),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
      ),
    );
  }
}



class UserData {
  static final UserData _singleton = UserData._internal();

  String userEmail = "";

  factory UserData() {
    return _singleton;
  }

  UserData._internal();
}
