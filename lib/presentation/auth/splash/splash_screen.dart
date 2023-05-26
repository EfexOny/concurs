// import 'package:codecanyon_app/core/utils/app_color.dart';
// import 'package:codecanyon_app/core/utils/image_constant.dart';
// import 'package:get/get.dart';
// import 'splash_controller.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Get.put(SplashController());
//     return Scaffold(
//       body: Align(
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image(
//               image: AssetImage(ImageConstant.appIcon),
//               fit: BoxFit.contain,
//               height: Get.width * 0.3,
//               width: Get.width * 0.3,
//             ),
//             SizedBox(height: 15),
//             Text(
//               'Dating apps',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: Get.height * 0.030,
//                 color:
//                     Get.isDarkMode ? Colors.white54 : AppColors.fireBrickColor,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
