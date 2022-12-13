import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:last/pages/home.dart';

class ListReview extends StatelessWidget {
  const ListReview({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyListReview(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyListReview extends StatefulWidget {
  const MyListReview({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyListDestination createState() => _MyListDestination();
}

class _MyListDestination extends State<MyListReview> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 20, 0),
                      child: appBar()),
                  Container(child: reviewData()),
                ]))));
  }

  appBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RawMaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            constraints: const BoxConstraints(minWidth: 0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            elevation: 2.0,
            padding: const EdgeInsets.all(8),
            child:
                const Icon(Icons.arrow_back, color: Colors.black87, size: 25),
          ),
          const Text(
            "Review",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Darker',
              fontSize: 17,
              letterSpacing: 1,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  reviewData() {
    return SizedBox(
        height: 700,
        width: 500,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: db.collection('reviews').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "There are no recent reviews, be the first to leave a review",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Darker",
                            fontSize: 18,
                            letterSpacing: 0.8),
                      ),
                    ));
              } else {
                var data = snapshot.data!.docs;
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Delete User Review"),
                                  content:
                                      const Text('Are you sure to delete?'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text("Delete"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        data[index].reference.delete();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 600, minHeight: 56.0),
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                              padding: const EdgeInsets.fromLTRB(20, 27, 20, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(1.5, 1.5),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  )
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: CircleAvatar(
                                      maxRadius: 15,
                                      backgroundImage: NetworkImage(
                                          'https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHx3aGl0ZXw%3D&auto=format&fit=crop&w=400&q=60'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              data[index]
                                                  .data()['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data[index]
                                                  .data()['place']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          child: RatingBar.builder(
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.blue,
                                            ),
                                            ignoreGestures: true,
                                            itemSize: 15,
                                            itemCount: 5,
                                            allowHalfRating: true,
                                            initialRating: double.parse(
                                                data[index]
                                                    .data()['star']
                                                    .toString()),
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            onRatingUpdate: (value) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        Text(
                                          data[index]
                                              .data()['review']
                                              .toString(),
                                          textAlign: TextAlign.justify,
                                          maxLines: 7,
                                          style: const TextStyle(
                                            fontFamily: 'Josefins',
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                data[index]
                                                    .data()['date']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontSize: 10.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )));
                    });
              }
            }));
  }
}
