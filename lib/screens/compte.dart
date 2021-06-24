import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strong_delivery/controllers/User.controller.dart';
import 'package:strong_delivery/models/User.dart';
import 'package:strong_delivery/screens/auth/client/profile.dart';
import 'package:strong_delivery/screens/auth/livreure/ProfileLivreure.dart';

class Compte extends StatefulWidget {
  const Compte({@required this.user, key}) : super(key: key);
  final User user;

  @override
  _CompteState createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  UserController userController = new UserController();
  TextEditingController nomController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController ribController = new TextEditingController();
  TextEditingController adresseController = new TextEditingController();
  TextEditingController telController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    //userController.getUser();
    //print(widget.user.getRole());
    nomController = new TextEditingController(text: widget.user.getNom());
    emailController = new TextEditingController(text: widget.user.getEmail());
    passwordController =
        new TextEditingController(text: widget.user.getPassword());
    ribController = new TextEditingController(text: widget.user.getRib());
    adresseController =
        new TextEditingController(text: widget.user.getAdresse());
    telController = new TextEditingController(text: widget.user.getTel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(
            "Mon Compte",
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                    child: Container(
                      height: 520.0,
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
                            height: 10.0,
                          ),
                          Text(
                            'Modifier vos Informations',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: TextFormField(
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
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: TextFormField(
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
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: TextFormField(
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
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: TextFormField(
                              controller: telController,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                icon: Icon(Icons.phone),
                                labelText: 'Phone',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: TextFormField(
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
                          widget.user.getRole() == 'livreure'
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: TextFormField(
                                    controller: ribController,
                                    cursorColor: Theme.of(context).primaryColor,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.credit_card),
                                      labelText: 'RIB',
                                    ),
                                  ),
                                )
                              : Container(height: 0),
                          Container(
                            margin: EdgeInsets.only(
                                top: 20.0, right: 50.0, left: 50.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: () async {
                                  await userController.updateUser(User(
                                      adresse: adresseController.text,
                                      email: emailController.text,
                                      name: nomController.text,
                                      password: passwordController.text,
                                      rib: ribController.text,
                                      tel: telController.text,
                                      role: widget.user.getRole()));
                                      if(widget.user.getRole() != 'livreure')

                                  Get.to(() => ProfileClient());
                                  else Get.to(ProfileLivreure());
                                },
                                child: Text(
                                  'Modifier',
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
                ),
              ],
            ),
          ],
        ));
  }
}
