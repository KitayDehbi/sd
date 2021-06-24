import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:strong_delivery/models/CommandeWithPlats.dart';

class CommandeDetails extends StatefulWidget {
  final CommandeWithPlat cmd;

  CommandeDetails({this.cmd});

  @override
  _CommandeDetailsState createState() => _CommandeDetailsState();
}

class _CommandeDetailsState extends State<CommandeDetails> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  bool expanded = false;

  Icon icon = Icon(
    Icons.add,
    color: Colors.deepOrange,
    size: 30.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Commande : ' + widget.cmd.getCmd().getId().toString()),
        ),
        body: Column(children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(
                      //color: Colors.black,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                              //color: Colors.black,
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            // padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Le :  ${widget.cmd.getCmd().getDate().split(' ')[0]}',
                              style: TextStyle(
                                  backgroundColor: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Totale ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${widget.cmd.getCmd().getPrix().toString()} €',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.deepOrange),
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    // ListView.builder(

                    //   itemCount: cmd.getPaniers().length,
                    //   itemBuilder: (context, index){
                    ExpansionTile(
                      onExpansionChanged: (flag) {
                        setState(() {
                          expanded = !expanded;
                          expanded == true
                              ? icon = Icon(
                                  Icons.close,
                                  color: Colors.deepOrange,
                                  size: 30.0,
                                )
                              : icon = Icon(
                                  Icons.add,
                                  color: Colors.deepOrange,
                                  size: 30.0,
                                );
                        });
                      },
                      title: Text(
                        'Les Plats',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      children: [
                        Center(
                          child: Text(
                            'Vous avez Commandé',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        for (var item in widget.cmd.getPaniers())
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200.0),
                                  //child: ,
                                  child: Image.network(
                                    "${Server.imageUrl + item.getPlat().getImage()}",
                                    fit: BoxFit.fill,
                                    width: 90,
                                    height: 90,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.deepOrange,
                                          backgroundColor: Colors.deepOrange,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  item.getPlat().getNom(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.getOccurance().toString() + " Unité(s)",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.deepOrange),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  (item.getOccurance() *
                                              item.getPlat().getPrix())
                                          .toString() +
                                      ' €',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.deepOrange),
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                ),
                              )
                            ],
                          ),
                      ],
                      trailing: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              new BoxShadow(
                                //color: Colors.black,
                                blurRadius: 15.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: icon),
                    )

                    //})
                  ],
                ),
              ))
        ]));
  }
}
