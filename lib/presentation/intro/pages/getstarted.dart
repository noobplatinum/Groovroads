import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:groovroads/core/configs/assets/appimgs.dart';
import 'package:groovroads/core/configs/assets/appvectors.dart';
import 'package:groovroads/common/widgets/button/entrybutton.dart';
import 'package:groovroads/presentation/modeoptions/modeoptions.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  late PageController _pageController;
  bool _isPageActive = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollEndNotification) {
            setState(() {
              _isPageActive = _pageController.page == 0;
            });
          }
          return true;
        },
        child: PageView(
          controller: _pageController,
          children: [
            Stack(
              children: [
                carousel_slider.CarouselSlider(
                  options: carousel_slider.CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1.0,
                    autoPlay: _isPageActive,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  items: [
                    Appimages.BG1,
                    Appimages.BG2,
                    Appimages.BG3,
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(i),
                            ),
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.5), // Darken only the background
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: _opacity,
                        duration: const Duration(seconds: 1),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 60), // Reduce the upper margin
                              child: Image.asset(
                                Appvectors.logo,
                                width: 300,
                                height: 150,
                              ),
                            ),
                            const SizedBox(height: 8), // Adjust the space here (reduce from 1 to 8 for slight spacing)
                            const Text(
                              'On Any Road You Travel',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                color: Colors.white70,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      EntryButton(
                        onPressed: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (BuildContext context) => const ModeOptions())
                          );
                        },
                        title: 'Get Started',
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 40, top: 30),
                        child: Text(
                          'Begin Your Musical Journey',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}