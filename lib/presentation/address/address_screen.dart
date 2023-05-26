import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:BikeX/presentation/commonWidgets/app_text_field.dart';
import 'package:BikeX/presentation/commonWidgets/comman_widgets.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "Address",
        leading: "back",
        action: true,
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            summary(),
            heading("User Name"),
            const AppTextField(
              border: true,
              hintText: "User Name",
              color: Colors.white,
            ),
            heading("Mobile No."),
            const AppTextField(
              border: true,
              hintText: "Mobile No.",
              color: Colors.white,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading("Pick Loction"),
                      const AppTextField(
                        border: true,
                        hintText: "Pick Loction",
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading("Drop Loction"),
                      const AppTextField(
                        border: true,
                        hintText: "Drop Loction",
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading("Time"),
                      const AppTextField(
                        border: true,
                        hintText: "Time",
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading("Date"),
                      const AppTextField(
                        border: true,
                        hintText: "Date",
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading("Inquiry Type"),
                      const AppTextField(
                        border: true,
                        hintText: "Inquiry Type",
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading("Car Type"),
                      const AppTextField(
                        border: true,
                        hintText: "Car Type",
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: AppButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.checkoutListScreen);
                },
                width: Get.width / 2,
                text: "Save",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summary() {
    return Row(
      children: [
        Image.asset(ImageConstant.fortunercar),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Fortuner",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            const Text(
              "Tesla Model s Plaid",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            Text(
              "100+ Trips",
              style: TextStyle(
                  color: AppColors.subTextColor, fontWeight: FontWeight.w300),
            ),
          ],
        )
      ],
    );
  }
}
