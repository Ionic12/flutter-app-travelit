import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:last/pages/listDestination.dart';

class AddDestination extends StatelessWidget {
  const AddDestination({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAddDestination(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyAddDestination extends StatefulWidget {
  const MyAddDestination({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAddDestination createState() => _MyAddDestination();
}

class _MyAddDestination extends State<MyAddDestination> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final db = FirebaseFirestore.instance;
  @override
  void dispose() {
    nameController.dispose();
    cityController.dispose();
    countryController.dispose();
    descController.dispose();
    priceController.dispose();
    imageController.dispose();
    categoryController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SafeArea(
              child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 20, 0),
                        child: appBar()),
                    Container(child: inputCategory()),
                    Container(child: inputName()),
                    Container(child: inputCity()),
                    Container(child: inputCountry()),
                    Container(child: inputDesc()),
                    Container(child: inputPrice()),
                    Container(child: inputImage()),
                    Container(child: submitButton()),
                  ]),
            )));
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
                MaterialPageRoute(
                    builder: (context) => const ListDestination()),
              );
            },
            elevation: 2.0,
            padding: const EdgeInsets.all(8),
            child:
                const Icon(Icons.arrow_back, color: Colors.black87, size: 25),
          ),
          const Text(
            "Add Destination",
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

  inputCategory() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 10, 30, 0),
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TextFormField(
            controller: categoryController,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Josefins'),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              icon: Icon(Icons.category_outlined),
              labelText: 'Category',
            ),
          ),
        ));
  }

  inputName() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 10, 30, 0),
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TextFormField(
            controller: nameController,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Josefins'),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              icon: Icon(Icons.place_outlined),
              labelText: 'Name',
            ),
          ),
        ));
  }

  inputCity() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 10, 30, 0),
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TextFormField(
            controller: cityController,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Josefins'),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              icon: Icon(Icons.location_city_outlined),
              labelText: 'City',
            ),
          ),
        ));
  }

  inputCountry() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 10, 30, 0),
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TextFormField(
            controller: countryController,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Josefins'),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Country',
              icon: Icon(Icons.flag_circle_outlined),
            ),
          ),
        ));
  }

  inputDesc() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 10, 30, 0),
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TextFormField(
            maxLines: 5,
            controller: descController,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Josefins'),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Desc',
              icon: Icon(Icons.description_outlined),
            ),
          ),
        ));
  }

  inputPrice() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 10, 30, 0),
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: priceController,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Josefins'),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Price',
              icon: Icon(Icons.price_change_outlined),
            ),
          ),
        ));
  }

  inputImage() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 10, 30, 0),
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TextFormField(
            controller: imageController,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Josefins'),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              icon: Icon(Icons.image_aspect_ratio_outlined),
              labelText: 'Image',
            ),
          ),
        ));
  }

  submitButton() {
    return GestureDetector(
        onTap: () {
          final destination = <String, dynamic>{
            "category": categoryController.text,
            "name": nameController.text,
            "city": cityController.text,
            "country": countryController.text,
            "price": priceController.text,
            "desc": descController.text,
            "image": imageController.text
          };

          db.collection("destinations").add(destination).then(
              (DocumentReference doc) =>
                  print('DocumentSnapshot added with ID: ${doc.id}'));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListDestination()),
          );
        },
        child: Container(
          height: 40,
          margin: EdgeInsets.fromLTRB(35, 10, 35, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.blue),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: const FittedBox(
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontFamily: 'Josefins',
                      height: 1.2,
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ));
  }
}
