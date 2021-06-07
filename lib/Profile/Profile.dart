import 'package:patient/QR/QRScreen.dart';
import 'package:patient/Model/TokenModel.dart';

import 'package:patient/Login/login_with_otp%20copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
// Creating String Var to Hold sent Email.
  final String email;
  final TokenModel tokenModel;

// Receiving Email using Constructor.
  ProfileScreen({
    Key? key,
    required this.email,
    required this.tokenModel,
  }) : super(key: key);

// User Logout Function.
  logout(BuildContext context) {
    //Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login_otp1(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            bottomNavigationBar: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QrScreen(
                      tokenModel: tokenModel,
                      email: email,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.yellow,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Scan",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            appBar: AppBar(
                title: Text('Profile Screen'),
                actions: [
                  IconButton(
                      icon: Icon(Icons.exit_to_app),
                      color: Colors.yellow,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_otp1()));
                      })
                ],
                automaticallyImplyLeading: false),
            body: Center(
                child: Column(
              children: <Widget>[
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Name = ' +
                        tokenModel.firstname! +
                        "  " +
                        tokenModel.lastname!,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Email = ' + email,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: tokenModel.jwt));
                  },
                  onLongPress: () {
                    Clipboard.setData(new ClipboardData(text: tokenModel.jwt));
                  },
                  child: Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Token = ' + tokenModel.jwt!,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                // RaisedButton(
                //   onPressed: () {
                //     logout(context);
                //   },
                //   color: Colors.red,
                //   textColor: Colors.white,
                //   child: Text('Click Here To Logout'),
                // ),
                // Wrap(
                //   alignment: WrapAlignment.center,
                //   crossAxisAlignment: WrapCrossAlignment.center,
                //   children: <Widget>[
                //     Text(
                //       "",
                //       style: GoogleFonts.muli(
                //         fontSize: 18,
                //         fontWeight: FontWeight.w300,
                //       ),
                //       textAlign: TextAlign.left,
                //       overflow: TextOverflow.visible,
                //     ),
                //     FlatButton(
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => Login_otp1(),
                //           ),
                //         );
                //       },
                //       splashColor: Colors.grey.shade200,
                //       child: Text(
                //         'Logout',
                //         style: TextStyle(
                //             color: Colors.pinkAccent,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ))));
  }
}
