// ignore_for_file: unnecessary_overrides

import 'dart:async';

import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:ethiosolar_app/app/data/models/training/course_model.dart';
import 'package:ethiosolar_app/app/data/models/training/course_response.model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:ethiosolar_app/app/core/utils/store/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class PlayingScreenController extends GetxController {
  RxInt currentIndex = 0.obs;
  late int trainingId;
  final RxList<CourseModel> courseList =
      List<CourseModel>.empty(growable: true).obs;

  PdfViewerController pdfController = PdfViewerController();
  RxBool isTrainingCategoryTrainingsLoading = false.obs;
  String? token;
  final List<VideoController> videoControllers = [];
  final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller;
  late final WebViewController webViewController;

  Future<void> getTrainingCourses() async {
    isTrainingCategoryTrainingsLoading(true);

    try {
      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        endPoint: "${ApiConstant.kgetTrainingCourseApi}$trainingId",
        mHeader: {
          "Authorization": "Bearer $token",
        },
      );
      if (response is BaseResponse) {
        CourseResponseModel trainingResponseModel = CourseResponseModel(
            courseList: CourseModel.fromJsonList(response.results));
        courseList.addAll(trainingResponseModel.courseList ?? []);
        debugPrint('courseList$courseList');
      }
    } finally {
      isTrainingCategoryTrainingsLoading(false);
    }
  }

  Future<void> getUserToken() async {
    token = await UserSession.getUserToken();
  }

  void nextVideo() {
    if (currentIndex.value < courseList.length - 1) {
      // Increment the current video index
      currentIndex.value++;
      webViewController.loadHtmlString(getIframe(
          fileId: courseList[currentIndex.value].videoUrl.toString()));

      // Open the next video
      // player.open(Media(Utils.concatenateGoogleDriveUrl(
      //     courseList[currentIndex.value].videoUrl ?? '')));
    }
  }

  void prevVideo() {
    if (currentIndex.value <= courseList.length - 1) {
      // Increment the current video index
      currentIndex.value--;
      webViewController.loadHtmlString(getIframe(
          fileId: courseList[currentIndex.value].videoUrl.toString()));

      // Open the next video
      // player.open(Media(Utils.concatenateGoogleDriveUrl(
      //     courseList[currentIndex.value].videoUrl ?? '')));
    }
  }

  late final TabController tabController;
  @override
  void onInit() {
    trainingId = Get.arguments;

    super.onInit();
  }

  @override
  void dispose() {
    player.dispose();
    pdfController.dispose();

    super.dispose();
  }

  @override
  void onReady() async {
    await getUserToken();

    await getTrainingCourses();

    late final PlatformWebViewControllerCreationParams params;

    params = const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.endsWith('/view')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            Get.snackbar("warning", "message");
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          Get.snackbar("", message.toString());
        },
      )
      ..loadHtmlString(getIframe(
          fileId: courseList[currentIndex.value].videoUrl.toString()));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    webViewController = controller;

    debugPrint(
        "courseList: ${courseList[0].videoUrl} and ${courseList[0].videoUrl}");
    List<Media> playlist = courseList
        .map((course) =>
            Media(Utils.concatenateGoogleDriveUrl(course.videoUrl ?? '')))
        .toList();

    debugPrint("playlist$playlist");
    debugPrint("playlistiindex${currentIndex.value}");
    debugPrint(
        "playlistiindex${courseList[currentIndex.value].pdfUrl.toString()}");
    debugPrint(
        "playlistiindex${courseList[currentIndex.value].videoUrl?.isEmpty.toString()}");

    // Create a Playlist from the list of Media objects
    // Playlist mediaPlaylist = Playlist(playlist);
    // final playable = Playlist(
    //   playlist,
    //   index: currentIndex.value,
    // );
    // // Open the playlist with the player
    // player.open(playable);

    super.onReady();
  }

  @override
  void onClose() {
    player.dispose();
    pdfController.dispose();

    super.onClose();
  }

  String getIframe({required String fileId}) {
    return '''
<iframe width="100%" height="100%" src="https://drive.google.com/file/d/$fileId/preview?showinfo=0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  ''';
  }

  String kLocalExamplePage = '''
<iframe width="100%" height="100%" src="https://drive.google.com/file/d/1n4fZmGEqOWGuc25rfdl7RA0nyfel2UCz/preview?showinfo=0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>',
        
''';
}
/*  <iframe
          title={aboutOnBoarding[next].title}
          src={`https://drive.google.com/file/d/${aboutOnBoarding[next].videoUrl}/preview?showinfo=0`}
          className="w-full h-[320px] md:h-[720px] "
          allow="autoplay"
          allowFullScreen
        ></iframe> */