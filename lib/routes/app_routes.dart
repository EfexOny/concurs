import 'package:BikeX/presentation/address/address_screen.dart';
import 'package:BikeX/presentation/admin/admin_screen.dart';
import 'package:BikeX/presentation/auth/changePassword/change_password.dart';
import 'package:BikeX/presentation/auth/createNewPassword/create_new_password.dart';
import 'package:BikeX/presentation/auth/forgotPassword/forgot_password.dart';
import 'package:BikeX/presentation/auth/login/login_screen.dart';
import 'package:BikeX/presentation/auth/otpScreen/otp_screen.dart';
import 'package:BikeX/presentation/auth/signUp/sign_up.dart';
import 'package:BikeX/presentation/auth/wellcomeSlider/wellcome_screen.dart';
import 'package:BikeX/presentation/bottomBar/bottombar_screen.dart';
import 'package:BikeX/presentation/discover/discover_screen.dart';
import 'package:BikeX/presentation/language/language.dart';
import 'package:BikeX/presentation/map/map_screen.dart';
import 'package:BikeX/presentation/map/red_markers.dart';
import 'package:BikeX/presentation/privacyPolicy/privacy_policy_screen.dart';
import 'package:BikeX/presentation/rent/rent_screen.dart';
import 'package:BikeX/presentation/ridehistory/ride_history_screen.dart';
import 'package:BikeX/presentation/t_c/terms_condition_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static String discoverScreen = '/discoverScreen';
  static String MapScreen = '/MapScreen';
  static String detailsScreen = '/detailsScreen';
  static String availableScreen = '/availableScreen';
  static String bottomBarScreen = '/bottomBarScreen';
  static String editProfileScreen = '/editProfileScreen';
  static String paymentMethodScreen = '/paymentMethodScreen';
  static String checkoutScreen = '/checkoutScreen';
  static String checkoutListScreen = '/checkoutListScreen';
  static String addressScreen = '/addressScreen';
  static String rideHistoryScreen = '/rideHistoryScreen';
  static String rideDetailsScreen = '/rideDetailsScreen';
  static String chatScreen = '/chatScreen';
  static String filterScreen = '/filterScreen';
  static String loginScreen = '/loginScreen';
  static String wellcomeScreen = '/wellcomeScreen';
  static String signUpScreen = '/signUpScreen';
  static String forgotPasswordScreen = '/forgotPasswordScreen';
  static String otpScreen = '/otpScreen';
  static String createNewPasswordScreen = '/createNewPasswordScreen';
  static String thankYouScreen = '/thankYouScreen';
  static String settingScreen = '/settingScreen';
  static String languageListScreen = '/languageListScreen';
  static String searchScreen = '/searchScreen';
  static String privacyPolicyScreen = '/privacyPolicyScreen';
  static String termsConditionScreen = '/termsConditionScreen';
  static String aboutUsScreen = '/aboutUsScreen';
  static String changePasswordScreen = '/changePasswordScreen';
  static String rentScreen = '/rentScreen';
  static String garbageMap = '/garbageMap';
  static String adminPage = '/adminPage';

  static List<GetPage> pages = [
    GetPage(name: adminPage, page: () => AdminPage()),
    GetPage(name: MapScreen, page: () => ManyMarkersPage()),
    GetPage(name: garbageMap, page: () => GarbageMap()),
    GetPage(name: rentScreen, page: () => RentScreen()),
    GetPage(name: rideHistoryScreen, page: () => RideHistoryScreen()),
    GetPage(name: discoverScreen, page: () => DiscoverScreen()),
    GetPage(name: bottomBarScreen, page: () => BottomBarScreen()),
    GetPage(name: addressScreen, page: () => const AddressScreen()),
    GetPage(name: wellcomeScreen, page: () => WellcomeScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignupScreen()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(name: otpScreen, page: () => OtpScreen()),
    GetPage(
        name: createNewPasswordScreen, page: () => CreateNewPasswordScreen()),
    GetPage(name: languageListScreen, page: () => LanguageListScreen()),
    GetPage(name: privacyPolicyScreen, page: () => PrivacyPolicyScreen()),
    GetPage(name: termsConditionScreen, page: () => TermsConditionScreen()),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
  ];
}
