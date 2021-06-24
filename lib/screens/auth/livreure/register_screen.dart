import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/controllers/AuthController.dart';
import 'package:strong_delivery/screens/auth/livreure/ProfileLivreure.dart';
import 'package:strong_delivery/screens/home_screen.dart';
import 'login_screen.dart';

class RegisterLivreure extends StatefulWidget {
  @override
  _RegisterLivreureState createState() => _RegisterLivreureState();
}

class _RegisterLivreureState extends State<RegisterLivreure> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController ribController = TextEditingController();
  final AuthController _authController = AuthController();
  bool loading = false;
  signUp(
      String nom, String email, String password, String tel, String adresse, String rib) {
    setState(() {
      loading = true;
      _authController
          .signUp(nom, email.trim(), password, tel, adresse, rib)
          .whenComplete(() async {
        if (_authController.getStatus() != 200) {
          setState(() {
            loading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('une erreur s\'est produite')));

            emailController.text = "";
            passwordController.text = "";
            phoneController.text = "";
          });
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', _authController.getToken());
          setState(() {
            loading = false;
          });
          Get.to(ProfileLivreure());
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
                      top: 10.0, left: 10.0, right: 10.0, bottom: 30.0),
                  child: Container(
                    height: 580.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'S’inscrire sur Strong delivery',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'entrez votre Nom';
                                    }
                                    return null;
                                  },
                                  controller: nomController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.perm_identity_sharp),
                                    labelText: 'Nom complet',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'entrez votre email';
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.mail_outline_sharp),
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'entrez votre mot de passe';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'entrez votre Numero de tel';
                                    }
                                    return null;
                                  },
                                  controller: phoneController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.phone),
                                    labelText: 'Tel',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'entrez votre adresse';
                                    }
                                    return null;
                                  },
                                  controller: adresseController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.location_pin),
                                    labelText: 'Adresse',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'entrez votre rib';
                                    }
                                    return null;
                                  },
                                  controller: ribController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.location_pin),
                                    labelText: 'Rib',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 20.0, right: 50.0, left: 50.0),
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
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        await signUp(
                                            nomController.text,
                                            emailController.text,
                                            passwordController.text,
                                            phoneController.text,
                                            adresseController.text,
                                            ribController.text,
                                            );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'veuillez remlir les champs')));
                                      }
                                    },
                                    child: Text(
                                      'S\'inscrire',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.0),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Déjà inscrit ? ",
                                style: TextStyle(color: Colors.black87)),
                            TextSpan(
                                text: "S\'identifier",
                                style: TextStyle(
                                    color: Colors.teal[600],
                                    fontWeight: FontWeight.w600),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => Get.to(LoginLivreure())),
                          ]),
                        ),
                        Spacer(),
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
