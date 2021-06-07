import 'dart:convert';

import 'package:patient/Profile/Profile.dart';
import 'package:patient/Model/TokenModel.dart';

import 'package:patient/Login/login_with_otp%20copy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Bar extends StatefulWidget {
  const Bar({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;
  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  get email => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: RegsterUserOtp1(email: email),
      ),
    ));
  }
}

class RegsterUserOtp1 extends StatefulWidget {
  const RegsterUserOtp1({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;

  @override
  _RegsterUserOtpState createState() => _RegsterUserOtpState();
}

class _RegsterUserOtpState extends State<RegsterUserOtp1> {
// Boolean variable for CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final otpController = TextEditingController();

  Future userRegistration(email) async {
    // Showing CircularProgressIndicator.

    setState(() {
      visible = true;
    });

    // Getting value from Controller
    // ignore: non_constant_identifier_names
    String otp = otpController.text;
    // ignore: non_constant_identifier_names
    TokenModel obj = TokenModel();
    // SERVER API URL
    var url = Uri.parse(
        'http://patientapp.epizy.com/app/login/login_otp_varifiy.php');

    // Store all data with Param Name.
    var data = {'code': otp, 'email': email};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      obj = TokenModel.fromJson(item);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(
                    email: email,
                    tokenModel: obj,
                  )));

      setState(() {
        visible = false;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Invalid Or Expired OTP'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      setState(() {
        visible = false;
      });
    }
  }

  //Validation
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  void _validate() {
    if (_form.currentState!.validate()) userRegistration(widget.email);
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
                child: Text('Login OTP', style: TextStyle(fontSize: 21))),
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
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 30),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.yellow,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login_otp1()));
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'Resend',
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
