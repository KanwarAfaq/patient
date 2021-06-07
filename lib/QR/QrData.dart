import 'package:patient/QR/Final_Detail/FinalDetals.dart';
import 'package:patient/QR/QRScreen.dart';
import 'package:patient/Model/TokenModel.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrData extends StatefulWidget {
  final String email;
  final TokenModel tokenModel;
  final Barcode result;

// Receiving Email using Constructor.
  QrData({
    Key? key,
    required this.email,
    required this.tokenModel,
    required this.result,
  }) : super(key: key);

  @override
  _QrDataState createState() => _QrDataState();
}

class _QrDataState extends State<QrData> {
  var test;
  @override
  void initState() {
    test = widget.result.code.split(',');
    print(test.length);

    super.initState();
  }

  bool isSelected = false;
  bool isSelected1 = false;

  @override
  void dispose() {
    isSet = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
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
            SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Text(
                  "Dr Details",
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
              height: 40,
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                // Text("Agree"),
                // Padding(
                //   padding: const EdgeInsets.only(right: 10),
                //   child: Checkbox(
                //     onChanged: (bool value) {
                //       setState(() {
                //         isSelected = !isSelected;
                //         if (isSelected) {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => FinalDetails(
                //                 tokenModel: widget.tokenModel,
                //                 email: widget.email,
                //                 result: widget.result,
                //               ),
                //             ),
                //           );
                //         }
                //       });
                //     },
                //     value: isSelected,
                //     //  <-- leading Checkbox
                //   ),
                // ),
                // SizedBox(
                //   width: 25,
                // ),
                // Text("Disagree"),
                // Padding(
                //   padding: const EdgeInsets.only(right: 10),
                //   child: Checkbox(
                //     onChanged: (bool value) {
                //       setState(() {
                //         isSelected1 = !isSelected1;
                //         if (isSelected) {
                //           Navigator.pop(context);
                //         }
                //       });
                //     },
                //     value: isSelected1,
                //     //  <-- leading Checkbox
                //   ),
                // ),

                FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinalDetails(
                            tokenModel: widget.tokenModel,
                            email: widget.email,
                            result: widget.result,
                          ),
                        ),
                      );
                    },
                    child: Text("Agree")),
                SizedBox(
                  width: 50,
                ),
                FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Disagree"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
