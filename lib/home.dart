import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:reality_conjurer/drawing_area.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DrawingArea?> points = [];
  Widget imageOutput;

  //now connecting our client app to our API
  void fetchResponse(var base64Image) async {
    print("Starting Request");

    var data = {"Image": base64Image};
    //get around this will be connecting to our home IP Address
    var url = Uri.parse('http://192.168.1.3:5000/predict');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'Keep-Alive',
    };
    var body = json.encode(data);
    try {
      var response = await http.post(url, body: body, headers: headers);
      final Map<String, dynamic> responseData = json.decode(response.body);
      String outputBytes = responseData['Image'];
      print(outputBytes.substring(2,outputBytes.length-1));
    } catch (e) {
      print('* Error has occured');
      return null;
    }
  }

  //save the image the user drew
  void saveToImage(List<DrawingArea?> points) async {
    final recorder = ui.PictureRecorder();
    final canvas =
        Canvas(recorder, Rect.fromPoints(Offset(0, 0), Offset(200, 200)));
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;
    final paint2 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawRect(Rect.fromLTWH(0, 0, 256, 256), paint2);
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!.point, points[i + 1]!.point, paint);
      }
      final picture = recorder.endRecording();
      final img = await picture.toImage(256, 256);
      final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);
      final listBytes = Uint8List.view(pngBytes!.buffer);
      //File file=await writeBytes(listBytes);
      String base64 = base64Encode(listBytes);
      fetchResponse(base64);
    }
  }

  void displayResponseImage(String bytes) async{
    
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  void _doSomething() async {
    Timer(Duration(milliseconds: 100), () {
      // ignore: unnecessary_this
      this.setState(() {
        points.clear();
        _btnController.success();
        _btnController.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 256,
                    height: 256,
                    decoration: BoxDecoration(
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.all(
                          // ignore: prefer_const_constructors
                          Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10.0,
                            spreadRadius: 2,
                          )
                        ]),
                    child: GestureDetector(
                      onPanDown: (details) {
                        // ignore: unnecessary_this
                        this.setState(
                          () {
                            points.add(DrawingArea(
                                point: details.localPosition,
                                areaPaint: Paint()
                                  ..strokeCap = StrokeCap.round
                                  ..isAntiAlias = true
                                  ..color = Colors.white
                                  ..strokeWidth = 2.0));
                          },
                        );
                      },
                      onPanUpdate: (details) {
                        // ignore: unnecessary_this
                        this.setState(
                          () {
                            points.add(DrawingArea(
                                point: details.localPosition,
                                areaPaint: Paint()
                                  ..strokeCap = StrokeCap.round
                                  ..isAntiAlias = true
                                  ..color = Colors.white
                                  ..strokeWidth = 2.0));
                          },
                        );
                      },
                      onPanEnd: (details) {
                        saveToImage(points);
                        // ignore: unnecessary_this
                        this.setState(
                          () {
                            // ignore: null_check_always_fails
                            points.add(null);
                          },
                        );
                      },
                      child: SizedBox.expand(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: CustomPaint(
                            painter: MyCustomPainter(
                              points: points,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedLoadingButton(
                        child: Text('Clear Pad',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 2.0)),
                        elevation: 15.0,
                        controller: _btnController,
                        color: Colors.deepPurpleAccent,
                        onPressed: _doSomething,
                        width: 200,
                        borderRadius: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
