import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:last/pages/login.dart';
import 'package:last/services/src/service/helper.dart';
import '../services/auth.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = FirebaseAuthService(
    authService: FirebaseAuth.instance,
  );
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/img/login.png'), context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: Container(
                  height: (MediaQuery.of(context).size.height),
                  width: (MediaQuery.of(context).size.width),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/login.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(5, 30, 5, 100),
                          child: appBar()),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Text('SIGN UP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Josefins'))),
                      Container(
                        margin: const EdgeInsets.fromLTRB(25, 10, 30, 0),
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: TextFormField(
                            controller: usernameController,
                            maxLength: 10,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Josefins'),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.people_outline),
                              counterText: '',
                              labelText: 'Username',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25, 10, 30, 0),
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: TextFormField(
                            controller: emailController,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Josefins'),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.email_outlined),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25, 10, 30, 0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Josefins'),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.password_outlined),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: const BorderSide(
                                            color: Colors.blue)))),
                            child: const Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2.0,
                                    fontFamily: 'Josefins')),
                            onPressed: () async {
                              try {
                                await authService
                                    .createUserWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                                User? updateUser =
                                    FirebaseAuth.instance.currentUser;
                                // ignore: deprecated_member_use
                                updateUser?.updateProfile(
                                    displayName: usernameController.text);
                                userSetup(usernameController.text,
                                    emailController.text);
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              } catch (e) {
                                print(e);
                              }
                            },
                          )),
                      Container(
                          margin: const EdgeInsets.only(bottom: 252),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Already have account?',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Josefins')),
                              TextButton(
                                child: const Text('Sign In',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Josefins')),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                              )
                            ],
                          )),
                    ],
                  ),
                ))));
  }

  appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RawMaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          constraints: const BoxConstraints(minWidth: 0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          elevation: 2.0,
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.arrow_back, color: Colors.black87, size: 25),
        ),
      ],
    );
  }
}
