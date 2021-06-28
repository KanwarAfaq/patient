import 'package:patient/Login/login_with_otp%20copy.dart';
import 'package:patient/Model/TokenModel.dart';
import 'package:patient/components/copyButton/copy_button.dart';
import 'package:patient/wallet_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../app_config.dart';
import '../../services_provider.dart';

class FinalDetails extends StatefulWidget {
  final String email;
  final TokenModel tokenModel;
  final Barcode result;

// Receiving Email using Constructor.
  FinalDetails({
    Key? key,
    required this.email,
    required this.tokenModel,
    required this.result,
  }) : super(key: key);
  @override
  _FinalDetailsState createState() => _FinalDetailsState();
}

class _FinalDetailsState extends State<FinalDetails> {
  var test;
  @override
  void initState() {
    test = widget.result.code.split(',');
    print(test.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.yellow,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login_otp1()));
              })
        ],
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Patient info",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   children: [
              //     Container(
              //       width: 280,
              //       padding: EdgeInsets.all(10.0),
              //       child: Text(
              //         'Name = ' +
              //             widget.tokenModel.firstname +
              //             "  " +
              //             widget.tokenModel.lastname,
              //         style: TextStyle(fontSize: 20),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Container(
              //       width: 280,
              //       padding: EdgeInsets.all(10.0),
              //       child: Text(
              //         'Email = ' + widget.email,
              //         style: TextStyle(fontSize: 20),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          new ClipboardData(text: widget.tokenModel.jwt));
                    },
                    onLongPress: () {
                      Clipboard.setData(
                          new ClipboardData(text: widget.result.toString()));
                    },
                    child: Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Token = ' + widget.tokenModel.jwt!,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Doctor info",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    test[0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    test[1],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Test info",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              ...List.generate(
                test.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: index < 2
                              ? Container()
                              : Text(
                                  index == 2 && test[index].length > 16
                                      ? test[index].substring(16)
                                      : test[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              CopyButton(
                  text: const Text('Result'),
                  value: widget.tokenModel.jwt.toString() + test.toString()),
              Center(
                  child: IconButton(
                icon: Icon(Icons.send_sharp),
                onPressed: () async {
                  WidgetsFlutterBinding.ensureInitialized();
                  final stores =
                      await createProviders(AppConfig().params['ropsten']!);

                  tokenReceiver = widget.tokenModel.jwt.toString();
                  testReceiver = test.toString();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainApp(
                              stores,
                            )),
                  );
                },
                color: Colors.yellow,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
