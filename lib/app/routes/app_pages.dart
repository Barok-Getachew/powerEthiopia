import 'package:get/get.dart';

import '../modules/NotificationScreen/bindings/notification_screen_binding.dart';
import '../modules/NotificationScreen/views/notification_screen_view.dart';
import '../modules/PlayingScreen/bindings/playing_screen_binding.dart';
import '../modules/PlayingScreen/views/playing_screen_view.dart';
import '../modules/ProductDetail/bindings/product_detail_binding.dart';
import '../modules/ProductDetail/views/product_detail_view.dart';
import '../modules/TrainingDetailPage/bindings/training_detail_page_binding.dart';
import '../modules/TrainingDetailPage/views/training_detail_page_view.dart';
import '../modules/cartScreen/bindings/cart_screen_binding.dart';
import '../modules/cartScreen/views/cart_screen_view.dart';
import '../modules/checkOutScreen/bindings/check_out_screen_binding.dart';
import '../modules/checkOutScreen/views/check_out_screen_view.dart';
import '../modules/coursesPage/bindings/courses_page_binding.dart';
import '../modules/coursesPage/views/courses_page_view.dart';
import '../modules/credit/creditFormView/bindings/credit_form_view_binding.dart';
import '../modules/credit/creditFormView/views/credit_form_view_view.dart';
import '../modules/credit/creditScreen/bindings/credit_screen_binding.dart';
import '../modules/credit/creditScreen/views/credit_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/myOrder/bindings/my_order_detail_binding.dart';
import '../modules/myOrder/views/my_order_detail_view.dart';
import '../modules/onboarding_register/aboutus_onboarding/bindings/aboutus_onboarding_binding.dart';
import '../modules/onboarding_register/aboutus_onboarding/views/aboutus_onboarding_view.dart';
import '../modules/onboarding_register/second_aboutus/bindings/second_aboutus_binding.dart';
import '../modules/onboarding_register/second_aboutus/views/second_aboutus_view.dart';
import '../modules/onboarding_register/third_aboutus/bindings/third_aboutus_binding.dart';
import '../modules/onboarding_register/third_aboutus/views/third_aboutus_view.dart';
import '../modules/pdfViewerPage/bindings/pdf_viewer_page_binding.dart';
import '../modules/pdfViewerPage/views/pdf_viewer_page_view.dart';
import '../modules/profileScreen/bindings/delivery_address_binding.dart';
import '../modules/profileScreen/bindings/profile_screen_binding.dart';
import '../modules/profileScreen/bindings/update_profile_binding.dart';
import '../modules/profileScreen/sub_pages/delivery_address_screen.dart';
import '../modules/profileScreen/sub_pages/update_profile_screen.dart';
import '../modules/profileScreen/views/profile_screen_view.dart';
import '../modules/registration_payment/bindings/registration_payment_binding.dart';
import '../modules/registration_payment/views/registration_payment_view.dart';
import '../modules/shopScreen/bindings/shop_screen_binding.dart';
import '../modules/shopScreen/views/shop_screen_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/trainingCategoryScreen/bindings/training_category_screen_binding.dart';
import '../modules/trainingCategoryScreen/views/training_screen_view.dart';
import '../modules/videoViewerPage/bindings/video_viewer_page_binding.dart';
import '../modules/videoViewerPage/views/video_viewer_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.language,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.aboutusOnboarding,
      page: () => const AboutusOnboardingView(),
      binding: AboutusOnboardingBinding(),
    ),
    GetPage(
      name: _Paths.thirdAboutusOnboarding,
      page: () => const ThirdAboutusView(),
      binding: ThirdAboutusBinding(),
    ),
    GetPage(
      name: _Paths.secondAboutusOnboarding,
      page: () => const SecondAboutusView(),
      binding: SecondAboutusBinding(),
    ),
    GetPage(
      name: _Paths.registrationPayment,
      page: () => const RegistrationPaymentView(),
      binding: RegistrationPaymentBinding(),
    ),
    GetPage(
      name: _Paths.trainingCategoryScreen,
      page: () => const TrainingCategoryScreenView(),
      binding: TrainingCategoryScreenBinding(),
    ),
    GetPage(
      name: _Paths.shopScreen,
      page: () => ShopScreenView(),
      binding: ShopScreenBinding(),
    ),
    GetPage(
      name: _Paths.creditScreen,
      page: () => const CreditScreenView(),
      binding: CreditScreenBinding(),
    ),
    GetPage(
      name: _Paths.profileScreen,
      page: () => const ProfileScreenView(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: _Paths.coursesPage,
      page: () => const CoursesPageView(),
      binding: CoursesPageBinding(),
    ),
    GetPage(
      name: _Paths.trainingDetailPage,
      page: () => const TrainingDetailPageView(),
      binding: TrainingDetailPageBinding(),
    ),
    GetPage(
      name: _Paths.playingScreen,
      // arguments: {'isOnlyPdf': 'false'},
      page: () => const PlayingScreenView(),
      binding: PlayingScreenBinding(),
    ),
    GetPage(
      name: _Paths.notificationScreen,
      page: () => const NotificationScreenView(),
      binding: NotificationScreenBinding(),
    ),
    GetPage(
      name: _Paths.productDetail,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: _Paths.cartScreen,
      page: () => const CartScreenView(),
      binding: CartScreenBinding(),
    ),
    GetPage(
      name: _Paths.checkoutScreen,
      page: () => const CheckOutScreenView(),
      binding: CheckOutScreenBinding(),
    ),
    GetPage(
      name: _Paths.updateProfileScreen,
      page: () => const UpdateProfileScreen(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.deliveryAddress,
      page: () => const DeliveryAddressScreen(),
      binding: DeliveryAddressBinding(),
    ),
    GetPage(
      name: _Paths.creditFormView,
      page: () => const CreditFormViewView(),
      binding: CreditFormViewBinding(),
    ),
    GetPage(
      name: _Paths.pdfViewPage,
      page: () => const PdfViewerPageView(),
      binding: PdfViewerPageBinding(),
    ),
    GetPage(
      name: _Paths.videoViewerPage,
      page: () => const VideoViewerPageView(),
      binding: VideoViewerPageBinding(),
    ),
    GetPage(
      name: _Paths.myOrderPage,
      page: () => const MyOrderDetailView(),
      binding: MyOrderDetailBinding(),
    ),
  ];
}
