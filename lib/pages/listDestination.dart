import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:last/pages/addDestination.dart';
import 'package:last/pages/editDestination.dart';
import 'package:last/pages/home.dart';

class ListDestination extends StatelessWidget {
  const ListDestination({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyListDestination(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyListDestination extends StatefulWidget {
  const MyListDestination({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyListDestination createState() => _MyListDestination();
}

class _MyListDestination extends State<MyListDestination> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddDestination()),
                );
              },
              child: const Icon(Icons.add),
            ),
            body: SafeArea(
                child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 20, 0),
                      child: appBar()),
                  Container(child: list()),
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
            "Destination",
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

  list() {
    return SizedBox(
        height: 700,
        width: 600,
        child: StreamBuilder(
            stream: db.collection('destinations').orderBy('name').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (!streamSnapshot.hasData) {
                return const Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "There are no recent destination",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Darker",
                            fontSize: 18,
                            letterSpacing: 0.8),
                      ),
                    ));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: streamSnapshot.data!.docs.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];

                    return InkWell(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete User Review"),
                                content: const Text('Are you sure to delete?'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text("Edit"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditDestination(
                                                      documentSnapshot:
                                                          documentSnapshot)));
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text("Delete"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      documentSnapshot.reference.delete();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            height: 320,
                            child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          documentSnapshot['name'].toString(),
                                          maxLines: 1,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                              fontFamily: 'Josefins',
                                              fontSize: 13)),
                                      subtitle: Text(
                                          '\$' +
                                              documentSnapshot['price']
                                                  .toString(),
                                          maxLines: 1,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                              fontFamily: 'Josefins',
                                              fontSize: 13)),
                                    ),
                                    Container(
                                      height: 170,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            documentSnapshot['image']
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(16.0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        documentSnapshot['desc'].toString(),
                                        maxLines: 2,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontFamily: 'Josefins',
                                            fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ))));
                  },
                );
              }
            }));
  }
}
