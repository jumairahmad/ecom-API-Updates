import 'package:e_commerce/screens/AddPayment/AddPaymentScreen.dart';
import 'package:e_commerce/screens/Address/AddressList.dart';
import 'package:e_commerce/screens/Address/CustomGooglePlaces.dart';
import 'package:e_commerce/screens/Address/NewAddress.dart';
import 'package:e_commerce/screens/Address/SaveAddress.dart';
import 'package:e_commerce/screens/Coupons/CouponScreen.dart';
import 'package:e_commerce/screens/DealsListAll/DealsListAllScreen.dart';
import 'package:e_commerce/screens/LoyaltyHistory/LoyaltyHistory_Screen.dart';
import 'package:e_commerce/screens/Notification/NotificationScreen.dart';
import 'package:e_commerce/screens/OrderFailure/order_failure.dart';
import 'package:e_commerce/screens/OrderHistory/OrderHistoryScreen.dart';
import 'package:e_commerce/screens/OrderView/order_view_screen.dart';
import 'package:e_commerce/screens/Profile/MyProfile.dart';
import 'package:e_commerce/screens/Profile/ProfileScreen.dart';
import 'package:e_commerce/screens/RedeemRewards/RedeemRewardsScreen.dart';
import 'package:e_commerce/screens/Rewards/Rewards_Screen.dart';
import 'package:e_commerce/screens/SignScreen/change_password.dart';
import 'package:e_commerce/screens/SignScreen/otpPage.dart';
import 'package:e_commerce/screens/SingleDealScreen/SingleDealScreen.dart';
import 'package:e_commerce/screens/screens.dart';
import 'package:e_commerce/screens/CardDetailScreen/CardDetailScreen.dart';
import 'package:e_commerce/screens/OrderLocation/map_screen.dart';
import 'package:e_commerce/screens/Order/OrderScreen.dart';
import 'package:e_commerce/screens/OrderTrack/OrderTrackScreen.dart';
import 'package:e_commerce/screens/Search/search_screen.dart';
import 'package:e_commerce/screens/SignScreen/forgot_password_screen.dart';
import 'package:e_commerce/screens/SignScreen/sign_in_screen.dart';
import 'package:e_commerce/screens/SignScreen/sign_up_screen.dart';
import 'package:e_commerce/screens/SingleItem/SingleItemScreen.dart';
import 'package:e_commerce/screens/Splash/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/screens/Home/HomeScreen.dart';

import 'screens/CurbSide/CurbSideOrder/curbside_order_screen.dart';
import 'screens/CurbSide/HowItWorks.dart';

import 'screens/CurbSide/SelectColor/selectcolor_screen.dart';
import 'screens/CurbSide/SelectVehicle/select_vehicle_screen.dart';
import 'screens/OrderLocation/Search.dart';
import 'screens/OrderStatus/OrderStatusScreen.dart';
import 'screens/OrderSuccess/order_success_screen.dart';
import 'screens/SingleItem/CustomizeOrder.dart';
import 'package:e_commerce/screens/Stores/StoresScreen.dart';

// variable for our route names
const String homePage = 'home';
const String addressListPage = 'addressList';
const String newAddressPage = 'newAddress';
const String saveAddressPage = 'saveAddressPage';
const String storesScreenPage = 'storescreenpage';
const String orderStatusPage = 'orderStatusPage';
const String customGooglePlacesPage = 'customGooglePlacesPage';

const String loginPage = 'login';
const String registerPage = 'register';
const String forgotPasswordPage = 'forgotPassword';
const String otpPage = 'otpPage';
const String changePasswordPage = 'changePassword';

const String cardDetailPage = 'cardDetail';

const String deliveryPage = 'delivery';
const String detailsPage = 'details';

const String orderPage = 'order';
const String orderSuccessPage = 'orderSuccess';
const String orderFailurePage = 'orderFailure';
const String orderTrackPage = 'orderTrack';
const String orderViewPage = 'orderView';

