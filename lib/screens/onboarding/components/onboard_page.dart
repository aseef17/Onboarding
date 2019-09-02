import 'package:flutter/material.dart';
import 'package:onboarding/providers/color_proivder.dart';
import 'package:onboarding/screens/onboarding/model/onboard_page_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'drawer_paint.dart';

class OnboardPage extends StatefulWidget {
  final PageController pageController;
  final OnboardPageModel pageModel;

  const OnboardPage({Key key, this.pageModel, this.pageController})
      : super(key: key);

  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> heroAnimation;
  Animation<double> borderAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));

    heroAnimation = Tween<double>(begin: -40, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));

    borderAnimation = Tween<double>(begin: 0, end: 50).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));

    animationController.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _nextButtonPressed() {
    Provider.of<ColorProvider>(context).color = widget.pageModel.nextAccentColor;
    widget.pageController.nextPage(
      duration: Duration(
        milliseconds: 100,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
    );
    // print(Provider.of<ColorProvider>(context).color);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          color: widget.pageModel.primeColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              AnimatedBuilder(
                animation: heroAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(heroAnimation.value, 0),
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.125),
                      child: SvgPicture.asset(widget.pageModel.imagePath, height: height * 0.3,)
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Container(
                  height: height * 0.35,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          widget.pageModel.caption,
                          style: TextStyle(
                            fontSize: width * 0.075,
                            color:
                                widget.pageModel.accentColor.withOpacity(0.5),
                            letterSpacing: 1,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          widget.pageModel.subhead,
                          style: TextStyle(
                            fontSize: width * 0.09,
                            fontWeight: FontWeight.bold,
                            color: widget.pageModel.accentColor,
                            letterSpacing: 1,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          widget.pageModel.description,
                          style: TextStyle(
                            fontSize: width * 0.045,
                            color:
                                widget.pageModel.accentColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: AnimatedBuilder(
            animation: borderAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: DrawerPaint(
                  curveColor: widget.pageModel.accentColor,
                ),
                child: Container(
                  width: borderAnimation.value,
                  height: height,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.045, left: 0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: widget.pageModel.primeColor,
                          size: width * 0.075,
                        ),
                        onPressed: _nextButtonPressed,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
