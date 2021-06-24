import 'package:flutter/material.dart';

class RestauIconWidget extends StatefulWidget {
  RestauIconWidget({Key key}) : super(key: key);

  @override
  _RestauIconWidgetState createState() => _RestauIconWidgetState();
}

class _RestauIconWidgetState extends State<RestauIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment(0, 0),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFFE94E1A),
              shape: BoxShape.circle,
            ),
            child: Align(
              alignment: Alignment(0.65, 0.1),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  'https://i.pinimg.com/originals/26/68/68/26686841ba64e5227955c4aca98259a7.png',
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.25,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
