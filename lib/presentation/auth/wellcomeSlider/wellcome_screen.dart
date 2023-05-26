import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/auth/wellcomeSlider/wellcome_screen_con.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class WellcomeScreen extends StatelessWidget {
  final WelcomeController _con = Get.put(WelcomeController());

  WellcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: Text(
                      _con.currentIndex.value == 2 ? "START" : "SKIP",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                  Icon(Icons.chevron_right, color: AppColors.primaryColor)
                ],
              ),
            ),
            Stack(
              children: [
                CarouselSlider(
                  carouselController: _con.carouselController,
                  options: CarouselOptions(
                      height: Get.height * 0.4,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      aspectRatio: 1.0,
                      onPageChanged: (index, reason) {
                        _con.currentIndex.value = index;
                      }),
                  items: List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Image.asset(_con.welcomeList[index].image!),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: Get.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => indicator(index, _con.currentCarouselIndex.value),
              ),
            ),
            SizedBox(height: Get.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                _con.welcomeList[_con.currentIndex.value].title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                _con.welcomeList[_con.currentIndex.value].subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color(0xffB8B8B9),
                  height: 1.3,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.07),
            GestureDetector(
              onTap: () {
                _con.currentIndex.value;
                _con.currentIndex.value == 2
                    ? Get.toNamed(AppRoutes.loginScreen)
                    : _con.carouselController.nextPage();
              },
              child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.east,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  indicator(
    int index,
    int value,
  ) {
    return Obx(() => Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(2),
          height: index == _con.currentIndex.value ? 12 : 8,
          width: index == _con.currentIndex.value ? 12 : 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  color: index == _con.currentIndex.value
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(0.5))),
          child: Container(
            decoration: BoxDecoration(
              color: index == _con.currentIndex.value
                  ? AppColors.primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ));
  }
}
