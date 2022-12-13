import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:last/pages/listDestination.dart';
import 'package:last/pages/listReview.dart';
import 'package:last/pages/login.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'All'),
    Tab(text: 'Mountain'),
    Tab(text: 'Lake'),
    Tab(text: 'City'),
    Tab(text: 'Sea'),
  ];

  int currentIndex = 0;
  GlobalKey<ScaffoldState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            key: key,
            endDrawer: drawerHome(),
            backgroundColor: Colors.white,
            body: SafeArea(
                child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 20, 0),
                      child: appBar()),
                  Container(
                      margin: const EdgeInsets.fromLTRB(17, 10, 0, 0),
                      child: const Text(
                        'Find Your\nExperience',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Darker',
                            fontSize: 28,
                            letterSpacing: 1.3,
                            height: 1.2,
                            fontWeight: FontWeight.w900),
                      )),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: sliderDestination(),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(18, 15, 0, 0),
                      child: const Text(
                        'Popular Categories',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Darker',
                            fontSize: 20,
                            letterSpacing: 1.3,
                            height: 1.2,
                            fontWeight: FontWeight.w900),
                      )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(9, 10, 9, 0),
                      child: tabDestination()),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: listDestination()),
                  Container(
                      margin: const EdgeInsets.fromLTRB(18, 15, 0, 0),
                      child: const Text(
                        'Recents Reviews',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Darker',
                            fontSize: 20,
                            letterSpacing: 1.3,
                            height: 1.2,
                            fontWeight: FontWeight.w900),
                      )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                      child: sliderReviewDestination()),
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
              key.currentState?.openEndDrawer();
            },
            elevation: 2.0,
            padding: const EdgeInsets.all(8),
            child:
                const Icon(Icons.menu_rounded, color: Colors.black87, size: 25),
          ),
          Text(
            "Hi, ${user!.displayName.toString().toTitleCase()}👋",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: 'Darker',
              fontSize: 17,
              letterSpacing: 1,
              color: Colors.black87,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: null,
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHx3aGl0ZXw%3D&auto=format&fit=crop&w=400&q=60'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  drawerHome() {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                  child: UserAccountsDrawerHeader(
                accountEmail: Text(user!.email.toString(),
                    style: const TextStyle(
                        fontFamily: 'Josefins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
                accountName: Text(user!.displayName.toString(),
                    style: const TextStyle(
                        fontFamily: 'Josefins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(110),
                  child: Image.network(
                    'https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHx3aGl0ZXw%3D&auto=format&fit=crop&w=400&q=60',
                    fit: BoxFit.cover,
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
              )),
              ListTile(
                title: const Text(
                  'Destination',
                  style: TextStyle(
                      fontFamily: 'Josefins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListDestination()),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Review',
                  style: TextStyle(
                      fontFamily: 'Josefins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListReview()),
                  );
                },
              ),
              ListTile(
                  title: const Text(
                    'Log Out',
                    style: TextStyle(
                        fontFamily: 'Josefins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }),
            ],
          ),
        ));
  }

  tabDestination() {
    return DefaultTabController(
      length: 5,
      child: TabBar(
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          labelPadding: const EdgeInsets.only(left: 25, right: 25),
          indicatorPadding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          isScrollable: true,
          labelColor: Colors.white,
          labelStyle: const TextStyle(
              fontFamily: 'Darker',
              fontSize: 15,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w800),
          unselectedLabelStyle: const TextStyle(
              fontFamily: 'Darker',
              fontSize: 15,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w800),
          unselectedLabelColor: Colors.black,
          indicator: RectangularIndicator(
            color: Colors.blue,
            bottomLeftRadius: 7,
            bottomRightRadius: 7,
            topLeftRadius: 7,
            topRightRadius: 7,
          ),
          tabs: myTabs),
    );
  }

  sliderDestination() {
    return SizedBox(
        height: 215,
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          StreamBuilder(
              stream: db.collection('destinations').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return CarouselSlider.builder(
                      itemCount: 4,
                      options: CarouselOptions(
                          autoPlay: true,
                          scrollDirection: Axis.horizontal,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          reverse: false,
                          aspectRatio: 16 / 9,
                          initialPage: 0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          }),
                      itemBuilder: (context, index, realIndex) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detail(
                                          documentSnapshot: documentSnapshot)));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            documentSnapshot['image']
                                                .toString()))),
                                child: Center(
                                    child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        bottom: 15,
                                        left: 20,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4.8),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaY: 15, sigmaX: 15),
                                            child: Container(
                                              height: 25,
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  const Icon(
                                                    Icons.location_on_rounded,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${documentSnapshot['name'].toString()}, ${documentSnapshot['country'].toString()}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        letterSpacing: 1,
                                                        height: 1.2,
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ))));
                      });
                }
              }),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: map<Widget>(Destination, (index, image) {
          //     return Container(
          //       width: _currentIndex == index ? 30 : 6,
          //       height: 6,
          //       margin: const EdgeInsets.fromLTRB(4, 20, 4, 0),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(5),
          //         color: _currentIndex == index
          //             ? Colors.blue
          //             : Colors.blue.withOpacity(0.3),
          //       ),
          //     );
          //   }),
          // )
        ])));
  }

  listDestination() {
    return SizedBox(
        height: 240,
        child: TabBarView(
          controller: _tabController,
          children: myTabs.map((Tab tab) {
            final String label = tab.text.toString().toLowerCase();
            return StreamBuilder(
                stream: db
                    .collection('destinations')
                    .where("category", isEqualTo: label)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return StreamBuilder(
                        stream: db
                            .collection('destinations')
                            .orderBy("name", descending: false)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (!streamSnapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: streamSnapshot.data!.docs.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];

                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Detail(
                                                  documentSnapshot:
                                                      documentSnapshot)));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 5),
                                      width: 255,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(1.5, 1.5),
                                            blurRadius: 1.0,
                                            spreadRadius: 2.0,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 160,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  documentSnapshot['image']
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Flexible(
                                            child: Text(
                                              documentSnapshot['desc']
                                                  .toString(),
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(
                                                  fontFamily: 'Josefins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.25,
                                                  fontSize: 13,
                                                  letterSpacing: 0.01,
                                                  wordSpacing: 0.01,
                                                  color: Colors.black45),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            );
                          }
                        });
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];

                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detail(
                                          documentSnapshot: documentSnapshot)));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                              width: 255,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(1.5, 1.5),
                                    blurRadius: 1.0,
                                    spreadRadius: 2.0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          documentSnapshot['image'].toString(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Flexible(
                                    child: Text(
                                      documentSnapshot['desc'].toString(),
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                          fontFamily: 'Josefins',
                                          fontWeight: FontWeight.w500,
                                          height: 1.25,
                                          fontSize: 13,
                                          letterSpacing: 0.01,
                                          wordSpacing: 0.01,
                                          color: Colors.black45),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ));
                      },
                    );
                  }
                });
          }).toList(),
        ));
  }

  sliderReviewDestination() {
    return SizedBox(
      height: 200,
      child: StreamBuilder(
          stream: db.collection('reviews').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.data == null ||
                streamSnapshot.data!.docs.isEmpty) {
              return CarouselSlider.builder(
                  itemCount: 1,
                  options: CarouselOptions(
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    reverse: false,
                    aspectRatio: 16 / 9,
                    initialPage: 0,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                        height: 150,
                        width: 300,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                        padding: const EdgeInsets.fromLTRB(20, 27, 20, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(1.5, 1.5),
                              blurRadius: 1.0,
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
                                    backgroundImage: AssetImage(
                                        "assets/img/developer.png"))),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      const Text(
                                        "Iqshan Bagus",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        "TRAVELIT HQ",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 10.0),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: RatingBar.builder(
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.blue,
                                      ),
                                      ignoreGestures: true,
                                      itemSize: 15,
                                      allowHalfRating: true,
                                      initialRating: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      onRatingUpdate: (value) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  const Text(
                                    "Be the first to leave a review on a place you've visited",
                                    maxLines: 2,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontFamily: 'Josefins',
                                      fontWeight: FontWeight.w500,
                                      height: 1.3,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          DateTime.now().toString(),
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 10.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ));
                  });
            } else {
              return CarouselSlider.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  options: CarouselOptions(
                      autoPlay: true,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      reverse: false,
                      aspectRatio: 16 / 9,
                      initialPage: 0,
                      onPageChanged: (index, reason) {
                        setState(() {});
                      }),
                  itemBuilder: (context, index, realIndex) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Container(
                        height: 150,
                        width: 300,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                        padding: const EdgeInsets.fromLTRB(20, 27, 20, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(1.5, 1.5),
                              blurRadius: 1.0,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        documentSnapshot['name'].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        documentSnapshot['place'].toString(),
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 10.0),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: RatingBar.builder(
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.blue,
                                      ),
                                      ignoreGestures: true,
                                      itemSize: 15,
                                      allowHalfRating: true,
                                      initialRating: documentSnapshot['star'],
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      onRatingUpdate: (value) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  Text(
                                    documentSnapshot['review'].toString(),
                                    maxLines: 2,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: 'Josefins',
                                      fontWeight: FontWeight.w500,
                                      height: 1.3,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          documentSnapshot['date'].toString(),
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 10.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ));
                  });
            }
          }),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
