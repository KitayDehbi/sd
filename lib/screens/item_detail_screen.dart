import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:strong_delivery/controllers/CartController.dart';
import 'package:strong_delivery/controllers/countController.dart';
import 'package:strong_delivery/controllers/platController.dart';
import 'package:strong_delivery/models/CartProduct.dart';

class ItemDetail extends StatefulWidget {
  final int id;

  const ItemDetail({this.id});
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  int count = 1;
  PlatController platController = new PlatController();
  CartController cartController = new CartController();
  int id;
  @override
  void initState() {
    super.initState();
    platController.getPlatById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //bottomNavigationBar: BottomMenu(),
        body: FutureBuilder(
      future: platController.getPlatById(widget.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.deepOrange,
            ),
          );
        } else {
          return ListView(
            children: [
              Stack(children: [
                Container(
                  // width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              Server.imageUrl + snapshot.data.getImage()),
                          fit: BoxFit.cover)),
                ),
                Center(
                  // padding: const EdgeInsets.only(left: 30.0, right: 45.0 ,top: 190),

                  child: Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: 10.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${snapshot.data.getNom()}',
                          style: TextStyle(
                              backgroundColor: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("Prix : ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 120.0, top: 10, bottom: 10),
                      child: Text(
                        "${snapshot.data.getPrix()} € ",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 60.0,
                        bottom: 20,
                      ),
                      child: Text("Description :  ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${snapshot.data.getDescription()}',
                        style: TextStyle(
                            backgroundColor: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 30,
                      child: OutlineButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          setState(() {
                            if (count > 1) count -= 1;
                          });
                        },
                        child: Icon(Icons.remove),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$count",
                        style: TextStyle(
                            backgroundColor: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                    ), //;

                    SizedBox(
                      width: 40,
                      height: 30,
                      child: OutlineButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          setState(() {
                            count += 1;
                          });
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadiusDirectional.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 4.0, bottom: 4.0),
                    child: Text(
                      "${snapshot.data.getPrix() * count}€",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF00A182)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                    ),
                    onPressed: () {
                      cartController.addProduct(CartProduct(
                        image: snapshot.data.getImage(),
                        name: snapshot.data.getNom(),
                        price: snapshot.data.getPrix(),
                        plat_id: snapshot.data.getId(),
                        quantity: count,
                      ));

                      Get.back();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Le plat a été bien ajouté')));
                    },
                    child: Text(
                      "Ajouter à votre commande",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              )
            ],
          );
        }
      },
    ));
  }
}
