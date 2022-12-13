import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:last/pages/login.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF053149);

  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: OnBoardingSlider(
              finishButtonColor: Colors.blue,
              finishButtonText: 'Register',
              finishButtonTextStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.0,
                  fontFamily: 'Josefins'),
              onFinish: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              skipTextButton: const Text(
                'Skip',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Josefins'),
              ),
              trailing: const Text(
                'Login',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Josefins'),
              ),
              trailingFunction: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              controllerColor: kDarkBlueColor,
              totalPage: 3,
              headerBackgroundColor: Colors.white,
              pageBackgroundColor: Colors.white,
              background: [
                Image.asset(
                  'assets/img/onBoard_1.jpg',
                  height: 500,
                  width: 350,
                ),
                Image.asset(
                  'assets/img/onBoard_2.jpg',
                  height: 500,
                  width: 360,
                ),
                Image.asset(
                  'assets/img/onBoard_3.jpg',
                  height: 500,
                  width: 360,
                ),
              ],
              speed: 5,
              pageBodies: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 480,
                      ),
                      Text(
                        'Get Ready To Explore',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kDarkBlueColor,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Josefins'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'When visiting a new place you have one-shot to make the right choice and enjoy the experience.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 18.0,
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Josefins'),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 480,
                      ),
                      Text(
                        'TRAVELIT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kDarkBlueColor,
                            fontSize: 24.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            fontFamily: 'Darker'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Sometimes people have to go to unexpected places that they didnt choose. When I dont know anything about my destination, I turn to travelit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 18.0,
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Josefins'),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 480,
                      ),
                      Text(
                        'Start now!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kDarkBlueColor,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Josefins'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Do not go where the path may lead, go instead where there is no path and leave a trail.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 18.0,
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Josefins'),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
