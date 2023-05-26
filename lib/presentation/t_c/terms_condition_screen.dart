import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:BikeX/presentation/t_c/terms_condition_screen_controller.dart';
import 'package:flutter/material.dart';

class TermsConditionScreen extends StatelessWidget {
  TermsConditionScreen({Key? key}) : super(key: key);
  final TermsConditionScreenController _con =
      Get.put(TermsConditionScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "T&C", leading: "back"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _con.termsConditionList.length,
                itemBuilder: (BuildContext context, int index) {
                  return (termsConditionItem(index));
                }),
          ),
          AppButton(
            onPressed: () {
              Get.back();
            },
            text: "Accept Terms",
            width: Get.width / 2,
          )
        ],
      ),
    );
  }

  termsConditionItem(index) => Container(
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
            _con.termsConditionList[index]['subTitle'] != ''
                ? Text(
                    _con.termsConditionList[index]['subTitle'],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Get.isDarkMode ? Colors.grey : Colors.black,
                      fontSize: 16.0,
                    ),
                  )
                : Container(),
            _con.termsConditionList[index]['subTitle'] != ''
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
