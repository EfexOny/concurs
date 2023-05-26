import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/bottomBar/bottombar_controller.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/discover/discover_screen.dart';
import 'package:BikeX/presentation/myProfile/my_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({Key? key}) : super(key: key);
  final BottomBarController _con = Get.put(BottomBarController());
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
        child: ZoomDrawer(
            controller: _con.zoomDrawerController,
            borderRadius: 24,
            style: DrawerStyle.Style1,
            openCurve: Curves.fastOutSlowIn,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.4,
                ),
                blurRadius: 1.20,
                offset: const Offset(0.5, 0.6),
              )
            ],
            disableGesture: true,
            mainScreenTapClose: true,
            slideWidth: Get.width * 0.75,
            duration: const Duration(milliseconds: 500),
            backgroundColor: Colors.red,
            showShadow: false,
            angle: -8,
            clipMainScreen: true,
            mainScreen: Scaffold(
              appBar: _con.pageIndex.value == 0
                  ? appBar(
                      onTap: () {
                        _con.zoomDrawerController.toggle!();
                      },
                      text: "Rent",
                      action: true,
                      leading: "menu",
                      onPressed: () {},
                    )
                  : appBar(
                      text: "My Profile",
                      action: true,
                      leading: "",
                      onPressed: () {},
                    ),
              body: _con.pageIndex.value == 0
                  ? DiscoverScreen()
                  : _con.pageIndex.value == 1
                      ? MyProfileScreen()
                      : DiscoverScreen(),
              bottomNavigationBar: bottombar(),
            ),
            menuScreen: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: Get.height * .08,
                          width: Get.height * .08,
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                          ),
                          child: Image.network(
                            "https://static.toiimg.com/thumb/msid-68865435,width-800,height-600,resizemode-75,imgsize-179723,pt-32,y_pad-40/68865435.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user!.email!),
                          Row(
                            children: [
                              Text(
                                "Edit profile",
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                ImageConstant.edit,
                                height: 10,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      color: AppColors.containerBorderColor,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: Get.width / 1.7,
                      child: ListView.builder(
                          itemCount: _con.drawerList.length,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => GestureDetector(
                                onTap: () {
                                  _con.drawer.value = index;
                                       _con.drawer.value == 0
                                          ? Get.toNamed(
                                              AppRoutes.rideHistoryScreen)
                                          : _con.drawer.value == 1
                                              ? Get.toNamed(
                                                  AppRoutes.MapScreen)
                                                  : _con.drawer.value == 2
                                                ? Get.toNamed(
                                                    AppRoutes.garbageMap)
                                                    : _con.drawer.value == 3
                                                ? Get.toNamed(
                                                    AppRoutes.adminPage)
                                                //: _con.drawer.value == 3
                                              //? Get.toNamed(AppRoutes.adminScreen)
                                              : null;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _con.drawer.value == index
                                          ? AppColors.primaryColor
                                          : AppColors.secondaryColor),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        _con.drawerList[index][1],
                                        color: _con.drawer.value == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _con.drawerList[index][0],
                                        style: TextStyle(
                                          color: _con.drawer.value == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.chevron_right,
                                        color: _con.drawer.value == index
                                            ? Colors.white
                                            : AppColors.containerBorderColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  bottombar() {
    return Container(
      margin: const EdgeInsets.all(12),
      height: 70,
      width: Get.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.4,
            ),
            blurRadius: 1.20,
            offset: const Offset(0.5, 0.6),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _con.icons.length,
          (index) => Obx(
            () => IconButton(
              onPressed: () {
                _con.pageIndex.value = index;
              },
              icon: Image.asset(
                _con.pageIndex.value == index
                    ? _con.icons[index][1]
                    : _con.icons[index][0],
                height: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// ListTile(
//                               leading: Image.asset(
//                                 _con.drawerList[index][1],
//                               ),
//                               title: Text(
//                                 _con.drawerList[index][0],
//                                 style: const TextStyle(color: Colors.black),
//                               ),
//                               trailing: Icon(
//                                 Icons.arrow_forward_ios_outlined,
//                                 color: AppColors.containerBorderColor,
//                               ),
//                             );
