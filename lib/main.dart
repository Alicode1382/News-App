import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:newsapplicatiojn/detailpage.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch_data_from_api();
  }

  List data;

  Future<String> fetch_data_from_api() async {
    var jsondata = await http.get(
        "http://newsapi.org/v2/everything?q=tech&apiKey=0b0b712f35b54dae9b147f3105cf60cc");
    var fetchdata = jsonDecode(jsondata.body);

    setState(() {
      data = fetchdata["articles"];
    });

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "news app",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
          appBar: new AppBar(
            title: new Text("news app"),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 25),
            child: new Swiper(
              itemCount: data == null ? 0 : data.length,
              viewportFraction: 0.8,
              autoplay: true,
              scale: 0.9,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detailpage(
                                  title: data[index]["title"],
                                  author: data[index]["author"],
                                  description: data[index]["description"],
                                  publishedAt: data[index]["publishedAt"],
                                  urlToImage: data[index]["urlToImage"],
                                )));
                  },
                  child: new Stack(
                    children: [
                      Padding(padding: EdgeInsets.all(10)),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35)),
                        child: Image.network(
                          data[index]["urlToImage"],
                          fit: BoxFit.cover,
                          height: 400,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
                        child: new Container(
                          height: 200,
                          width: 400,
                          child: Material(
                            borderRadius: BorderRadius.circular(35),
                            elevation: 10.0,
                            child: new Column(
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 20, 10, 20),
                                    child: new Text(
                                      data[index]["title"],
                                      style: new TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
