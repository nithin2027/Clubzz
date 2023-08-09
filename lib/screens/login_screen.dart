import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_part_of_app/screens/club_profile_clubs.dart';
import 'package:first_part_of_app/screens/club_profile_user.dart';
import 'package:first_part_of_app/screens/createEvent.dart';
import 'package:first_part_of_app/screens/home_screen.dart';
import 'package:first_part_of_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg Expression for email validation
        // if (!RegExp("^[a-zA-Z0-9+_,-]+@[a-zA-Z0-9,-]+,[a-z]").hasMatch(value)) {
        //   return ("Please Enter a valid Email");
        // }
        // return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefix: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter valid Password(Min. 6 Character");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefix: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 241, 148, 61),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 216, 69, 50),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 227, 158),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 150,
                      width: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset("assets/logo.png"),
                      )),
                  SizedBox(
                    height: 80,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                          color: Color.fromARGB(255, 245, 138, 37),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ]),
                  SizedBox(
                    height: 40,
                  ),
                  emailField,
                  SizedBox(
                    height: 45,
                  ),
                  passwordField,
                  SizedBox(
                    height: 45,
                  ),
                  loginButton,
                  SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 243, 87, 67),
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                color: Color.fromARGB(255, 236, 120, 43),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  // //Making Login fuctions
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                // Fluttertoast.showToast(msg: "Login Successful"),
                if (uid != null)
                  {
                    if (email.split("@")[1] != "bmsce.ac.in")
                      {Navigator.pushNamed(context, 'HomeScreen')}
                    else
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClubDetailPageClubs(
                                      club: email.split("@")[0].toLowerCase(),
                                    )))
                      }
                  }
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
//