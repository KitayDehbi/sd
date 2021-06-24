import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strong_delivery/controllers/AuthController.dart';
import 'package:strong_delivery/screens/auth/livreure/ProfileLivreure.dart';
import 'register_screen.dart';

class LoginLivreure extends StatefulWidget {
  @override
  _LoginLivreureState createState() => _LoginLivreureState();
}

class _LoginLivreureState extends State<LoginLivreure> {
  final AuthController _authController = AuthController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  auth(String email, String password) {
    setState(() {
      loading = true;
      _authController
          .authentication(email.trim(), password)
          .whenComplete(() async {
        if (_authController.getStatus() != 200) {
          setState(() {
            loading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('email ou mot de passe inccorecte')));

            emailController.text = "";
            passwordController.text = "";
          });
        } else {
          if (_authController.getRole() == 'livreure') {
            setState(() {
              loading = false;
            });
            navigator.pushReplacement<void, void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ProfileLivreure(),
              ),
            );
          } else {
            setState(() {
              loading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('vous n\êtes pas autorisé')));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Image.asset('assets/images/stronglogo.png', fit: BoxFit.cover),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0, left: 10.0, right: 10.0, bottom: 30.0),
                  child: Container(
                    height: 340.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'S’identifier sur Strong Delivery comme Livreure',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  //initialValue: "admin@gmail.com",
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'entrez votre email';
                                    }
                                    return null;
                                  },
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.mail_outline_sharp),
                                    labelText: 'Email',
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: TextFormField(
                                    //initialValue: "password",
                                    obscureText: true,
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'entez votre mot de passe';
                                      }
                                      return null;
                                    },
                                    cursorColor: Theme.of(context).primaryColor,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.lock_outline_sharp),
                                      labelText: 'Mot de passe',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 5.0, right: 50.0, left: 50.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: loading == true
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                            color: Colors.deepOrangeAccent,
                                          ))
                                        : RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                await auth(emailController.text,
                                                    passwordController.text);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'veuillez remlir les champs')));
                                              }
                                            },
                                            child: Text(
                                              'Connexion',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Pas inscrit ? ",
                                style: TextStyle(color: Colors.black87)),
                            TextSpan(
                                text: "S'inscrire",
                                style: TextStyle(
                                    color: Colors.teal[600],
                                    fontWeight: FontWeight.w600),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => Get.to(RegisterLivreure())),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
