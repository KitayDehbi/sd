import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageviewWidget extends StatefulWidget {
  PageviewWidget({Key key}) : super(key: key);

  @override
  _PageviewWidgetState createState() => _PageviewWidgetState();
}

class _PageviewWidgetState extends State<PageviewWidget> {
  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Container(
          width: double.infinity,
          height: 500,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: PageView(
                  controller: pageViewController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/images/mcdonalds.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/images/burgerking.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/images/tacosdelyon.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0, 0.9),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(1, 0, 0, 10),
                  child: SmoothPageIndicator(
                    controller: pageViewController,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    onDotClicked: (i) {
                      pageViewController.animateToPage(
                        i,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    effect: ExpandingDotsEffect(
                      expansionFactor: 2,
                      spacing: 10,
                      radius: 7,
                      dotWidth: 16,
                      dotHeight: 16,
                      dotColor: Color(0x37FFE703),
                      activeDotColor: Color(0xB1FFE703),
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
