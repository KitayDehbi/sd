import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/controllers/User.controller.dart';
import 'package:strong_delivery/models/User.dart';
import 'package:strong_delivery/screens/CommandeHistory.dart';
import 'package:strong_delivery/screens/auth/space_screen.dart';
import 'package:strong_delivery/screens/compte.dart';
import 'package:slider_button/slider_button.dart';
import 'package:strong_delivery/widgets/profile_menu.dart';
import 'package:strong_delivery/widgets/profile_picture.dart';

class ProfileLivreure extends StatefulWidget {
  //const ProfileClient({Key key}) : super(key: key);

  @override
  _ProfileLivreureState createState() => _ProfileLivreureState();
}

class _ProfileLivreureState extends State<ProfileLivreure> {
  UserController userController = new UserController();
  User user;
  String str = "available";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getUser();
    str = "available";
    //str=user.getRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //bottomNavigationBar: BottomMenu(2),
        appBar: AppBar(
          title: Text(
            "Profile",
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: userController.getUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.deepOrange,
                ),
              );
            } else {
              return Column(
                children: [
                  ProfilePic(image: 'assets/images/profile.jpg'),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Center(
                        child: Container(
                            child: Center(
                                child: SliderButton(
                      vibrationFlag: false,

                      action: () async{
                         str = await userController.switchState(snapshot.data.getAvailable());
                        setState(() {
                          
                        });
                      },
                      dismissible: false,

                      ///Put label over here
                      label: Text(
                        snapshot.data.getAvailable().toString() == 'available'
                            ? 'Disponible'
                            : 'Indiponible',
                        style: TextStyle(
                            color: Color(0xff4a4a4a),
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                      icon: Center(
                          child: Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                        size: 40.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      )),

                      //Put BoxShadow here
                      boxShadow: BoxShadow(
                        color: Colors.black,
                        blurRadius: 4,
                      ),

                      //Adjust effects such as shimmer and flag vibration here
                      // shimmer: true,
                      // vibrationFlag: true,

                      ///Change All the color and size from here.
                      width: 230,
                      radius: 10,
                      buttonColor: Colors.deepOrange,
                      backgroundColor: Colors.white,
                      highlightedColor: Colors.deepOrange,
                      baseColor: Colors.deepOrange,
                    )))),
                  ),
                  ProfileMenu(
                      text: 'Profile',
                      icon: 'assets/icons/user.svg',
                      press: () {
                        Get.to(Compte(
                            user: User(
                                name: snapshot.data.getNom(),
                                adresse: snapshot.data.getAdresse(),
                                email: snapshot.data.getEmail(),
                                password: snapshot.data.getPassword(),
                                photo: snapshot.data.getPhoto(),
                                rib: snapshot.data.getRib(),
                                tel: snapshot.data.getTel(),
                                role: snapshot.data.getRole())));
                      }),
                  ProfileMenu(
                      text: 'Notification',
                      icon: 'assets/icons/bell.svg',
                      press: () {}),
                  ProfileMenu(
                      text: 'Historique',
                      icon: 'assets/icons/history.svg',
                      press: () {
                        Get.to(CommandeHistory());
                      }),
                  ProfileMenu(
                      text: 'Log Out',
                      icon: 'assets/icons/logout.svg',
                      press: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.clear();
                        //Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(pageBuilder: (BuildContext context,
                                Animation animation,
                                Animation secondaryAnimation) {
                              return Space();
                            }, transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return new SlideTransition(
                                position: new Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            }),
                            (Route route) => false);
                      }),
                ],
              );
            }
          },
        ));
  }
}
