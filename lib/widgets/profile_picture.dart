import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    @required this.image,
    Key key,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
            Positioned(
              bottom: 0,
              right: -12,
              child: SizedBox(
                height: 46,
                width: 46,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.white)),
                  color: Color(0xFFF5F6F9),
                  onPressed: () {},
                  child: SvgPicture.asset("assets/icons/camera.svg",
                      color: Color(0xFFE94E1A)),
                ),
              ),
            )
          ],
        ));
  }
}
