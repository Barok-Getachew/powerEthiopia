class ApiConstant {
  static const String apiURL = "https://powerethio.com/app";
  static const String baseImageUrl = "https://powerethio.com/app/uploads/";

  //Endpoint

  static var kloginApi = "/auth/login";
  static var ksignUpApi = "/auth/register";
  static var kuploadSingleImage = "/uploads";
  static var kuploadMultipleImage = "/uploads/multiple";
  static var kgetUser = "/auth/user/";
  static var kgetBanks = "/payment";
  static var kgetTermAndCondition = "/termsAndCondition";
  static var kgetSingleTermAndCondition = "/termsAndCondition/";
  static var kpostRegPayment = "/registrationPayment";
  //about us onboarding registrationPayment
  static var kgetAboutUsOnboarding = "/aboutOnBoarding";

  //fetch Cities
  static var kgetCities = "/country";

// products endpoints
  static var kgetProducts = "/product";
  static var kgetProductDetails = "/product/";
  static var kSearchProduct = "/product/search/query";

  //fields
  static var accessToken = "Authorization";
  static var emailId = "emailid";
  static var selectedValue = "selectedValue";
  static var otp = "otp";
  static var password = "password";
  static var firstName = "first_name";
  static var lastName = "last_name";
  static var companyName = "company_name";
  static var userID = "userID";

  // Training API
  static String kgetTrainingCategoriesApi = "/trainingCategory";
  static String kgetTrainingCategoryDetailApi = "/trainingCategory/training";
  static String kgetTrainingCourseApi = "/course/training/";

  // Credit API
  static String kGetAllCreditCategories = "/creditCategory";
  static String kApplyForCredit = "/credit";

  // Carousel API
  static String kGetCarouselImages = "/carouselImage";

  // Product API
  static String kGetAllProduct = "/product";

  // Support API
  static String kGetSupport = "/support";

  // Address API
  static String kDeliveryAddress = "/deliveryAddress";
  static String kGetDeliveryAddress = "/deliveryAddress/user";

  // Profile
  static String kUpdateProfile = "/auth/user";

  // Feedback
  static String kFeedback = "/feedback";

  // Notification
  static String kNotification = "/notification";

  // Checkout
  static String kCheckout = "/checkout";
  // aboutUs
  static String kAboutUs = "/about";

  // Order API
  static String kGetMyOrders = "/checkout/user";
}
