import 'package:patient/Login/login_with_otp%20copy.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Signup_otp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Email Varification')),
            body: Center(child: RegisterUser())));
  }
}

class RegisterUser extends StatefulWidget {
  RegisterUserState createState() => RegisterUserState();
}

class RegisterUserState extends State {
  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final otpController = TextEditingController();

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    // ignore: non_constant_identifier_names
    String otp = otpController.text;
    // ignore: non_constant_identifier_names

    // SERVER API URL
    var url =
        Uri.parse('http://192.168.0.103/app/registration/verifyemail_.php');

    // Store all data with Param Name.
    var data = {'code': otp};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                if (message != "Wrong Code") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login_otp1(),
                      ));
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

//Validation
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  void _validate() {
    if (_form.currentState!.validate()) userRegistration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                    Text('OTP Varification', style: TextStyle(fontSize: 21))),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextFormField(
                controller: otpController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Input Required';
                  } else if (value.length < 6) {
                    return 'Length must 6 digits';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                obscuringCharacter: "*",
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter OTP",
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 35),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.yellow,
                onPressed: () {
                  _validate();
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'Submit',
                  style: GoogleFonts.lateef(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            Visibility(
                visible: visible,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator())),
          ],
        ),
      ),
    )));
  }
}
