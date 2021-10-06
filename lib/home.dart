import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:ffi';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:reality_conjurer/drawing_area.dart';
import 'package:http/http.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DrawingArea?> points = [];

  //now connecting our client app to our API
  void fetchResponse(var base64Image) async{
    var data={"Image":base64Image};
    //get around this will be connecting to our home IP Address
    var url='http://192.168.1.3:5000/predict';
    Map<String,String> headers={
      'Content-type':'application/json',
      'Accept':'application/json',
      'Connection':'Keep-Alive',
    };
    var body=json.encode(data);
    try{
      var response=await http.post(
        url,
        body:body,
        headers:headers
        );
        final Map<String,dynamic> responseData=json.decode(
          response.body
        );
        String outputBytes=responseData['Image'];

    } catch(e){
      print('* Error has occured');
      return null;
    }
  }






  void _doSomething() async {
    Timer(Duration(milliseconds: 100), () {
      this.setState(() {
        points.clear();
        _btnController.success();
        _btnController.reset();
      });
    });
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white
          ),
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
                        style: TextStyle(color: Colors.white,
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
