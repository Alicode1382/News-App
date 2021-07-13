import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detailpage extends StatefulWidget {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;

  Detailpage(
      {this.author,
      this.title,
      this.description,
      this.urlToImage,
      this.publishedAt});

  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Image.network(
              widget.urlToImage,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Material(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35),
                  ),
                  child: new Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Text(
                            widget.title,
                            style: new TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                      new Text(
                        widget.publishedAt.substring(0, 10),
                        style: new TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: new Text(
                            widget.description,
                            style: new TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          )),
                      Text(
                        widget.author,
                        style: new TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
