import 'package:flutter/material.dart';
import 'package:shop/modules/login/shop_login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({this.image, this.title, this.body});
}

class OnBoardingScreen extends StatelessWidget {
  PageController pageController = PageController();
  bool isLastIndex = false;
  List<BoardingModel> list = [
    BoardingModel(
      image: 'assets/images/on_boarding1.png',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body'
    ),
    BoardingModel(
        image: 'assets/images/on_boarding2.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'
    ),
    BoardingModel(
      image: 'assets/images/on_boarding1.png',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body'
    ),
  ];

  OnBoardingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {skip(context);},
            child: const Text('SKIP', style: TextStyle(fontSize: 16))
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) => buildOnBoardingItem(list[index]),
                itemCount: list.length,
                onPageChanged: (index) {
                  if(index == list.length-1) {isLastIndex = true;}
                  else {isLastIndex = false;}
                },
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: list.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLastIndex) {skip(context);}
                    else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.easeInOut
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset(model.image)),
        const SizedBox(height: 20),
        Text(model.title, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        Text(model.body, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  void skip(BuildContext context) {
    CacheHelper.setData(key: 'isOnBoardingDone', value: true).then((value) {
      if(value) {navigateTo(context, ShopLoginScreen(), true);}
    });
  }
}