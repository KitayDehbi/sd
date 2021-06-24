import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:strong_delivery/controllers/commandeController.dart';
import 'package:strong_delivery/models/Commande.dart';
import 'package:strong_delivery/models/CommandeWithPlats.dart';
import 'package:strong_delivery/screens/CommandeDetails.dart';

class CommandeHistory extends StatefulWidget {
  @override
  _CommandeHistoryState createState() => _CommandeHistoryState();
}

class _CommandeHistoryState extends State<CommandeHistory> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  final CommandeController commandeController = new CommandeController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    commandeController.getAllCommandesByUserId();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      // bottomNavigationBar: BottomMenu(1),
      appBar: AppBar(
        title: Center(child: Text("Historique de Commande")),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              // color: Colors.green[50],
              child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: FutureBuilder(
                    future: commandeController.getAllCommandesByUserId(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            color: Colors.deepOrange,
                          ),
                        );
                      } else {
                        return ListView.builder( 
                          
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(CommandeDetails(
                                        cmd: snapshot.data[index],
                                      ));
                                    },
                                    child: Container(
                                      //color: Colors.deepOrange,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          new BoxShadow(
                                            //color: Colors.black,
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  new BoxShadow(
                                                    //color: Colors.black,
                                                    blurRadius: 5.0,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  // padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Commande :  ${snapshot.data[index].getCmd().getId()}',
                                                    style: TextStyle(
                                                        backgroundColor:
                                                            Colors.white,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  snapshot.data[index]
                                                      .getCmd()
                                                      .getDate(),
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '${snapshot.data[index].getCmd().getPrix()} €',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.deepOrange),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
