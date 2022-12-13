import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:last/pages/home.dart';
import 'package:last/pages/review.dart';

class Detail extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const Detail({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(documentSnapshot['image'].toString()),
              ),
            ),
          ),
          SafeArea(
              child: Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 20, 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                    child: RawMaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      constraints: const BoxConstraints(minWidth: 0),
                      onPressed: null,
                      elevation: 5.0,
                      fillColor: const Color(0x20000000),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 21),
                    ),
                  )
                ],
              ),
            ),
          )),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.4,
                      maxHeight: MediaQuery.of(context).size.height * 0.5),
                  padding: EdgeInsets.only(left: 20, bottom: 0, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 180),
                          child: Text(
                            documentSnapshot['name'].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                fontFamily: 'Darker',
                                fontSize: 38,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical, //.horizontal
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Text(
                                  documentSnapshot['desc'].toString(),
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.justify,
                                  style: (const TextStyle(
                                      fontFamily: 'Josefins',
                                      fontSize: 15,
                                      height: 1.2,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 43,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const FittedBox(
                                    child: Text(
                                      'Start from',
                                      style: TextStyle(
                                          fontFamily: 'Josefins',
                                          fontSize: 16,
                                          height: 2,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      '\$ ${documentSnapshot['price'].toString()} / person',
                                      style: const TextStyle(
                                          fontFamily: 'Josefins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReviewPage(
                                              documentSnapshot:
                                                  documentSnapshot)));
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: const FittedBox(
                                        child: Text(
                                          'User Review',
                                          style: TextStyle(
                                              fontFamily: 'Josefins',
                                              height: 1.2,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        )
                      ])))
        ])));
  }
}