const String searchLocationsPage = 'search';
const String singleItemPage = 'singleItem';
const String singleDetailPage = 'singleDetail';
const String splash = 'splash';
const String screensPage = 'screens';
const String searchPage = 'search';
const String profilePage = 'profile';
const String myProfilePage = 'myProfile';
const String notificationPage = 'notification';
const String orderHistoryPage = 'orderHistory';
const String searchMapPage = 'searchMap';
const String addNewPaymentPage = 'addPaymentMap';
const String customizeOrderPage = 'customizeOrder';
const String couponPage = 'coupon';
const String redeemRewardsPage = 'redeemRewards';
const String rewardsPage = 'rewards';
const String loyaltyHistoryPage = 'loyaltyHistory';
const String dealListALlPage = 'deallistallpage';
const String curbSideHowItWorks = 'curbSideHowItWorks';
const String curbSideSelectVehicle = 'curbSideSelectVehicle';
const String curbSideSelectColor = 'curbSideSelectColor';
const String curbSideSelect = 'curbSideSelect';

// controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case orderStatusPage:
      return MaterialPageRoute(builder: (context) => OrderStatusScreen());
    case curbSideHowItWorks:
      return MaterialPageRoute(builder: (context) => (CurbLayout()));
    case curbSideSelectVehicle:
      return MaterialPageRoute(builder: (context) => SelectVehicleScreen());
    case curbSideSelectColor:
      return MaterialPageRoute(builder: (context) => SelectColorScreen());
    case curbSideSelect:
      return MaterialPageRoute(builder: (context) => CurbSideOrderScreen());

    case customGooglePlacesPage:
      return MaterialPageRoute(builder: (context) => CustomGoogleSearch());
    case profilePage:
      return MaterialPageRoute(builder: (context) => ProfileScreen());
    case storesScreenPage:
      return MaterialPageRoute(builder: (context) => StoresScreen());
    case addressListPage:
      return MaterialPageRoute(builder: (context) => AddressList());
    case saveAddressPage:
      return MaterialPageRoute(builder: (context) => SaveAddress());
    case newAddressPage:
      return MaterialPageRoute(builder: (context) => NewAddress());
    case rewardsPage:
      return MaterialPageRoute(builder: (context) => RewardsScreen());
    case couponPage:
      return MaterialPageRoute(builder: (context) => CouponScreen());
    case loyaltyHistoryPage:
      return MaterialPageRoute(builder: (context) => LoyaltyHistoryScreen());
    case redeemRewardsPage:
      return MaterialPageRoute(builder: (context) => RedeemRewardsScreen());
    case customizeOrderPage:
      return MaterialPageRoute(builder: (context) => CustomizeOrder1());
    case otpPage:
      return MaterialPageRoute(builder: (context) => OtpPage());
    case addNewPaymentPage:
      return MaterialPageRoute(builder: (context) => AddNewPayment());
    case changePasswordPage:
      return MaterialPageRoute(builder: (context) => ChangePasswordScreen());
    case myProfilePage:
      return MaterialPageRoute(builder: (context) => MyProfileScreen());
    case notificationPage:
      return MaterialPageRoute(builder: (context) => NotificationScreen());
    case orderHistoryPage:
      return MaterialPageRoute(builder: (context) => OrderHistory());
    case screensPage:
      return MaterialPageRoute(builder: (context) => Screens());
    case searchPage:
      return MaterialPageRoute(builder: (context) => SearchScreen());
    case loginPage:
      return MaterialPageRoute(builder: (context) => SignInScreen());
    case homePage:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case registerPage:
      return MaterialPageRoute(builder: (context) => SignUpScreen());
    case forgotPasswordPage:
      return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
    case cardDetailPage:
      return MaterialPageRoute(builder: (context) => CardDetailScreen());
    case deliveryPage:
      return MaterialPageRoute(builder: (context) => Mapscreen());

    case orderPage:
      return MaterialPageRoute(builder: (context) => OrderScreen());
    case orderSuccessPage:
      return MaterialPageRoute(builder: (context) => OrderSuccess());

    case orderFailurePage:
      return MaterialPageRoute(builder: (context) => OrderFailure());

    case orderTrackPage:
      return MaterialPageRoute(builder: (context) => OrderTrackScreen());
    case dealListALlPage:
      return MaterialPageRoute(builder: (context) => DealsListAllScreen());
    case orderViewPage:
      return MaterialPageRoute(builder: (context) => OrderViewScreen());
    case singleItemPage:
      return MaterialPageRoute(builder: (context) => SingleItemScreen());
    case singleDetailPage:
      return MaterialPageRoute(builder: (context) => SingleDealScreen());
    case searchMapPage:
      return MaterialPageRoute(builder: (context) => LocationSearch());
    case splash:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    default:
      throw ('this route name does not exist');
  }
}
