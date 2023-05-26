import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:BikeX/presentation/privacyPolicy/privacy_policy_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({Key? key}) : super(key: key);
  final PrivacyPolicyController _con = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(leading: "back", text: "Privacy Policy"),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Privacy Policy",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _con.termsConditionList.length,
                itemBuilder: (BuildContext context, int index) {
                  return (privacyPolicyItem(index));
                }),
          ),
          AppButton(
            width: Get.width / 2,
            text: "Done",
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }

  privacyPolicyItem(index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _con.termsConditionList[index]['title'] != ''
                ? Text(
                    _con.termsConditionList[index]['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Get.isDarkMode ? Colors.grey : Colors.black,
                      fontSize: 20.0,
                    ),
                  )
                : Container(),
            _con.termsConditionList[index]['title'] != ''
                ? const SizedBox(
                    height: 10,
                  )
                : Container(),
            _con.termsConditionList[index]['description'] != ''
                ? Text(
                    _con.termsConditionList[index]['description'],
                    style: TextStyle(
                        color:
                            Get.isDarkMode ? Colors.white24 : Colors.blueGrey,
                        fontSize: 16.0,
                        height: 1.5),
                  )
                : Container(),
          ],
        ),
      );
}
