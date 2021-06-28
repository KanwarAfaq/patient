import 'package:patient/Login/login_with_otp%20copy.dart';
import 'package:patient/Signup/Signup_otp.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Registration'),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  '.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final hnameController = TextEditingController();
  final ssnoController = TextEditingController();
  final passwordController = TextEditingController();

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    // ignore: non_constant_identifier_names
    String first_name = fnameController.text;

    // ignore: non_constant_identifier_names
    String last_name = lnameController.text;
    // ignore: non_constant_identifier_names
    String ssno = ssnoController.text;
    String password = "12345";

    // SERVER API URL
    var url =
        Uri.parse('http://10.10.172.253/app/registration/register_user.php');

    // Store all data with Param Name.
    var data = {
      'first_name': first_name,
      'last_name': last_name,
      'h_name': h_name,
      'ssno': ssno,
      'password': password
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    print(message);

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
              child: new Text("Got It"),
              onPressed: () {
                if (message ==
                    "Sorry! we could not found info against your Social Security Number") {
                  Navigator.of(context).pop();
                } else if (message != "Social Security No. Already Exist") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup_otp(),
                      ));
                } else {
                  Navigator.of(context).pop();
                }

                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),*/
              },
            ),
          ],
        );
      },
    );
  }

  String h_name = "";

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
                child: Text('Patient Registration Form',
                    style: TextStyle(fontSize: 21))),

            //for first name
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: fnameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'First Name Required';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  hintText: "Enter Your First Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            //for last name
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: lnameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Last Name Required';
                  }
                  return null;
                },
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  hintText: "Enter Your Last Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),

            //  for ssno
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: DropDown<String>(
                items: <String>["AUH", "CMUH", "CGMH"],
                customWidgets: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Text("AUH"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Text("CMUH"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Text("CGMH"),
                  ),
                ],
                hint: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Text(
                    "Select Hospital",
                    style: TextStyle(),
                  ),
                ),
                onChanged: (v) {
                  h_name = v;
                  print(h_name);
                },
                showUnderline: false,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: ssnoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Social Security Number Required';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  hintText: "Enter Your Social Security Number",
                  hintStyle: TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(
                    Icons.security_outlined,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 15),
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade100,
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   child: TextFormField(
            //     controller: passwordController,
            //     validator: (value) {
            //       if (value.isEmpty) {
            //         return 'Password Required';
            //       } else if (value.length < 3) {
            //         return 'Length must be more then 4 character';
            //       }
            //       return null;
            //     },
            //     keyboardType: TextInputType.emailAddress,
            //     style: TextStyle(
            //       fontStyle: FontStyle.normal,
            //       fontWeight: FontWeight.normal,
            //     ),
            //     obscuringCharacter: "*",
            //     obscureText: true,
            //     decoration: InputDecoration(
            //       hintText: "Enter Your Password",
            //       hintStyle: TextStyle(color: Colors.grey),
            //       suffixIcon: Icon(
            //         Icons.lock_outline,
            //         color: Colors.grey,
            //       ),
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //           borderSide: BorderSide(color: Colors.orange)),
            //       focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //           borderSide: BorderSide(color: Colors.orange)),
            //       contentPadding:
            //           EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            //     ),
            //   ),
            // ),
            // ignore: deprecated_member_use
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
                  'Register',
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
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account?',
                  style: GoogleFonts.lateef(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login_otp1(),
                      ),
                    );
                  },
                  splashColor: Colors.grey.shade200,
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
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
