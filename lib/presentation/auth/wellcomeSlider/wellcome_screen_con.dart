import 'package:BikeX/core/app_export.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomeController extends GetxController {
  RxInt currentCarouselIndex = 0.obs;
  CarouselController carouselController = CarouselController();
  RxInt currentIndex = 0.obs;
  RxList<Welcome> welcomeList = RxList([
    Welcome(
      image: ImageConstant.splash1,
      title: "Alege sa mergi cu ce-ti place",
      subtitle:
          "Avem o varietate larga de biciclete si trotinete din care poti alege.",
    ),
    Welcome(
      image: ImageConstant.splash2,
      title: "Mereu cea mai apropiata bicicleta",
      subtitle: "Folosind mapa, puteti localiza cea mai apropiata bicicleta.",
    ),
    Welcome(
      image: ImageConstant.splash3,
      title: "Salveaza mediul",
      subtitle: "Alege Bike X pentru a trai intr-un oras verde.",
    )
  ]);
}

class Welcome {
  String title;
  String subtitle;
  String? image;
  Welcome({required this.title, required this.subtitle, this.image});
}
