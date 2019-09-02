import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/providers/color_proivder.dart';
import 'package:onboarding/screens/onboarding/components/onboard_page.dart';
import 'package:onboarding/screens/onboarding/data/onboard_page_data.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController pageController = PageController();

  int currentPageValue = 0;

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: onboardData.length,
          onPageChanged: (int page) {
            getChangedPageAndMoveBar(page);
          },
          itemBuilder: (context, index) {
            return OnboardPage(
              pageController: pageController,
              pageModel: onboardData[index],
            );
          },
        ),
        Container(
          width: double.infinity,
          height: height * 0.1,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Text(
                    'creatium',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: colorProvider.color),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.07),
                  child: Text(
                    'Skip',
                    style: TextStyle(color: colorProvider.color),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding:
                EdgeInsets.only(bottom: height * 0.075, left: width * 0.085),
            child: DotsIndicator(
              dotsCount: onboardData.length,
              position: currentPageValue,
              decorator: DotsDecorator(
                color: colorProvider.color.withOpacity(0.5),
                activeColor: colorProvider.color,
                size: Size.square(width * 0.025),
                activeSize: Size(width * 0.05, width * 0.025),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.025),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
