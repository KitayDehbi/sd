import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/controllers/User.controller.dart';
import 'package:strong_delivery/models/User.dart';
import 'package:strong_delivery/screens/CommandeHistory.dart';
import 'package:strong_delivery/screens/auth/space_screen.dart';
import 'package:strong_delivery/screens/compte.dart';
import 'package:strong_delivery/widgets/BottomMenu.dart';
import 'package:strong_delivery/widgets/profile_menu.dart';
import 'package:strong_delivery/widgets/profile_picture.dart';

class ProfileClient extends StatefulWidget {
  //const ProfileClient({Key key}) : super(key: key);

  @override
  _ProfileClientState createState() => _ProfileClientState();
}

class _ProfileClientState extends State<ProfileClient> {
  UserController userController = new UserController();
  Future user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomMenu(2),
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
