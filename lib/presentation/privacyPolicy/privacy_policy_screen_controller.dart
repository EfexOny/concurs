import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  RxString searchText = "".obs;
  RxBool isSearch = false.obs;
  RxBool isLoading = false.obs;
  RxBool noData = false.obs;
  // CategoryModel? categoryModel;
  List termsConditionList = [
    {
      "id": 1,
      "title": "Privacy",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipisc sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitat ullamco laboris nisi ut aliquip commodo consequat."
    },
    {
      "title": "Electronic Communications",
      "id": 2,
      "description":
          "Nemo enim ipsam voluptatem quia voluptas sit aut odit aut fugit\nNemo enim ipsam voluptatem quia voluptas.\nNemo enim ipsam voluptatem quia voluptas sit aut odit aut fugit\nNemo enim ipsam voluptatem quia voluptas."
    },
    {
      "title": "",
      "id": 3,
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipisc sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitat ullamco laboris nisi ut aliquip commodo consequat."
    },
    {
      "title": "",
      "id": 4,
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipisc sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitat ullamco laboris nisi ut aliquip commodo consequat."
    },
    {
      "title": "",
      "id": 5,
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipisc sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitat ullamco laboris nisi ut aliquip commodo consequat."
    },
    {
      "title": "",
      "id": 6,
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipisc sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitat ullamco laboris nisi ut aliquip commodo consequat."
    },
  ];
}
