import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/myProfile/my_profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({Key? key}) : super(key: key);
  final MyProfileController _con = Get.put(MyProfileController());
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: Get.height * .14,
                      width: Get.height * .14,
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
                    children: [
                      Text(user!.email!),
                      const SizedBox(height: 10),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('email', isEqualTo: user!.email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isNotEmpty) {
                              int points =
                                  snapshot.data!.docs[0].get('points') ?? 0;
                              return Text(
                                'Points: $points',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              );
                            } else {
                              return Text(
                                'User not found',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error loading user',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ..._con.myProfileList
                  .asMap()
                  .map(
                    (i, value) => MapEntry(
                      i,
                      GestureDetector(
                        onTap: () {
                          i == 0
                              ? Get.toNamed(AppRoutes.rideHistoryScreen)
                              : Get.toNamed(AppRoutes.editProfileScreen);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.only(bottom: 10),
                          width: Get.height,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Image.asset(_con.myProfileList[i].image!),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                _con.myProfileList[i].text!,
                                style: const TextStyle(color: Colors.black),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Color(0xffB5B5B5),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
              const SizedBox(
                height: 10,
              ),
              logoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Get.offAllNamed(AppRoutes.loginScreen);
        // Get.toNamed(AppRoutes.loginScreen);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 40,
            maxHeight: 50,
          ),
          width: Get.width / 2,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageConstant.logout),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget doc({String? text, String? image}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          height: Get.height * .13,
          width: Get.height * .13,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 20,
                offset: Offset(0.5, 0.6),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text!,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(image!)
            ],
          )),
    );
  }
}
