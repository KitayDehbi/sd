import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strong_delivery/controllers/CartController.dart';
import 'package:strong_delivery/models/CartProduct.dart';
import 'package:strong_delivery/screens/livraison_adresse.dart';
import 'package:strong_delivery/widgets/BottomMenu.dart';
import 'package:strong_delivery/Statics/server.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartController cartController;
  List<CartProduct> plats;
  double totalPrice;
  @override
  void initState() {
    super.initState();
    cartController = new CartController();
    getplats();
  }

  Future<List<CartProduct>> getplats() async {
    plats = await cartController.getAllProduct();
    totalPrice = await cartController.getTotalPrice();
    return plats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Votre Panier"),
        //   centerTitle: true,
        // ),
        bottomNavigationBar: BottomMenu(1),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: FutureBuilder(
                    future: getplats(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            color: Colors.deepOrange,
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: ListView.builder(
                            itemCount: plats.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) {
                                  cartController
                                      .deleteProduct(plats[index].plat_id);
                                  //controller.cartProduct.removeAt(index);
                                  Scaffold.of(context)
                                      .showSnackBar(new SnackBar(
                                    content: new Text("plats supprimés"),
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0, bottom: 14.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    Server.imageUrl +
                                                        plats[index].image),
                                                fit: BoxFit.cover)),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 22.0),
                                                child: Text(
                                                  '${plats[index].name}',
                                                  style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                  maxLines: 2,
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: 5.0,
                                            // ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                // color: Colors.red,
                                                width: 100.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: OutlineButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        onPressed: () {
                                                          // Get.find<CountController>().decrease();
                                                          // Get.find<CountController>().totalPrice();
                                                          // countController.decrease();
                                                          setState(() {
                                                            if (plats[index]
                                                                    .quantity >
                                                                1) {
                                                              plats[index]
                                                                  .quantity -= 1;
                                                              cartController.update(
                                                                  plats[index]
                                                                      .plat_id,
                                                                  plats[index]
                                                                      .quantity);
                                                              totalPrice -=
                                                                  plats[index]
                                                                      .price;
                                                            }
                                                          });
                                                        },
                                                        child:
                                                            Icon(Icons.remove),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "${plats[index].quantity}",
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: DecoratedBox(
                                                        decoration: ShapeDecoration(
                                                            shape:
                                                                CircleBorder(),
                                                            color: Colors
                                                                .deepOrangeAccent),
                                                        child: OutlineButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          onPressed: () {
                                                            // Get.find<CountController>().decrease();
                                                            // Get.find<CountController>().totalPrice();
                                                            // countController.increase();
                                                            setState(() {
                                                              plats[index]
                                                                  .quantity += 1;
                                                              cartController.update(
                                                                  plats[index]
                                                                      .plat_id,
                                                                  plats[index]
                                                                      .quantity);
                                                              totalPrice +=
                                                                  plats[index]
                                                                      .price;
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),

                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 22.0),
                                                child: Text(
                                                  "${plats[index].quantity * plats[index].price} €",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.deepOrange),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }),
              ),
            ),
            FutureBuilder(
                future: getplats(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.deepOrange,
                      ),
                    );
                  else
                    return Container(
                      height: 100.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                ),
                                maxLines: 1,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                              SizedBox(width: 40.0),
                              Text(
                                "$totalPrice €",
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.deepOrange),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10.0,
                                right: 50.0,
                                left: 50.0,
                                bottom: 10.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  Get.to(LivraisonAdresse());
                                },
                                child: Text(
                                  'COMMANDER',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                }),
          ],
        ));
  }
}
