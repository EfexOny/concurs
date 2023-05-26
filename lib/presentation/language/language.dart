import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:BikeX/presentation/language/language_con.dart';
import 'package:flutter/material.dart';

class LanguageListScreen extends StatelessWidget {
  LanguageListScreen({Key? key}) : super(key: key);
  final LanguageController _con = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "Language",
        action: true,
        leading: "back",
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "What language do you want?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 20),
              _searchBox(),
              const SizedBox(height: 20),
              ...LocalizationService.langs.map((String lan) {
                return Column(
                  children: [
                    tileWidget(
                      onTap: () {
                        _con.lang.value = lan;
                      },
                      title: lan,
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),
              const SizedBox(height: 20),
              Center(
                child: AppButton(
                  onPressed: () =>
                      {LocalizationService().changeLocale(_con.lang.value)},
                  width: Get.width / 2,
                  text: "Confirm Language",
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget tileWidget({
    Function()? onTap,
    String? title,
  }) =>
      Obx(
        () => GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: title == _con.lang.value
                    ? AppColors.primaryColor
                    : const Color(0xffD4D4D4),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    color: title == _con.lang.value
                        ? AppColors.primaryColor
                        : Colors.black,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: title == _con.lang.value
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: title == _con.lang.value
                      ? const Center(
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 10,
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      );
  Widget _searchBox() {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    0.4,
                  ),
                  blurRadius: 1.20,
                  offset: const Offset(0.5, 0.6),
                )
              ],
            ),
            child: TextField(
              controller: _con.searchController,
              onSubmitted: (searchInfo) {},
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  prefixIcon: Image.asset(ImageConstant.search),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          alignment: Alignment.center,
          width: 50,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.4,
                ),
                blurRadius: 1.20,
                offset: const Offset(0.5, 0.6),
              )
            ],
          ),
          child: Image.asset(ImageConstant.filter2),
        )
      ],
    );
  }
}
